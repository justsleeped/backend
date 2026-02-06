package com.sealflow.service.Impl;

import cn.hutool.core.lang.Assert;
import com.sealflow.converter.SysRoleConverter;
import com.sealflow.mapper.SysRoleMapper;
import com.sealflow.model.entity.SysRole;
import com.sealflow.model.form.SysRoleForm;
import com.sealflow.model.query.SysRolePageQuery;
import com.sealflow.model.vo.SysPermissionVO;
import com.sealflow.model.vo.SysRoleVO;
import com.sealflow.service.IdentitySyncService;
import com.sealflow.service.ISysPermissionService;
import com.sealflow.service.ISysRolePermissionService;
import com.sealflow.service.ISysRoleService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import jakarta.annotation.Resource;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;


@Service
@RequiredArgsConstructor
public class SysRoleServiceImpl extends ServiceImpl<SysRoleMapper, SysRole> implements ISysRoleService {
    @Resource
    private SysRoleConverter converter;

    private final ISysRolePermissionService sysRolePermissionService;
    private final ISysPermissionService sysPermissionService;
    private final IdentitySyncService identitySyncService;

	/**
     * 保存角色表
     *
     * @param formData 角色表表单数据
     */
    @Override
    public Long saveSysRole(SysRoleForm formData) {
        SysRole entity = converter.formToEntity(formData);
        Assert.isTrue(this.save(entity), "添加失败");

        identitySyncService.syncRoleToFlowable(entity);

        // 保存角色权限关联
        if (formData.getPermissionIds() != null && !formData.getPermissionIds().isEmpty()) {
            sysRolePermissionService.setRolePermissions(entity.getId(), formData.getPermissionIds());
        }

        return entity.getId();
    }

    /**
     * 更新角色表
     *
     * @param id       主键id
     * @param formData 角色表表单数据
     */
    @Override
    public void updateSysRole(Long id, SysRoleForm formData) {
        //判断数据是否存在
        getEntity(id);
        SysRole sysRole = converter.formToEntity(formData);
        sysRole.setId(id);
        Assert.isTrue(this.updateById(sysRole), "修改失败");

        identitySyncService.syncRoleToFlowable(sysRole);

        // 更新角色权限关联
        if (formData.getPermissionIds() != null) {
            sysRolePermissionService.setRolePermissions(id, formData.getPermissionIds());
        }
    }

    /**
     * 删除角色表
     *
     * @param idStr 角色表IDs
     */
    @Override
    public void deleteSysRole(String idStr) {
        Assert.isFalse(StringUtils.isEmpty(idStr), "id不能为空");
        // 逻辑删除
        List<Long> ids = Arrays.stream(idStr.split(","))
                .map(Long::parseLong).
                collect(Collectors.toList());
        LambdaUpdateWrapper<SysRole> wrapper = new LambdaUpdateWrapper<>();
        wrapper.set(SysRole::getDeleted, 1)
                .in(SysRole::getId, ids);
        Assert.isTrue(this.update(wrapper), "删除失败");
    }

    /**
     * 通过ID获取角色表
     *
     * @param id 主键
     * @return SysRoleForm 表单对象
     */
    @Override
    public SysRoleVO getSysRoleVo(Long id) {
        SysRole entity = getEntity(id);
        SysRoleVO vo = converter.entityToVo(entity);

        // 设置角色的权限信息
        setRolePermissionInfo(vo, id);

        return vo;
    }

    /**
     * 分页查询角色表
     *
     * @param queryParams 筛选条件
     * @return IPage<SysRoleVO> 分页对象
     */
    @Override
    public IPage<SysRoleVO> pageSysRole(SysRolePageQuery queryParams) {
        // 参数构建
        Page<SysRole> page = new Page<>(queryParams.getPageNum(), queryParams.getPageSize());
        //添加查询条件
        Page<SysRole> SysRolePage = this.baseMapper.selectPage(page, getQueryWrapper(queryParams));
        // 实体转换
        IPage<SysRoleVO> resultPage = converter.entityToVOForPage(SysRolePage);

        // 为每个角色设置权限信息
        resultPage.getRecords().forEach(roleVO -> setRolePermissionInfo(roleVO, roleVO.getId()));

        return resultPage;
    }

    @Override
    public List<SysRoleVO> listSysRole() {
        LambdaQueryWrapper<SysRole> qw = new LambdaQueryWrapper<>();
        qw.eq(SysRole::getDeleted, 0);
        qw.eq(SysRole::getStatus, 1);
        List<SysRoleVO> roleList = converter.entityToVo(this.list(qw));

        // 为每个角色设置权限信息
        roleList.forEach(roleVO -> setRolePermissionInfo(roleVO, roleVO.getId()));

        return roleList;
    }

    @Override
    public List<SysRoleVO> listByRoleIds(List<Long> roleIds) {
        List<SysRoleVO> roleList = converter.entityToVo(this.listByIds(roleIds));

        // 为每个角色设置权限信息
        roleList.forEach(roleVO -> setRolePermissionInfo(roleVO, roleVO.getId()));

        return roleList;
    }

    private LambdaQueryWrapper<SysRole> getQueryWrapper(SysRolePageQuery queryParams) {
        LambdaQueryWrapper<SysRole> qw = new LambdaQueryWrapper<>();
        qw.eq(SysRole::getDeleted, 0);
        qw.like(StringUtils.isNotBlank(queryParams.getCode()), SysRole::getCode, queryParams.getCode());
        qw.like(StringUtils.isNotBlank(queryParams.getName()), SysRole::getName, queryParams.getName());
        qw.eq(queryParams.getStatus() != null, SysRole::getStatus, queryParams.getStatus());
        qw.orderByDesc(SysRole::getCreateTime);
        return qw;
    }

    private SysRole getEntity(Long id) {
        SysRole entity = this.getOne(new LambdaQueryWrapper<SysRole>()
                .eq(SysRole::getId, id)
                .eq(SysRole::getDeleted, 0)
        );
        Assert.isTrue(null != entity, "数据不存在");
        return entity;
    }

    /**
     * 设置角色的权限信息
     */
    private void setRolePermissionInfo(SysRoleVO roleVO, Long roleId) {
        // 获取角色的权限ID列表
        List<Long> permissionIds = sysRolePermissionService.getPermissionIdsByRoleId(roleId);
        if (permissionIds != null && !permissionIds.isEmpty()) {
			List<SysPermissionVO> permissions = sysPermissionService.listByPermissionIds(permissionIds);
			roleVO.setPermissions(permissions);
		} else {
			roleVO.setPermissions(List.of());
		}
    }
}
