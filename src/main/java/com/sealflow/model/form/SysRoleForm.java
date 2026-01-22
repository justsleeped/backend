package com.sealflow.model.form;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.List;

@Data
@Schema(description = "角色表表单信息")
public class SysRoleForm {

    @Schema(description = "角色ID，主键自增")
    private Long id;

    @Schema(description = "角色编码")
    private String code;

    @Schema(description = "角色名称")
    private String name;

    @Schema(description = "显示顺序")
    private Integer sort;

    @Schema(description = "备注")
    private String remark;

    @Schema(description = "状态（0禁用，1启用）")
    private Integer status;

    @Schema(description = "权限ID列表")
    private List<Long> permissionIds;
}
