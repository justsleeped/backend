package com.sealflow.common.config;

import com.sealflow.common.properties.TokenProperties;
import cn.hutool.jwt.signers.JWTSigner;
import cn.hutool.jwt.signers.JWTSignerUtil;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.nio.charset.StandardCharsets;

/**
 * JWT配置类
 * 负责创建JWT签名器Bean
 */
@Configuration
public class JwtConfig {

    /**
     * 创建JWT签名器
     *
     * @param tokenProperties Token配置属性
     * @return JWT签名器
     */
    @Bean
    public JWTSigner jwtSigner(TokenProperties tokenProperties) {
        return JWTSignerUtil.hs256(tokenProperties.getSecret().getBytes(StandardCharsets.UTF_8));
    }
}
