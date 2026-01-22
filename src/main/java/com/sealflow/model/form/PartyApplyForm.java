package com.sealflow.model.form;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Data
@Schema(description = "党章申请表单信息")
public class PartyApplyForm {

    @Schema(description = "申请单ID")
    private Long id;

    @Schema(description = "申请标题")
    private String title;

    @Schema(description = "申请内容")
    private String content;

    @Schema(description = "申请类型（1-入党申请，2-转正申请，3-其他）")
    private Integer applyType;

    @Schema(description = "紧急程度（1-普通，2-紧急，3-特急）")
    private Integer urgencyLevel;

    @Schema(description = "附件URL")
    private String attachmentUrl;
}
