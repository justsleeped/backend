package com.sealflow.model.form;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Data
@Schema(description = "印章使用申请表单信息")
public class SealApplyForm {

    @Schema(description = "申请单ID")
    private Long id;

    @Schema(description = "申请印章ID")
    private Long sealId;

    @Schema(description = "申请事由")
    private String applyReason;

    @Schema(description = "具体用途说明")
    private String usageDetails;

    @Schema(description = "申请日期")
    private String applyDate;

    @Schema(description = "预计使用时间")
    private String expectedUseDate;

    @Schema(description = "紧急程度（1-普通，2-紧急，3-特急）")
    private Integer urgencyLevel;

    @Schema(description = "流程模板ID")
    private Long templateId;

    @Schema(description = "PDF文件URL")
    private String pdfUrl;
}
