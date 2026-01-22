package com.sealflow.model.form;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Data
@Schema(description = "权限表表单信息")
public class SysPermissionForm {

    @Schema(description = "权限ID，主键自增")
    private Long id;

    @Schema(description = "权限编码")
    private String code;

    @Schema(description = "权限名称")
    private String name;

    @Schema(description = "资源标识")
    private String resource;

    @Schema(description = "操作")
    private String action;

    @Schema(description = "类型（API/MENU/BUTTON）")
    private String type;

    @Schema(description = "备注")
    private String remark;

    @Schema(description = "状态（0禁用，1启用）")
    private Integer status;
}
