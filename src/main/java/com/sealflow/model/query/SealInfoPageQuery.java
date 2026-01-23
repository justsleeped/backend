package com.sealflow.model.query;

import com.sealflow.model.base.BasePageQuery;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = true)
@Data
@Schema(description = "查询印章信息对象")
public class SealInfoPageQuery extends BasePageQuery {
    @Schema(description = "印章名称")
    private String name;

    @Schema(description = "所属分类（1-院章，2-党章）")
    private Integer category;

    @Schema(description = "状态（0-停用，1-启用）")
    private Integer status;

    @Schema(description = "印章类型（1-物理章，2-电子章）")
    private Integer sealType;
}
