package com.sealflow.model.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Data
@Schema(description = "工作流模板视图对象")
public class WorkflowTemplateVO {

    @Schema(description = "主键ID")
    private Long id;

    @Schema(description = "模板名称")
    private String name;

    @Schema(description = "模板描述")
    private String description;

    @Schema(description = "流程定义Key")
    private String processKey;

    @Schema(description = "BPMN XML内容")
    private String bpmnXml;

    @Schema(description = "是否已部署")
    private Integer deployed;

    @Schema(description = "流程定义ID")
    private String processDefinitionId;

    @Schema(description = "允许发起的角色ID列表（JSON数组）")
    private String allowedRoles;

    @Schema(description = "允许发起的角色名称列表")
    private List<String> allowedRoleNames;

    @Schema(description = "印章分类（1-院章，2-党章）")
    private Integer sealCategory;

    @Schema(description = "状态")
    private Integer status;

    @Schema(description = "状态名称")
    private String statusName;

    @Schema(description = "是否已挂起")
    private Boolean suspended;

    @Schema(description = "创建时间")
    private LocalDateTime createTime;

    @Schema(description = "更新时间")
    private LocalDateTime updateTime;
}
