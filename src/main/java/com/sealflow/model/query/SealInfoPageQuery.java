package com.sealflow.model.query;

import com.sealflow.model.base.BasePageQuery;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = true)
@Data
@Schema(description = "查询印章信息对象")
public class SealInfoPageQuery extends BasePageQuery {

    @Schema(description = "印章编码")
    private String code;

    @Schema(description = "印章名称")
    private String name;

    @Schema(description = "所属分类ID")
    private Long categoryId;

    @Schema(description = "存放位置")
    private String storageLocation;

    @Schema(description = "保管人ID")
    private Long custodyUserId;

    @Schema(description = "状态（0-停用，1-启用，2-损坏，3-丢失）")
    private Integer status;

    @Schema(description = "是否归档（0未归档，1已归档）")
    private Integer isArchived;
}