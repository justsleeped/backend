package com.sealflow.model.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.sealflow.model.base.BaseEntity;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.time.LocalDateTime;

@EqualsAndHashCode(callSuper = true)
@Data
@TableName("seal_stamp_record")
@Schema(description = "盖章记录表")
public class SealStampRecord extends BaseEntity<Long> {

    @Schema(description = "盖章记录编号")
    private String stampNo;

    @Schema(description = "申请ID")
    private Long applyId;

    @Schema(description = "印章ID")
    private Long sealId;

    @Schema(description = "印章名称")
    private String sealName;

    @Schema(description = "盖章人ID")
    private Long stamperId;

    @Schema(description = "盖章人姓名")
    private String stamperName;

    @Schema(description = "PDF文件URL")
    private String pdfUrl;

    @Schema(description = "印章图片URL")
    private String sealImageUrl;

    @Schema(description = "盖章时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime stampTime;

    @Schema(description = "盖章状态（1-成功，2-失败）")
    private Integer status;

    @Schema(description = "备注")
    private String remark;
}
