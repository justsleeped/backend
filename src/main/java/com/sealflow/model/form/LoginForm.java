package com.sealflow.model.form;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import jakarta.validation.constraints.NotBlank;

/**
 * 用户登录表单
 */
@Data
@Schema(description = "用户登录表单")
public class LoginForm {

    @NotBlank(message = "学号不能为空")
    @Schema(description = "学号")
    private String username;

    @NotBlank(message = "密码不能为空")
    @Schema(description = "密码")
    private String password;
}