package com.sealflow.common.config;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Contact;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.info.License;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class Knife4jConfig {
    @Bean
    public OpenAPI Knife4jOpenApi() {
        return new OpenAPI()
                // 接口文档标题
                .info(new Info()
                        .title("基于RBAC与工作流引擎智能印章管控系统")
                        // 接口文档简介
                        .description("基于RBAC与工作流引擎智能印章管控系统API文档")
                        // 接口文档版本
                        .version("1.0.0")
                        // 开发者联系方式
                        .contact(new Contact().name("")
                                .email(""))
                        .license(new License()
                                .name("Apache 2.0")
                                .url("https://www.apache.org/licenses/LICENSE-2.0.html"))
                );
    }
}
