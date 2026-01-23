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

    @Schema(description = "所属分类")
    private String category;

    @Schema(description = "印章描述")
    private String description;

    @Schema(description = "印章图片URL")
    private String imageUrl;

    @Schema(description = "存放位置")
    private String storageLocation;

    @Schema(description = "状态（0-停用，1-启用）")
    private Integer status;

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