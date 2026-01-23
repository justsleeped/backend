package com.sealflow.service;

import com.sealflow.model.entity.SysRole;
import com.sealflow.model.entity.SysUser;

public interface IdentitySyncService {

    void syncUserToFlowable(SysUser sysUser);

    void syncRoleToFlowable(SysRole sysRole);

    void syncUserRoleToFlowable(Long userId, Long roleId);

    void removeUserRoleFromFlowable(Long userId, Long roleId);

    void initSystemRoles();

    void syncAllUsers();

    void syncAllRoles();
}
