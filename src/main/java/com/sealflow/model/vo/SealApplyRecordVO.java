package com.sealflow.model.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Schema(description = "印章审批记录列表对象")
public class SealApplyRecordVO {

    @Schema(description = "审批记录ID")
    private Long id;

    @Schema(description = "申请单ID")
    private Long applyId;

    @Schema(description = "任务ID")
    private String taskId;

    @Schema(description = "任务名称")
    private String taskName;

    @Schema(description = "任务Key")
    private String taskKey;

    @Schema(description = "审批阶段")
    private Integer approvalStage;

    @Schema(description = "审批阶段名称")
    private String approvalStageName;

    @Schema(description = "审批人ID")
    private Long approverId;

    @Schema(description = "审批人姓名")
    private String approverName;

    @Schema(description = "审批人角色编码")
    private String approverRoleCode;

    @Schema(description = "审批人角色名称")
    private String approverRoleName;

    @Schema(description = "审批结果（1-同意，2-拒绝）")
    private Integer approveResult;

    @Schema(description = "审批结果名称")
    private String approveResultName;

    @Schema(description = "审批意见")
    private String approveComment;

    @Schema(description = "审批时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime approveTime;

    @Schema(description = "任务开始时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime taskStartTime;

    @Schema(description = "任务结束时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime taskEndTime;
}
