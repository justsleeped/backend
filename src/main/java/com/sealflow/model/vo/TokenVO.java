package com.sealflow.model.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;
import lombok.Data;

import java.util.List;

/**
 * 登录响应信息
 */
@Data
@Builder
@Schema(description = "登录响应信息")
public class TokenVO {

    @Schema(description = "JWT Token")
    private String accessToken;

    @Schema(description = "用户姓名")
    private String realName;

    @Schema(description = "用户角色名称列表")
    private List<String> role;
}
