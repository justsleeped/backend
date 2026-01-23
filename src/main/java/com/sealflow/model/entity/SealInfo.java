package com.sealflow.model.entity;

import com.sealflow.model.base.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = true)
@Data
public class SealInfo extends BaseEntity<Long> {

    /**
     * 印章编码
     */
    private String code;

    /**
     * 印章名称
     */
    private String name;

    /**
     * 所属分类
     */
    private String category;

    /**
     * 印章描述
     */
    private String description;

    /**
     * 印章图片URL
     */
    private String imageUrl;

    /**
     * 存放位置
     */
    private String storageLocation;

    /**
     * 状态（0-停用，1-启用）
     */
    private Integer status;

    /**
     * 是否归档（0未归档，1已归档）
     */
    private Integer isArchived;
}
