package com.sealflow.service;

import com.sealflow.model.entity.SysUserRole;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * 用户角色关联服务接口
 */
public interface ISysUserRoleService extends IService<SysUserRole> {
    /**
     * 设置用户角色关联（会先清除原有角色，再设置新角色）
     *
     * @param userId 用户ID
     * @param roleIds 角色ID列表
     */
    void setUserRoles(Long userId, List<Long> roleIds);

    /**
     * 根据用户ID获取角色ID列表
     *
     * @param userId 用户ID
     * @return 角色ID列表
     */
    List<Long> getRoleIdsByUserId(Long userId);
}
