package com.sealflow.model.form;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Data
@Schema(description = "党章审批表单信息")
public class PartyApprovalForm {

    @Schema(description = "任务ID")
    private String taskId;

    @Schema(description = "申请单ID")
    private Long applyId;

    @Schema(description = "审批结果（1-同意，2-拒绝）")
    private Integer approveResult;

    @Schema(description = "审批意见")
    private String approveComment;
}
