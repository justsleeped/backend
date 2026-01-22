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

    @NotNull(message = "所属分类ID不能为空")
    @Schema(description = "所属分类ID")
    private Long categoryId;

    @Schema(description = "印章描述")
    private String description;

    @Schema(description = "印章图片URL")
    private String imageUrl;

    @Schema(description = "存放位置")
    private String storageLocation;

    @NotNull(message = "保管人ID不能为空")
    @Schema(description = "保管人ID")
    private Long custodyUserId;

    @NotNull(message = "状态不能为空")
    @Schema(description = "状态（0-停用，1-启用，2-损坏，3-丢失）")
    private Integer status;

    @NotNull(message = "是否归档不能为空")
    @Schema(description = "是否归档（0未归档，1已归档）")
    private Integer isArchived;
}