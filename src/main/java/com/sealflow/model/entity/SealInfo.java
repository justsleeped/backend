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
     * 所属分类（1-院章，2-党章）
     */
    private Integer category;

    /**
     * 印章描述
     */
    private String description;

    /**
     * 印章图片URL
     */
    private String imageUrl;

    /**
     * 状态（0-停用，1-启用）
     */
    private Integer status;

    /**
     * 印章类型（1-物理章，2-电子章）
     */
    private Integer sealType;
}
