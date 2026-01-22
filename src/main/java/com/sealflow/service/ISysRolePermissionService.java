package com.sealflow.service;

import com.sealflow.model.entity.SysRolePermission;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * 角色权限关联服务接口
 *
 */
public interface ISysRolePermissionService extends IService<SysRolePermission> {
    /**
     * 设置角色权限关联（会先清除原有权限，再设置新权限）
     *
     * @param roleId 角色ID
     * @param permissionIds 权限ID列表
     */
    void setRolePermissions(Long roleId, List<Long> permissionIds);

    /**
     * 根据角色ID获取权限ID列表
     *
     * @param roleId 角色ID
     * @return 权限ID列表
     */
    List<Long> getPermissionIdsByRoleId(Long roleId);
}