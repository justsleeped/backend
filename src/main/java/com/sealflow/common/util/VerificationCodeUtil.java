package com.sealflow.common.util;

import java.security.SecureRandom;

/**
 * 验证码生成工具类
 */
public class VerificationCodeUtil {

    private static final String NUMBERS = "0123456789";
    private static final SecureRandom random = new SecureRandom();

    private static final int CODE_LENGTH = 6;
    private static final long EXPIRE_TIME = 10 * 60;

    /**
     * 生成6位数字验证码
     *
     * @return 验证码
     */
    public static String generateCode() {
		return generateCode(CODE_LENGTH);
    }

    /**
     * 生成指定长度的数字验证码
     *
     * @param length 验证码长度
     * @return 验证码
     */
    public static String generateCode(int length) {
        StringBuilder code = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            code.append(NUMBERS.charAt(random.nextInt(NUMBERS.length())));
        }
        return code.toString();
    }

    /**
     * 获取验证码过期时间（秒）
     *
     * @return 过期时间（秒）
     */
    public static long getExpireTime() {
        return EXPIRE_TIME;
    }

    /**
     * 生成Redis key
     *
     * @param email 邮箱地址
     * @return Redis key
     */
    public static String getRedisKey(String email) {
        return "email:code:" + email;
    }
}
