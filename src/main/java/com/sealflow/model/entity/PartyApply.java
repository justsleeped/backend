package com.sealflow.model.entity;

import com.sealflow.model.base.BaseEntity;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.time.LocalDateTime;

@EqualsAndHashCode(callSuper = true)
@Data
@Schema(description = "党章申请表")
public class PartyApply extends BaseEntity<Long> {

    @Schema(description = "申请单号")
    private String applyNo;

    @Schema(description = "申请人ID")
    private Long applicantId;

    @Schema(description = "申请人姓名")
    private String applicantName;

    @Schema(description = "申请人学号")
    private String applicantNo;

    @Schema(description = "申请标题")
    private String title;

    @Schema(description = "申请内容")
    private String content;

    @Schema(description = "申请类型（1-入党申请，2-转正申请，3-其他）")
    private Integer applyType;

    @Schema(description = "紧急程度（1-普通，2-紧急，3-特急）")
    private Integer urgencyLevel;

    @Schema(description = "流程实例ID")
    private String processInstanceId;

    @Schema(description = "流程定义Key")
    private String processDefinitionKey;

    @Schema(description = "流程名称")
    private String processName;

    @Schema(description = "当前节点名称")
    private String currentNodeName;

    @Schema(description = "当前节点Key")
    private String currentNodeKey;

    @Schema(description = "状态（0-待审批，1-审批中，2-已通过，3-已拒绝，4-已撤销）")
    private Integer status;

    @Schema(description = "拒绝原因")
    private String rejectReason;

    @Schema(description = "申请时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime applyTime;

    @Schema(description = "完成时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime finishTime;

    @Schema(description = "附件URL")
    private String attachmentUrl;
}
