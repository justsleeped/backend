package com.sealflow.model.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Schema(description = "审批存证数据")
public class ApprovalEvidenceDataVO {

    @Schema(description = "记录ID")
    private Long recordId;

    @Schema(description = "申请ID")
    private Long applyId;

    @Schema(description = "审批人ID")
    private Long approverId;

    @Schema(description = "审批人姓名")
    private String approverName;

    @Schema(description = "审批结果")
    private Integer approveResult;

    @Schema(description = "审批意见")
    private String comment;

    @Schema(description = "审批时间")
    private LocalDateTime approveTime;
}
