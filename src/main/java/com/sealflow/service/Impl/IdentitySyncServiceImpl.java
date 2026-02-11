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

/**
 * 身份同步服务实现类
 * 
 * 主要功能：
 * 1. 同步用户到Flowable工作流引擎
 * 2. 同步角色到Flowable工作流引擎
 * 3. 同步用户角色关系到Flowable
 * 4. 从Flowable移除用户角色关系
 * 5. 初始化系统角色（班主任、辅导员、学院院长、党委书记）
 * 6. 同步所有用户到Flowable
 * 7. 同步所有角色到Flowable
 * 
 * 实现说明：
 * 使用ApplicationContextAware解决循环依赖问题，通过延迟加载获取依赖的服务
 */
@Slf4j
@Service
public class IdentitySyncServiceImpl implements IdentitySyncService, ApplicationContextAware {

    private final IdentityService identityService;
    private ApplicationContext applicationContext;

    /**
     * 构造函数
     * 
     * @param identityService Flowable身份服务
     */
    public IdentitySyncServiceImpl(IdentityService identityService) {
        this.identityService = identityService;
    }

    /**
     * 设置Spring应用上下文
     * 用于解决循环依赖问题，通过延迟加载获取依赖的服务
     * 
     * @param applicationContext Spring应用上下文
     */
    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        this.applicationContext = applicationContext;
    }

    /**
     * 获取系统用户服务
     * 通过ApplicationContext延迟加载，避免循环依赖
     * 
     * @return 系统用户服务
     */
    private ISysUserService getSysUserService() {
        return applicationContext.getBean(ISysUserService.class);
    }

    /**
     * 获取系统角色服务
     * 通过ApplicationContext延迟加载，避免循环依赖
     * 
     * @return 系统角色服务
     */
    private ISysRoleService getSysRoleService() {
        return applicationContext.getBean(ISysRoleService.class);
    }

    /**
     * 获取系统用户角色服务
     * 通过ApplicationContext延迟加载，避免循环依赖
     * 
     * @return 系统用户角色服务
     */
    private ISysUserRoleService getSysUserRoleService() {
        return applicationContext.getBean(ISysUserRoleService.class);
    }

    /**
     * 同步用户到Flowable工作流引擎
     * 
     * 功能说明：
     * 1. 检查用户是否已存在于Flowable
     * 2. 如果不存在，创建新用户
     * 3. 如果存在，更新用户信息
     * 
     * @param sysUser 系统用户
     */
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

    /**
     * 同步角色到Flowable工作流引擎
     * 
     * 功能说明：
     * 1. 检查角色是否已存在于Flowable
     * 2. 如果不存在，创建新角色（Group）
     * 3. 如果存在，更新角色信息
     * 
     * @param sysRole 系统角色
     */
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

    /**
     * 同步用户角色关系到Flowable
     * 
     * 功能说明：
     * 1. 检查用户是否已经是该角色的成员
     * 2. 如果不是，创建成员关系
     * 
     * @param userId 用户ID
     * @param roleId 角色ID
     */
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

    /**
     * 从Flowable移除用户角色关系
     * 
     * @param userId 用户ID
     * @param roleId 角色ID
     */
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

    /**
     * 初始化系统角色
     * 
     * 功能说明：
     * 在Flowable中创建系统所需的角色：
     * - CLASSGUIDE（班主任）
     * - MENTOR（辅导员）
     * - DEAN（学院院长）
     * - PARTYSECRETARY（党委书记）
     */
    @Override
    public void initSystemRoles() {
        String[] systemRoles = {"STUDENT", "CLASSGUIDE", "MENTOR", "DEAN", "PARTYSECRETARY"};
        String[] roleNames = {"学生", "班主任", "辅导员", "学院院长", "党委书记"};

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

    /**
     * 同步所有用户到Flowable
     * 
     * 功能说明：
     * 遍历系统中的所有用户，逐个同步到Flowable工作流引擎
     */
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

    /**
     * 同步所有角色到Flowable
     * 
     * 功能说明：
     * 遍历系统中的所有角色，逐个同步到Flowable工作流引擎
     */
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
