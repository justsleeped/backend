package com.sealflow.model.entity;

import com.sealflow.model.base.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 用户角色关联实体类
 */
@EqualsAndHashCode(callSuper = true)
@Data
public class SysUserRole extends BaseEntity<Long> {

    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 角色ID
     */
    private Long roleId;
}