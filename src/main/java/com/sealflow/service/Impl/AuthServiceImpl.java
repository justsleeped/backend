package com.sealflow.service.Impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.lang.Assert;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.sealflow.common.properties.TokenProperties;
import com.sealflow.common.util.JwtUtil;
import com.sealflow.common.util.RedisUtil;
import com.sealflow.model.entity.SysUser;
import com.sealflow.model.form.LoginForm;
import com.sealflow.model.form.RegisterForm;
import com.sealflow.model.vo.TokenVO;
import com.sealflow.service.IAuthService;
import com.sealflow.service.ISysUserService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

/**
 * 认证服务实现类
 */
@Service
@RequiredArgsConstructor
public class AuthServiceImpl implements IAuthService {

	private final ISysUserService userService;
	private final PasswordEncoder passwordEncoder;
	private final JwtUtil jwtUtil;
	private final TokenProperties tokenProperties;
	private final RedisUtil redisUtil;

	@Override
	public TokenVO login(LoginForm loginForm) {
		// 根据学号查询用户
		SysUser user = userService.getOne(
				new LambdaQueryWrapper<SysUser>().eq(SysUser::getUsername, loginForm.getUsername())
		);

		// 检查用户是否存在
		Assert.notNull(user, "用户不存在");

		// 检查用户状态
		Assert.state(user.getStatus() == 1, "用户已被禁用");

		// 验证密码
		Assert.state(passwordEncoder.matches(loginForm.getPassword(), user.getPassword()), "密码错误");

		// 生成JWT token
		Map<String, Object> claims = new HashMap<>();
		claims.put("userId", user.getId());
		claims.put("username", user.getUsername());
		String token = jwtUtil.createToken(claims, tokenProperties.getExpiration() / 1000);

		// 将token存入Redis，设置过期时间
		String redisKey = tokenProperties.getRedisTokenPrefix() + token;
		redisUtil.set(redisKey, user.getId(), tokenProperties.getExpiration() / 1000);

		return TokenVO.builder().accessToken(token).build();
	}

	@Override
	public Boolean register(RegisterForm registerForm) {
		// 检查学号是否已存在
		SysUser existingUser = userService.getOne(
				new com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<SysUser>().eq(SysUser::getUsername, registerForm.getUsername())
		);
		Assert.isNull(existingUser, "该学号已被注册");

		// 检查邮箱是否已存在
		existingUser = userService.getOne(
				new com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<SysUser>().eq(SysUser::getEmail, registerForm.getEmail())
		);
		Assert.isNull(existingUser, "该邮箱已被注册");

		// TODO: 验证邮箱验证码（这里暂时跳过，因为需要邮件服务集成）
		// 在实际应用中，应该验证邮箱验证码的有效性

		// 创建新用户
		SysUser newUser = new SysUser();
		BeanUtil.copyProperties(registerForm, newUser);
		newUser.setPassword(passwordEncoder.encode(registerForm.getPassword())); // 加密密码
		newUser.setStatus(1); // 默认启用

		// 保存用户
		return userService.save(newUser);
	}

	@Override
	public Boolean logout(String token) {
		// 删除Redis中的token
		String redisKey = tokenProperties.getRedisTokenPrefix() + token;
		return redisUtil.del(redisKey);
	}
}
