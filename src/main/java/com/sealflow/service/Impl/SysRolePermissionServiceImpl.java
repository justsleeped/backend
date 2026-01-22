package com.sealflow.service.Impl;

import com.sealflow.mapper.SysRolePermissionMapper;
import com.sealflow.model.entity.SysRolePermission;
import com.sealflow.service.ISysRolePermissionService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

/**
 * 角色权限关联服务实现类
 */
@Service
public class SysRolePermissionServiceImpl extends ServiceImpl<SysRolePermissionMapper, SysRolePermission> implements ISysRolePermissionService {

    @Override
    public void setRolePermissions(Long roleId, List<Long> permissionIds) {
        // 先删除该角色的所有权限关联
        this.remove(new LambdaQueryWrapper<SysRolePermission>()
                .eq(SysRolePermission::getRoleId, roleId));

        // 添加新的权限关联
        if (permissionIds != null && !permissionIds.isEmpty()) {
            for (Long permissionId : permissionIds) {
                SysRolePermission rolePermission = new SysRolePermission();
                rolePermission.setRoleId(roleId);
                rolePermission.setPermissionId(permissionId);
                this.save(rolePermission);
            }
        }
    }

    @Override
    public List<Long> getPermissionIdsByRoleId(Long roleId) {
        // 获取角色的权限ID列表
        return this.list(new LambdaQueryWrapper<SysRolePermission>()
                        .eq(SysRolePermission::getRoleId, roleId))
                .stream()
                .map(SysRolePermission::getPermissionId)
                .collect(Collectors.toList());
    }
}