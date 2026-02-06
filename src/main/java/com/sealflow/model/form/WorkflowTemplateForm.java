package com.sealflow.model.form;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.util.List;

@Data
@Schema(description = "工作流模板表单")
public class WorkflowTemplateForm {

    @Schema(description = "模板名称")
    @NotBlank(message = "模板名称不能为空")
    private String name;

    @Schema(description = "模板描述")
    private String description;

    @Schema(description = "Flowable流程定义Key")
    @NotBlank(message = "流程定义Key不能为空")
    private String processKey;

    @Schema(description = "BPMN XML内容")
    @NotBlank(message = "BPMN XML不能为空")
    private String bpmnXml;

    @Schema(description = "允许发起的角色ID列表")
    private List<Long> allowedRoles;

    @Schema(description = "印章分类（1-院章，2-党章）")
    private Integer sealCategory;
}
