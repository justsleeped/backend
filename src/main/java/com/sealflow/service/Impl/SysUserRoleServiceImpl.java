package com.sealflow.service.Impl;

import com.sealflow.mapper.SysUserRoleMapper;
import com.sealflow.model.entity.SysUserRole;
import com.sealflow.service.IdentitySyncService;
import com.sealflow.service.ISysUserRoleService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

/**
 * 用户角色关联服务实现类
 */
@Service
@RequiredArgsConstructor
public class SysUserRoleServiceImpl extends ServiceImpl<SysUserRoleMapper, SysUserRole> implements ISysUserRoleService {

    private final IdentitySyncService identitySyncService;

    @Override
    public void setUserRoles(Long userId, List<Long> roleIds) {
        // 先删除该用户的所有角色关联
        this.remove(new LambdaQueryWrapper<SysUserRole>()
                .eq(SysUserRole::getUserId, userId));

        // 添加新的角色关联
        if (roleIds != null && !roleIds.isEmpty()) {
            for (Long roleId : roleIds) {
                SysUserRole userRole = new SysUserRole();
                userRole.setUserId(userId);
                userRole.setRoleId(roleId);
                this.save(userRole);

                identitySyncService.syncUserRoleToFlowable(userId, roleId);
            }
        }
    }

    @Override
    public List<Long> getRoleIdsByUserId(Long userId) {
        // 获取用户的角色ID列表
        return this.list(new LambdaQueryWrapper<SysUserRole>()
                        .eq(SysUserRole::getUserId, userId))
                .stream()
                .map(SysUserRole::getRoleId)
                .collect(Collectors.toList());
    }

    @Override
    public List<Long> getUserIdsByRoleId(Long roleId) {
        // 获取角色的用户ID列表
        return this.list(new LambdaQueryWrapper<SysUserRole>()
                        .eq(SysUserRole::getRoleId, roleId))
                .stream()
                .map(SysUserRole::getUserId)
                .collect(Collectors.toList());
    }
}
