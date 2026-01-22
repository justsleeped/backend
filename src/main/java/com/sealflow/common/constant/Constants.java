package com.sealflow.common.constant;

public class Constants {

	/**
	 * 私有构造函数，防止实例化
	 */
	private Constants() { }

	/**
     * Token 相关常量
     */
    public static final String TOKEN_SECRET = "BASE-JWT-SECRET-KEY-2026"; // 密钥
	public static final String TOKEN_HEADER = "Authorization"; // 请求头名称
    public static final String TOKEN_PREFIX = "Bearer "; // 请求头前缀
	public static final Long TOKEN_EXPIRATION = 24 * 60 * 60 * 1000L; // 过期时间
	public static final Long TOKEN_REFRESH_THRESHOLD = 7 * 24 * 60 * 60 * 1000L; // 刷新阈值

    /**
     * 字符编码
     */
    public static final String UTF8 = "UTF-8";

    /**
     * 默认页面大小
     */
    public static final int DEFAULT_PAGE_SIZE = 10;
    /**
     * 最大页面大小
     */
    public static final int MAX_PAGE_SIZE = 1000;

    /**
     * Redis Token 前缀
     */
    public static final String REDIS_TOKEN_PREFIX = "auth:token:";

	/**
	 * Trace ID 头
	 */
	public static final String TRACE_HEADER = "X-Trace-Id";
}
