package com.sealflow.common.util;


import cn.hutool.jwt.JWT;
import cn.hutool.jwt.JWTUtil;
import cn.hutool.jwt.signers.JWTSigner;
import cn.hutool.jwt.signers.JWTSignerUtil;
import com.sealflow.common.properties.TokenProperties;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;

import java.nio.charset.StandardCharsets;
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

	private final TokenProperties tokenProperties;

	/**
	 * 生成JWT令牌
	 *
	 * @param claims     令牌 claims
	 * @param expiration 令牌有效期 毫秒
	 * @return 生成的JWT令牌
	 */
	public String createToken(Map<String, Object> claims, long expiration) {
		JWTSigner signer = createSigner();
		return JWT.create()
				.addPayloads(claims)
				.setIssuedAt(new Date())
				.setExpiresAt(new Date(System.currentTimeMillis() + TimeUnit.SECONDS.toMillis(expiration)))
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
		JWTSigner signer = createSigner();
        return JWTUtil.parseToken(token)
                .setSigner(signer)
                .getPayloads();
    }

	/**
	 * 获取用户id
	 */
public String getUserId(String token) {
    Map<String, Object> claims = parsePayload(token);
    Object userIdObj = claims.get("userId");
    return userIdObj != null ? userIdObj.toString() : null;
}

	/**
	 * 验证 token
	 */
    public boolean verifyToken(String token) {
		if (StringUtils.isBlank(token)){ return false; }
        try {
			JWTSigner signer = createSigner();
            return JWTUtil.verify(token, signer);
        } catch (Exception e) {
            return false;
        }
    }

	/**
	 * 创建新的签名器实例（线程安全）
	 */
	private JWTSigner createSigner() {
		return JWTSignerUtil.hs256(tokenProperties.getSecret().getBytes(StandardCharsets.UTF_8));
	}
}
