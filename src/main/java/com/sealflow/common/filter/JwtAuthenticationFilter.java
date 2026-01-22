package com.sealflow.common.filter;

import com.sealflow.common.context.UserInfo;
import com.sealflow.common.context.UserContextHolder;
import com.sealflow.common.util.JwtUtil;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpHeaders;
import org.springframework.lang.NonNull;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

@Component
@RequiredArgsConstructor
@Slf4j
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private final JwtUtil jwtUtil;

    @Override
    protected void doFilterInternal(@NonNull HttpServletRequest request,
                                    @NonNull HttpServletResponse response,
                                    @NonNull FilterChain filterChain) throws ServletException, IOException {
        // 从请求头中提取JWT token
        String token = extractTokenFromRequest(request);

        if (token != null && jwtUtil.verifyToken(token)) {
            try {
                // 解析token获取用户信息
                String userIdStr = jwtUtil.getUserId(token);

                Long userId = null;
                if (userIdStr != null) {
                    try {
                        userId = Long.valueOf(userIdStr);
                    } catch (NumberFormatException e) {
                        log.error("Invalid user ID format in token: {}", userIdStr);
                    }
                }

                if (userId != null) {
                    // 构建用户信息对象
                    UserInfo userInfo = UserInfo.builder()
                            .userId(userId)
                            .build();

                    // 设置到用户上下文
                    UserContextHolder.setCurrentUser(userInfo);

                    // 创建认证对象并设置到Spring Security上下文
                    UsernamePasswordAuthenticationToken authToken = new UsernamePasswordAuthenticationToken(
                            userId.toString(), null, null);
                    SecurityContextHolder.getContext().setAuthentication(authToken);
                }
            } catch (Exception e) {
                log.error("Cannot set user authentication: {}", e.getMessage());
            }
        }

        try {
            filterChain.doFilter(request, response);
        } finally {
            // 请求完成后清理上下文，避免内存泄漏
            UserContextHolder.clear();
        }
    }

    private String extractTokenFromRequest(HttpServletRequest request) {
        String bearerToken = request.getHeader(HttpHeaders.AUTHORIZATION);
        if (StringUtils.hasText(bearerToken) && bearerToken.startsWith("Bearer ")) {
            return bearerToken.substring(7);
        }
        return null;
    }
}
