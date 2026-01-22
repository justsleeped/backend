package com.sealflow.model.query;

import com.sealflow.model.base.BasePageQuery;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = true)
@Data
@Schema(description = "查询权限表对象")
public class SysPermissionPageQuery extends BasePageQuery {
    @Schema(description = "权限编码")
    private String code;

    @Schema(description = "权限名称")
    private String name;

    @Schema(description = "类型（API/MENU/BUTTON）")
    private String type;

    @Schema(description = "状态，1-启用，0-禁用")
    private Integer status;
}