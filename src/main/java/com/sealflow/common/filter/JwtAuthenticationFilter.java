package com.sealflow.common.filter;

import com.sealflow.common.context.UserInfo;
import com.sealflow.common.context.UserContextHolder;
import com.sealflow.common.properties.TokenProperties;
import com.sealflow.common.util.JwtUtil;
import com.sealflow.common.util.RedisUtil;
import com.sealflow.service.ISysUserService;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpHeaders;
import org.springframework.lang.NonNull;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.HashSet;
import java.util.List;
import java.util.stream.Collectors;

@Component
@RequiredArgsConstructor
@Slf4j
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private final JwtUtil jwtUtil;
    private final ISysUserService userService;
    private final TokenProperties tokenProperties;
    private final RedisUtil redisUtil;

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
                        log.error("Invalid user ID format in token: {}, error: {}", userIdStr, e.getMessage());
                    }
                }

                if (userId != null) {
                    // 验证Redis中是否存在该用户的token（单点登录验证）
                    String redisKey = tokenProperties.getRedisTokenPrefix() + userId;
                    Object cachedToken = redisUtil.get(redisKey);
                    
                    // 检查token是否匹配（防止使用旧token）
                    if (cachedToken == null || !cachedToken.toString().equals(token)) {
                        log.warn("Token已失效或已被新登录替换: userId={}", userId);
                        filterChain.doFilter(request, response);
                        return;
                    }

                    // 获取用户权限
                    List<String> permissions = userService.getPermissions(userId);
                    List<SimpleGrantedAuthority> authorities = permissions.stream()
                            .map(SimpleGrantedAuthority::new)
                            .collect(Collectors.toList());

                    // 获取用户角色
                    List<String> roles = userService.getRole(userId);

                    // 构建用户信息对象，包含权限和角色
                    UserInfo userInfo = UserInfo.builder()
                            .userId(userId)
                            .roles(roles != null ? new HashSet<>(roles) : null)
                            .permissions(new HashSet<>(permissions))
                            .build();

                    // 设置到用户上下文
                    UserContextHolder.setCurrentUser(userInfo);

                    // 创建认证对象并设置到Spring Security上下文，包含用户权限
                    UsernamePasswordAuthenticationToken authToken = new UsernamePasswordAuthenticationToken(
                            userId.toString(), null, authorities);
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
