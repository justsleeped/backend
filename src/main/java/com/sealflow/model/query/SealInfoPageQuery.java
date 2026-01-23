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

    @Schema(description = "所属分类")
    private String category;

    @Schema(description = "存放位置")
    private String storageLocation;

    @Schema(description = "状态（0-停用，1-启用）")
    private Integer status;
}