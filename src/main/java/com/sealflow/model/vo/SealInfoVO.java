package com.sealflow.model.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Data
@Schema(description = "印章信息列表对象")
public class SealInfoVO {

    @Schema(description = "主键ID")
    private Long id;

    @Schema(description = "印章编码")
    private String code;

    @Schema(description = "印章名称")
    private String name;

    @Schema(description = "所属分类（1-院章，2-党章）")
    private Integer category;

    @Schema(description = "印章描述")
    private String description;

    @Schema(description = "印章图片URL")
    private String imageUrl;

    @Schema(description = "状态（0-停用，1-启用）")
    private Integer status;

    @Schema(description = "印章类型（1-物理章，2-电子章）")
    private Integer sealType;
}
