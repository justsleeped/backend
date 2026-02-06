package com.sealflow.model.entity;

import com.sealflow.model.base.BaseEntity;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = true)
@Data
@Schema(description = "工作流模板表")
public class WorkflowTemplate extends BaseEntity<Long> {

    @Schema(description = "模板名称")
    private String name;

    @Schema(description = "模板描述")
    private String description;

    @Schema(description = "Flowable流程定义Key")
    private String processKey;

    @Schema(description = "BPMN XML内容")
    private String bpmnXml;

    @Schema(description = "是否已部署（0-否，1-是）")
    private Integer deployed;

    @Schema(description = "Flowable流程定义ID")
    private String processDefinitionId;

    @Schema(description = "允许发起的角色ID列表（JSON数组）")
    private String allowedRoles;

    @Schema(description = "印章分类（1-院章，2-党章）")
    private Integer sealCategory;

    @Schema(description = "状态（0-禁用，1-启用）")
    private Integer status;
}
