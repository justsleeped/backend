package com.sealflow.service;

/**
 * 邮件服务接口
 */
public interface IEmailService {

    /**
     * 发送验证码邮件
     *
     * @param toEmail 收件人邮箱
     * @param code    验证码
     * @return 发送结果
     */
    Boolean sendVerificationCodeEmail(String toEmail, String code);
}
