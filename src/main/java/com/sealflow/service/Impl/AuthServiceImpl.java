package com.sealflow.service.Impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.lang.Assert;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.sealflow.common.properties.TokenProperties;
import com.sealflow.common.util.JwtUtil;
import com.sealflow.common.util.RedisUtil;
import com.sealflow.common.util.VerificationCodeUtil;
import com.sealflow.model.entity.SysRole;
import com.sealflow.model.entity.SysUser;
import com.sealflow.model.form.LoginForm;
import com.sealflow.model.form.RegisterForm;
import com.sealflow.model.vo.TokenVO;
import com.sealflow.service.IAuthService;
import com.sealflow.service.IEmailService;
import com.sealflow.service.ISysRoleService;
import com.sealflow.service.ISysUserRoleService;
import com.sealflow.service.ISysUserService;
import com.sealflow.service.IdentitySyncService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 认证服务实现类
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class AuthServiceImpl implements IAuthService {

	private final ISysUserService userService;
	private final PasswordEncoder passwordEncoder;
	private final JwtUtil jwtUtil;
	private final TokenProperties tokenProperties;
	private final RedisUtil redisUtil;
	private final IEmailService emailService;
	private final ISysRoleService roleService;
	private final ISysUserRoleService userRoleService;
	private final IdentitySyncService identitySyncService;

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
		claims.put("userId", user.getId().toString());
		claims.put("username", user.getUsername());
		String token = jwtUtil.createToken(claims, tokenProperties.getExpiration() / 1000);

		// 将token存入Redis，设置过期时间（单点登录：userId作为key）
		String redisKey = tokenProperties.getRedisTokenPrefix() + user.getId();
		redisUtil.set(redisKey, token, tokenProperties.getExpiration() / 1000);

		// 查询用户角色
		List<String> role = userService.getRole(user.getId());

		return TokenVO.builder()
				.accessToken(token)
				.realName(user.getRealName())
				.role(role)
				.build();
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

		// 验证邮箱验证码
		String redisKey = VerificationCodeUtil.getRedisKey(registerForm.getEmail());
		Object cachedCode = redisUtil.get(redisKey);
		Assert.notNull(cachedCode, "验证码已过期，请重新获取");
		Assert.state(registerForm.getEmailCode().equals(cachedCode.toString()), "验证码错误");

		// 创建新用户
		SysUser newUser = new SysUser();
		BeanUtil.copyProperties(registerForm, newUser);
		newUser.setPassword(passwordEncoder.encode(registerForm.getPassword())); // 加密密码
		newUser.setStatus(1); // 默认启用

		// 保存用户
		boolean result = userService.save(newUser);

		// 同步用户到Flowable身份管理系统
		if (result) {
			identitySyncService.syncUserToFlowable(newUser);
		}

		// 注册成功后分配学生角色
		if (result) {
			// 删除验证码
			redisUtil.del(redisKey);
			// 查询学生角色
			SysRole studentRole = roleService.getOne(
					new LambdaQueryWrapper<SysRole>().eq(SysRole::getCode, "STUDENT")
			);

			// 分配学生角色
			if (studentRole != null) {
				userRoleService.setUserRoles(newUser.getId(), List.of(studentRole.getId()));
			} else {
				log.error("未找到学生角色，无法分配！");
			}
		}

		return result;
	}

	@Override
	public Boolean logout(Long userId) {
		// 删除Redis中的token（单点登录：userId作为key）
		String redisKey = tokenProperties.getRedisTokenPrefix() + userId;
		return redisUtil.del(redisKey);
	}

	@Override
	public Boolean sendEmailCode(String email) {
		// 检查邮箱是否已被注册
		SysUser existingUser = userService.getOne(
				new com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<SysUser>().eq(SysUser::getEmail, email)
		);
		Assert.isNull(existingUser, "该邮箱已被注册");

		// 生成验证码
		String code = VerificationCodeUtil.generateCode();
		String redisKey = VerificationCodeUtil.getRedisKey(email);

		// 检查是否已发送过验证码，防止频繁发送
		if (redisUtil.exists(redisKey)) {
			long expireTime = redisUtil.getExpire(redisKey);
			if (expireTime > 9 * 60) {
				throw new RuntimeException("验证码发送过于频繁，请稍后再试");
			} else {
				return true;
			}
		}

		// 发送邮件
		Boolean sendResult = emailService.sendVerificationCodeEmail(email, code);
		if (sendResult) {
			// 将验证码存入Redis，设置10分钟过期时间
			redisUtil.set(redisKey, code, VerificationCodeUtil.getExpireTime());
		}

		return sendResult;
	}
}
