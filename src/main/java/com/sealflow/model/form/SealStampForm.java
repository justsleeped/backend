package com.sealflow.model.form;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Data
@Schema(description = "PDF盖章表单信息")
public class SealStampForm {

    @Schema(description = "申请ID")
    private Long applyId;

    @Schema(description = "PDF文件URL")
    private String pdfUrl;

    @Schema(description = "印章图片URL")
    private String sealImageUrl;

    @Schema(description = "印章X坐标（百分比，0-100）")
    private Float x;

    @Schema(description = "印章Y坐标（百分比，0-100）")
    private Float y;

    @Schema(description = "印章宽度（百分比，0-100）")
    private Float width;

    @Schema(description = "印章高度（百分比，0-100）")
    private Float height;

    @Schema(description = "印章列表")
    private java.util.List<StampInfo> stamps;

    @Data
    public static class StampInfo {
        @Schema(description = "印章X坐标（百分比，0-100）")
        private Float x;

        @Schema(description = "印章Y坐标（百分比，0-100）")
        private Float y;

        @Schema(description = "印章宽度（百分比，0-100）")
        private Float width;

        @Schema(description = "印章高度（百分比，0-100）")
        private Float height;
    }
}
