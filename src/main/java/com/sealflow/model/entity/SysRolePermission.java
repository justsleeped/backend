package com.sealflow.model.entity;

import com.sealflow.model.base.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 角色权限关联实体类
 */
@EqualsAndHashCode(callSuper = true)
@Data
public class SysRolePermission extends BaseEntity<Long> {

    /**
     * 角色ID
     */
    private Long roleId;

    /**
     * 权限ID
     */
    private Long permissionId;
}