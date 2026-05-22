package com.sealflow.common.util;

import com.sealflow.common.properties.TokenProperties;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;

import javax.crypto.SecretKey;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

/**
 * JWT工具类
 * 提供JWT令牌的生成、验证、解析等功能
 * 使用 JJWT 库（Java 最流行的 JWT 库，线程安全）
 */
@Component
@RequiredArgsConstructor
public final class JwtUtil {

	private final TokenProperties tokenProperties;

	/**
	 * 获取签名密钥
	 */
	private SecretKey getSigningKey() {
		// 将普通字符串转换为符合 HS256 要求的密钥（至少 256 位/32 字节）
		String secret = tokenProperties.getSecret();
		// 如果密钥长度不足 32 字节，进行填充
		if (secret.length() < 32) {
			secret = String.format("%-32s", secret).replace(' ', '0');
		}
		return Keys.hmacShaKeyFor(secret.getBytes());
	}

	/**
	 * 生成JWT令牌
	 *
	 * @param claims     令牌 claims
	 * @param expiration 令牌有效期（秒）
	 * @return 生成的JWT令牌
	 */
	public String createToken(Map<String, Object> claims, long expiration) {
		Date now = new Date();
		Date expiryDate = new Date(now.getTime() + TimeUnit.SECONDS.toMillis(expiration));

		return Jwts.builder()
				.claims(claims)
				.issuedAt(now)
				.expiration(expiryDate)
				.signWith(getSigningKey())
				.compact();
	}

	/**
	 * 解析JWT令牌
	 *
	 * @param token JWT令牌
	 * @return 解析后的载荷
	 */
	public Map<String, Object> parsePayload(String token) {
		Claims claims = Jwts.parser()
				.verifyWith(getSigningKey())
				.build()
				.parseSignedClaims(token)
				.getPayload();

		return new HashMap<>(claims);
	}

	/**
	 * 获取用户id
	 */
	public String getUserId(String token) {
		Claims claims = Jwts.parser()
				.verifyWith(getSigningKey())
				.build()
				.parseSignedClaims(token)
				.getPayload();

		Object userId = claims.get("userId");
		return userId != null ? userId.toString() : null;
	}

	/**
	 * 验证 token
	 */
	public boolean verifyToken(String token) {
		if (StringUtils.isBlank(token)) {
			return false;
		}
		try {
			Jwts.parser()
					.verifyWith(getSigningKey())
					.build()
					.parseSignedClaims(token);
			return true;
		} catch (Exception e) {
			return false;
		}
	}
}
