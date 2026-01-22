package com.sealflow.common.properties;

import com.sealflow.common.constant.Constants;
import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

/**
 * 认证配置属性
 */
@Data
@Component
@ConfigurationProperties(prefix = "base.auth.token")
public class TokenProperties {

	/**
	 * 忽略认证的路径
	 */
	private List<String> ignorePaths = new ArrayList<>();

	/**
	 * JWT过期时间（毫秒）
	 */
	private Long expiration = Constants.TOKEN_EXPIRATION;

	/**
	 * 刷新Token阈值（毫秒）
	 */
	private Long refreshThreshold = Constants.TOKEN_REFRESH_THRESHOLD;

	/**
	 * Token前缀
	 */
	private String tokenPrefix = Constants.TOKEN_PREFIX;

	/**
	 * Token请求头名称
	 */
	private String tokenHeader = Constants.TOKEN_HEADER;

	/**
	 * Redis Token 前缀
	 */
	private String redisTokenPrefix = Constants.REDIS_TOKEN_PREFIX;

	/**
	 * JWT密钥
	 */
	private String secret = Constants.TOKEN_SECRET;
}
