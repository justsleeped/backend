package com.sealflow.model.query;

import com.sealflow.model.base.BasePageQuery;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = true)
@Data
@Schema(description = "查询角色表对象")
public class SysRolePageQuery extends BasePageQuery {
    @Schema(description = "角色编码")
    private String code;

    @Schema(description = "角色名称")
    private String name;

    @Schema(description = "状态，1-启用，0-禁用")
    private Integer status;
}