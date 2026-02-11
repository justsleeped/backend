package com.sealflow.service.Impl;

import com.sealflow.service.IEmailService;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

/**
 * 邮件服务实现类
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class EmailServiceImpl implements IEmailService {

    private final JavaMailSender mailSender;

    @Value("${spring.mail.username}")
    private String fromEmail;

    @Override
    public Boolean sendVerificationCodeEmail(String toEmail, String code) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

            helper.setFrom(fromEmail);
            helper.setTo(toEmail);
            helper.setSubject("【SealFlowGuard】注册验证码");

            String content = buildEmailContent(code);
            helper.setText(content, true);

            mailSender.send(message);
            log.info("验证码邮件发送成功，收件人：{}", toEmail);
            return true;
        } catch (MessagingException e) {
            log.error("验证码邮件发送失败，收件人：{}，错误信息：{}", toEmail, e.getMessage());
            return false;
        }
    }

    private String buildEmailContent(String code) {
        return "<!DOCTYPE html>" +
                "<html>" +
                "<head>" +
                "<meta charset=\"UTF-8\">" +
                "<title>验证码</title>" +
                "</head>" +
                "<body style=\"margin: 0; padding: 0; font-family: 'Microsoft YaHei', Arial, sans-serif;\">" +
                "<div style=\"max-width: 600px; margin: 0 auto; background-color: #f8f9fa; padding: 30px;\">" +
                "<div style=\"background-color: #ffffff; border-radius: 8px; padding: 40px; box-shadow: 0 2px 8px rgba(0,0,0,0.1);\">" +
                "<h2 style=\"color: #0066CC; text-align: center; margin-bottom: 30px;\">SealFlowGuard 验证码</h2>" +
                "<p style=\"color: #333; font-size: 16px; line-height: 1.6; margin-bottom: 20px;\">您好，</p>" +
                "<p style=\"color: #333; font-size: 16px; line-height: 1.6; margin-bottom: 20px;\">您正在进行注册操作，验证码如下：</p>" +
                "<div style=\"background-color: #f0f7ff; border: 2px dashed #0066CC; border-radius: 8px; padding: 20px; text-align: center; margin: 30px 0;\">" +
                "<span style=\"font-size: 32px; font-weight: bold; color: #0066CC; letter-spacing: 8px;\">" + code + "</span>" +
                "</div>" +
                "<p style=\"color: #666; font-size: 14px; line-height: 1.6; margin-bottom: 10px;\">验证码有效期为 <strong>10分钟</strong>，请尽快完成注册。</p>" +
                "<p style=\"color: #666; font-size: 14px; line-height: 1.6; margin-bottom: 30px;\">如果这不是您的操作，请忽略此邮件。</p>" +
                "<hr style=\"border: none; border-top: 1px solid #e0e0e0; margin: 30px 0;\">" +
                "<p style=\"color: #999; font-size: 12px; text-align: center; margin: 0;\">此邮件由系统自动发送，请勿直接回复</p>" +
                "</div>" +
                "</div>" +
                "</body>" +
                "</html>";
    }
}
