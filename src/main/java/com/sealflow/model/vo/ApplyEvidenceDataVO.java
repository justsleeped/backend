package com.sealflow.model.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Schema(description = "申请存证数据")
public class ApplyEvidenceDataVO {

    @Schema(description = "申请单号")
    private String applyNo;

    @Schema(description = "申请人ID")
    private Long applicantId;

    @Schema(description = "申请人姓名")
    private String applicantName;

    @Schema(description = "申请印章ID")
    private Long sealId;

    @Schema(description = "印章名称")
    private String sealName;

    @Schema(description = "申请事由")
    private String applyReason;

    @Schema(description = "申请时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime applyTime;
}
