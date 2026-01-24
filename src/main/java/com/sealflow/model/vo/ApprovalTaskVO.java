package com.sealflow.model.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 审批任务视图对象
 */
@Data
@Schema(description = "审批任务信息")
public class ApprovalTaskVO {

    @Schema(description = "任务ID")
    private String taskId;

    @Schema(description = "任务名称")
    private String taskName;

    @Schema(description = "任务定义Key")
    private String taskDefinitionKey;

    @Schema(description = "流程实例ID")
    private String processInstanceId;

    @Schema(description = "流程定义ID")
    private String processDefinitionId;

    @Schema(description = "流程名称")
    private String processName;

    @Schema(description = "流程定义Key")
    private String processDefinitionKey;

    @Schema(description = "申请ID")
    private Long applyId;

    @Schema(description = "申请编号")
    private String applyNo;

    @Schema(description = "申请人ID")
    private Long applicantId;

    @Schema(description = "申请人姓名")
    private String applicantName;

    @Schema(description = "申请人工号")
    private String applicantNo;

    @Schema(description = "印章ID")
    private Long sealId;

    @Schema(description = "印章名称")
    private String sealName;

    @Schema(description = "印章类别（1-院章，2-党章）")
    private Integer sealCategory;

    @Schema(description = "印章类别名称")
    private String sealCategoryName;

    @Schema(description = "印章类型（1-物理章，2-电子章）")
    private Integer sealType;

    @Schema(description = "印章类型名称")
    private String sealTypeName;

    @Schema(description = "申请事由")
    private String applyReason;

    @Schema(description = "申请时间")
    private LocalDateTime applyTime;

    @Schema(description = "期望使用时间")
    private LocalDateTime expectedUseDate;

    @Schema(description = "申请状态（0-待审批，1-审批中，2-已通过，3-已拒绝，4-已撤销）")
    private Integer status;

    @Schema(description = "申请状态名称")
    private String statusName;

    @Schema(description = "当前节点名称")
    private String currentNodeName;

    @Schema(description = "当前节点Key")
    private String currentNodeKey;

    @Schema(description = "当前审批人ID")
    private Long currentApproverId;

    @Schema(description = "当前审批人姓名")
    private String currentApproverName;

    @Schema(description = "任务创建时间")
    private LocalDateTime taskCreateTime;

    @Schema(description = "任务完成时间（已办任务）")
    private LocalDateTime taskEndTime;

    @Schema(description = "任务状态（1-待办，2-已办）")
    private Integer taskStatus;

    @Schema(description = "任务状态名称")
    private String taskStatusName;

    @Schema(description = "审批人ID（已办任务）")
    private Long approverId;

    @Schema(description = "审批人姓名（已办任务）")
    private String approverName;

    @Schema(description = "审批结果（1-通过，0-拒绝，已办任务）")
    private Integer approveResult;

    @Schema(description = "审批结果名称（已办任务）")
    private String approveResultName;

    @Schema(description = "审批意见（已办任务）")
    private String approveComment;

    @Schema(description = "审批时间（已办任务）")
    private LocalDateTime approveTime;
}
