package com.sealflow.service.Impl;

import com.sealflow.model.entity.SysRole;
import com.sealflow.model.entity.SysUser;
import com.sealflow.service.IdentitySyncService;
import com.sealflow.service.ISysRoleService;
import com.sealflow.service.ISysUserRoleService;
import com.sealflow.service.ISysUserService;
import lombok.extern.slf4j.Slf4j;
import org.flowable.engine.IdentityService;
import org.flowable.idm.api.Group;
import org.flowable.idm.api.User;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
public class IdentitySyncServiceImpl implements IdentitySyncService, ApplicationContextAware {

    private final IdentityService identityService;
    private ApplicationContext applicationContext;

    public IdentitySyncServiceImpl(IdentityService identityService) {
        this.identityService = identityService;
    }

    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        this.applicationContext = applicationContext;
    }

    private ISysUserService getSysUserService() {
        return applicationContext.getBean(ISysUserService.class);
    }

    private ISysRoleService getSysRoleService() {
        return applicationContext.getBean(ISysRoleService.class);
    }

    private ISysUserRoleService getSysUserRoleService() {
        return applicationContext.getBean(ISysUserRoleService.class);
    }

    @Override
    public void syncUserToFlowable(SysUser sysUser) {
        if (sysUser == null || sysUser.getId() == null) {
            return;
        }

        User flowableUser = identityService.createUserQuery()
                .userId(sysUser.getId().toString())
                .singleResult();

        if (flowableUser == null) {
            flowableUser = identityService.newUser(sysUser.getId().toString());
            flowableUser.setFirstName(sysUser.getRealName());
            flowableUser.setLastName("");
            flowableUser.setEmail(sysUser.getEmail());
            identityService.saveUser(flowableUser);
            log.info("同步用户到Flowable: userId={}, username={}", sysUser.getId(), sysUser.getUsername());
        } else {
            flowableUser.setFirstName(sysUser.getRealName());
            flowableUser.setEmail(sysUser.getEmail());
            identityService.saveUser(flowableUser);
            log.info("更新Flowable用户: userId={}, username={}", sysUser.getId(), sysUser.getUsername());
        }
    }

    @Override
    public void syncRoleToFlowable(SysRole sysRole) {
        if (sysRole == null || sysRole.getId() == null) {
            return;
        }

        Group flowableGroup = identityService.createGroupQuery()
                .groupId(sysRole.getCode())
                .singleResult();

        if (flowableGroup == null) {
            flowableGroup = identityService.newGroup(sysRole.getCode());
            flowableGroup.setName(sysRole.getName());
            flowableGroup.setType("assignment");
            identityService.saveGroup(flowableGroup);
            log.info("同步角色到Flowable: groupId={}, groupName={}", sysRole.getCode(), sysRole.getName());
        } else {
            flowableGroup.setName(sysRole.getName());
            identityService.saveGroup(flowableGroup);
            log.info("更新Flowable角色: groupId={}, groupName={}", sysRole.getCode(), sysRole.getName());
        }
    }

    @Override
    public void syncUserRoleToFlowable(Long userId, Long roleId) {
        SysRole sysRole = getSysRoleService().getById(roleId);
        if (sysRole == null) {
            log.warn("角色不存在: roleId={}", roleId);
            return;
        }

        List<Group> groups = identityService.createGroupQuery()
                .groupMember(userId.toString())
                .list();

        boolean alreadyMember = groups.stream()
                .anyMatch(group -> group.getId().equals(sysRole.getCode()));

        if (!alreadyMember) {
            identityService.createMembership(userId.toString(), sysRole.getCode());
            log.info("同步用户角色关系到Flowable: userId={}, groupId={}", userId, sysRole.getCode());
        } else {
            log.debug("用户已是该组成员: userId={}, groupId={}", userId, sysRole.getCode());
        }
    }

    @Override
    public void removeUserRoleFromFlowable(Long userId, Long roleId) {
        SysRole sysRole = getSysRoleService().getById(roleId);
        if (sysRole == null) {
            log.warn("角色不存在: roleId={}", roleId);
            return;
        }

        identityService.deleteMembership(userId.toString(), sysRole.getCode());
        log.info("从Flowable移除用户角色关系: userId={}, groupId={}", userId, sysRole.getCode());
    }

    @Override
    public void initSystemRoles() {
        String[] systemRoles = {"CLASSGUIDE", "MENTOR", "DEAN", "PARTYSECRETARY"};
        String[] roleNames = {"班主任", "辅导员", "学院院长", "党委书记"};

        for (int i = 0; i < systemRoles.length; i++) {
            Group group = identityService.createGroupQuery()
                    .groupId(systemRoles[i])
                    .singleResult();

            if (group == null) {
                group = identityService.newGroup(systemRoles[i]);
                group.setName(roleNames[i]);
                group.setType("assignment");
                identityService.saveGroup(group);
                log.info("初始化系统角色: groupId={}, groupName={}", systemRoles[i], roleNames[i]);
            } else {
                log.info("系统角色已存在: groupId={}, groupName={}", systemRoles[i], roleNames[i]);
            }
        }
    }

    @Override
    public void syncAllUsers() {
        List<SysUser> users = getSysUserService().list();
        log.info("开始同步所有用户到Flowable，共{}个用户", users.size());
        
        for (SysUser user : users) {
            try {
                syncUserToFlowable(user);
            } catch (Exception e) {
                log.error("同步用户失败: userId={}, username={}", user.getId(), user.getUsername(), e);
            }
        }
        
        log.info("所有用户同步完成");
    }

    @Override
    public void syncAllRoles() {
        List<SysRole> roles = getSysRoleService().list();
        log.info("开始同步所有角色到Flowable，共{}个角色", roles.size());
        
        for (SysRole role : roles) {
            try {
                syncRoleToFlowable(role);
            } catch (Exception e) {
                log.error("同步角色失败: roleId={}, roleCode={}", role.getId(), role.getCode(), e);
            }
        }
        
        log.info("所有角色同步完成");
    }
}
