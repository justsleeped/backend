package com.sealflow.model.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;
import lombok.Data;

/**
 * 登录响应信息
 */
@Data
@Builder
@Schema(description = "登录响应信息")
public class TokenVO {

    @Schema(description = "JWT Token")
    private String accessToken;

}
