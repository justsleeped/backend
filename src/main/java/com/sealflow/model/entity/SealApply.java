package com.sealflow.model.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.sealflow.model.base.BaseEntity;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.time.LocalDate;
import java.time.LocalDateTime;

@EqualsAndHashCode(callSuper = true)
@Data
@TableName("seal_apply")
@Schema(description = "印章使用申请表")
public class SealApply extends BaseEntity<Long> {

    @Schema(description = "申请单号")
    private String applyNo;

    @Schema(description = "申请人ID")
    private Long applicantId;

    @Schema(description = "申请人姓名")
    private String applicantName;

    @Schema(description = "申请人学号")
    private String applicantNo;

    @Schema(description = "申请印章ID")
    private Long sealId;

    @Schema(description = "印章名称（冗余）")
    private String sealName;

    @Schema(description = "印章分类（1-院章，2-党章）")
    private Integer sealCategory;

    @Schema(description = "印章类型（1-物理章，2-电子章）")
    private Integer sealType;

    @Schema(description = "申请事由")
    private String applyReason;

    @Schema(description = "具体用途说明")
    private String usageDetails;

    @Schema(description = "申请日期")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private LocalDate applyDate;

    @Schema(description = "预计使用时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime expectedUseDate;

    @Schema(description = "紧急程度（1-普通，2-紧急，3-特急）")
    private Integer urgencyLevel;

    @Schema(description = "流程模板ID")
    private Long templateId;

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

    @Schema(description = "当前审批人ID")
    private Long currentApproverId;

    @Schema(description = "当前审批人姓名")
    private String currentApproverName;

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

    @Schema(description = "PDF文件URL")
    private String pdfUrl;
}
