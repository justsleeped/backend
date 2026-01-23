package com.sealflow.model.form;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

@Data
@Schema(description = "印章信息表单信息")
public class SealInfoForm {

    @Schema(description = "主键ID")
    private Long id;

    @NotBlank(message = "印章编码不能为空")
    @Schema(description = "印章编码")
    private String code;

    @NotBlank(message = "印章名称不能为空")
    @Schema(description = "印章名称")
    private String name;

    @NotNull(message = "所属分类不能为空")
    @Schema(description = "所属分类（1-院章，2-党章）")
    private Integer category;

    @Schema(description = "印章描述")
    private String description;

    @Schema(description = "印章图片URL")
    private String imageUrl;

    @Schema(description = "存放位置")
    private String storageLocation;

    @NotNull(message = "状态不能为空")
    @Schema(description = "状态（0-停用，1-启用）")
    private Integer status;

    @NotNull(message = "印章类型不能为空")
    @Schema(description = "印章类型（1-物理章，2-电子章）")
    private Integer sealType;
}