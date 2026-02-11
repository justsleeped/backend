package com.sealflow.controller;

import com.sealflow.common.Result.Result;
import com.sealflow.common.context.UserContextHolder;
import com.sealflow.model.form.LoginForm;
import com.sealflow.model.form.RegisterForm;
import com.sealflow.model.vo.TokenVO;
import com.sealflow.service.IAuthService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import jakarta.validation.Valid;

/**
 * 认证控制器
 */
@Tag(name = "认证管理")
@RestController
@RequestMapping("/v1/auth")
@RequiredArgsConstructor
public class AuthController {

    private final IAuthService authService;

    @Operation(summary = "用户登录")
    @PostMapping("/login")
    public Result<TokenVO> login(@Valid @RequestBody LoginForm loginForm) {
        TokenVO response = authService.login(loginForm);
        return Result.success(response);
    }

    @Operation(summary = "用户注册")
    @PostMapping("/register")
    public Result<Boolean> register(@Valid @RequestBody RegisterForm registerForm) {
        Boolean result = authService.register(registerForm);
        if (result) {
            return Result.success();
        } else {
            return Result.serverError("注册失败");
        }
    }

    @Operation(summary = "用户登出")
    @PostMapping("/logout")
    public Result<Boolean> logout() {
        // 从用户上下文获取当前用户ID
        Long userId = UserContextHolder.getCurrentUserId();
        if (userId == null) {
            return Result.badRequest("未找到用户信息");
        }

        Boolean result = authService.logout(userId);
        if (result) {
            return Result.success();
        } else {
            return Result.serverError("登出失败");
        }
    }

    @Operation(summary = "发送邮箱验证码")
    @PostMapping("/send-email-code")
    public Result<Boolean> sendEmailCode(@RequestParam String email) {
        Boolean result = authService.sendEmailCode(email);
        if (result) {
            return Result.success();
        } else {
            return Result.serverError("验证码发送失败");
        }
    }
}
