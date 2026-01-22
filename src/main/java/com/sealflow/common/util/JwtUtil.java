package com.sealflow.common.util;


import cn.hutool.jwt.JWT;
import cn.hutool.jwt.JWTUtil;
import cn.hutool.jwt.signers.JWTSigner;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.Map;
import java.util.concurrent.TimeUnit;

/**
 * JWT工具类
 * 提供JWT令牌的生成、验证、解析等功能
 */
@Component
@RequiredArgsConstructor
public final class JwtUtil {

	private final JWTSigner signer; // 使用这个工具类需要自定义签名器

	/**
	 * 生成JWT令牌
	 *
	 * @param claims     令牌 claims
	 * @param expiration 令牌有效期 毫秒
	 * @return 生成的JWT令牌
	 */
	public String createToken(Map<String, Object> claims, long expiration) {
		return JWT.create()
				.addPayloads(claims)
				.setIssuedAt(new Date()) // 设置令牌签发时间
				.setExpiresAt(new Date(System.currentTimeMillis() + TimeUnit.SECONDS.toMillis(expiration))) // 设置令牌过期时间
				.setSigner(signer)
				.sign();
	}

	/**
	 * 解析JWT令牌
	 *
	 * @param token JWT令牌
	 * @return 解析后的载荷
	 */
    public Map<String, Object> parsePayload(String token) {
        return JWTUtil.parseToken(token)
                .setSigner(signer)
                .getPayloads();
    }

	/**
	 * 获取用户id
	 */
	public String getUserId(String token) {
		return (String) parsePayload(token).get("userId");
	}

	/**
	 * 验证 token
	 */
    public boolean verifyToken(String token) {
		if (StringUtils.isBlank(token)){ return false; }
        try {
            return JWTUtil.verify(token, signer);
        } catch (Exception e) {
            return false;
        }
    }
}
