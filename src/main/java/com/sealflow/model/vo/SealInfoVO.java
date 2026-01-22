package com.sealflow.model.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Schema(description = "印章信息列表对象")
public class SealInfoVO {

    @Schema(description = "主键ID")
    private Long id;

    @Schema(description = "印章编码")
    private String code;

    @Schema(description = "印章名称")
    private String name;

    @Schema(description = "所属分类ID")
    private Long categoryId;

    @Schema(description = "所属分类名称")
    private String categoryName;

    @Schema(description = "印章描述")
    private String description;

    @Schema(description = "印章图片URL")
    private String imageUrl;

    @Schema(description = "存放位置")
    private String storageLocation;

    @Schema(description = "保管人ID")
    private Long custodyUserId;

    @Schema(description = "保管人姓名")
    private String custodyUserName;

    @Schema(description = "状态（0-停用，1-启用，2-损坏，3-丢失）")
    private Integer status;

    @Schema(description = "是否归档（0未归档，1已归档）")
    private Integer isArchived;

    @Schema(description = "创建人ID")
    private Long createBy;

    @Schema(description = "创建时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createTime;

    @Schema(description = "更新人ID")
    private Long updateBy;

    @Schema(description = "更新时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime updateTime;
}