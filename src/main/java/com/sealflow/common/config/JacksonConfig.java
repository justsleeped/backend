package com.sealflow.common.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.databind.module.SimpleModule;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.converter.json.Jackson2ObjectMapperBuilder;

/**
 * Jackson配置类，解决Long类型在前端精度缺失问题
 */
@Configuration
public class JacksonConfig {

    @Bean
    public ObjectMapper objectMapper(Jackson2ObjectMapperBuilder builder) {
        ObjectMapper objectMapper = builder.createXmlMapper(false).build();
        
        // 创建SimpleModule，用于注册Long类型的序列化器
        SimpleModule simpleModule = new SimpleModule();
        
        // 将Long类型转换为String类型，解决前端精度缺失问题
        simpleModule.addSerializer(Long.class, ToStringSerializer.instance);
        simpleModule.addSerializer(Long.TYPE, ToStringSerializer.instance);
        
        // 注册模块
        objectMapper.registerModule(simpleModule);
        
        // 注册JavaTimeModule，用于处理日期时间类型
        JavaTimeModule javaTimeModule = new JavaTimeModule();
        objectMapper.registerModule(javaTimeModule);
        
        // 统一日期格式，去掉纳秒精度
        objectMapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);
        objectMapper.disable(SerializationFeature.WRITE_DATE_TIMESTAMPS_AS_NANOSECONDS);
        
        return objectMapper;
    }
}