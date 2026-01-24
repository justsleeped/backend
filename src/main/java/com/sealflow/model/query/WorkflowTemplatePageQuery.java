package com.sealflow.model.query;

import com.sealflow.model.base.BasePageQuery;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = true)
@Data
@Schema(description = "工作流模板分页查询参数")
public class WorkflowTemplatePageQuery extends BasePageQuery {

    @Schema(description = "模板名称（模糊查询）")
    private String name;

    @Schema(description = "是否已部署")
    private Integer deployed;

    @Schema(description = "状态")
    private Integer status;
}
