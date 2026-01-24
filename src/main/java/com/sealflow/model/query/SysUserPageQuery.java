package com.sealflow.model.query;

import com.sealflow.model.base.BasePageQuery;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = true)
@Data
@Schema(description = "查询用户表对象")
public class SysUserPageQuery extends BasePageQuery {
    @Schema(description = "学号，唯一")
    private String username;

    @Schema(description = "真实姓名")
    private String realName;

    @Schema(description = "性别（0-未知，1-男，2-女）")
    private Integer gender;

    @Schema(description = "状态，1-正常，0-禁用")
    private Integer status;

    @Schema(description = "角色ID")
    private Long roleId;
}
