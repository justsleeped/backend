package com.sealflow.model.entity;

import com.sealflow.model.base.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = true)
@Data
public class SysPermission extends BaseEntity<Long> {

    /**
     * 权限编码
     */
    private String code;

    /**
     * 权限名称
     */
    private String name;

    /**
     * 资源标识
     */
    private String resource;

    /**
     * 操作
     */
    private String action;

    /**
     * 类型（API/MENU/BUTTON）
     */
    private String type;

    /**
     * 备注
     */
    private String remark;

    /**
     * 状态（0禁用，1启用）
     */
    private Integer status;
}