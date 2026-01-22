package com.sealflow.service;

import com.sealflow.model.form.LoginForm;
import com.sealflow.model.form.RegisterForm;
import com.sealflow.model.vo.TokenVO;

/**
 * 认证服务接口
 */
public interface IAuthService {

    /**
     * 用户登录
     *
     * @param loginForm 登录表单
     * @return 登录响应信息（包含token和用户信息）
     */
    TokenVO login(LoginForm loginForm);

    /**
     * 用户注册
     *
     * @param registerForm 注册表单
     * @return 注册结果
     */
    Boolean register(RegisterForm registerForm);

    /**
     * 用户登出
     *
     * @param token 用户token
     * @return 登出结果
     */
    Boolean logout(String token);
}
