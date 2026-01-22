package com.sealflow.service.Impl;

import cn.hutool.core.lang.Assert;
import com.sealflow.converter.SysPermissionConverter;
import com.sealflow.mapper.SysPermissionMapper;
import com.sealflow.model.entity.SysPermission;
import com.sealflow.model.form.SysPermissionForm;
import com.sealflow.model.query.SysPermissionPageQuery;
import com.sealflow.model.vo.SysPermissionVO;
import com.sealflow.service.ISysPermissionService;
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
public class SysPermissionServiceImpl extends ServiceImpl<SysPermissionMapper, SysPermission> implements ISysPermissionService {
    @Resource
    private SysPermissionConverter converter;

	/**
     * 保存权限表
     *
     * @param formData 权限表表单数据
     */
    @Override
    public Long saveSysPermission(SysPermissionForm formData) {
        SysPermission entity = converter.formToEntity(formData);
        Assert.isTrue(this.save(entity), "添加失败");
        return entity.getId();
    }

    /**
     * 更新权限表
     *
     * @param id       主键id
     * @param formData 权限表表单数据
     */
    @Override
    public void updateSysPermission(Long id, SysPermissionForm formData) {
        //判断数据是否存在
        getEntity(id);
        SysPermission sysPermission = converter.formToEntity(formData);
        sysPermission.setId(id);
        Assert.isTrue(this.updateById(sysPermission), "修改失败");
    }

    /**
     * 删除权限表
     *
     * @param idStr 权限表IDs
     */
    @Override
    public void deleteSysPermission(String idStr) {
        Assert.isFalse(StringUtils.isEmpty(idStr), "id不能为空");
        // 逻辑删除
        List<Long> ids = Arrays.stream(idStr.split(","))
                .map(Long::parseLong).
                collect(Collectors.toList());
        LambdaUpdateWrapper<SysPermission> wrapper = new LambdaUpdateWrapper<>();
        wrapper.set(SysPermission::getDeleted, 1)
                .in(SysPermission::getId, ids);
        Assert.isTrue(this.update(wrapper), "删除失败");
    }

    /**
     * 通过ID获取权限表
     *
     * @param id 主键
     * @return SysPermissionForm 表单对象
     */
    @Override
    public SysPermissionVO getSysPermissionVo(Long id) {
        SysPermission entity = getEntity(id);
        return converter.entityToVo(entity);
    }

    /**
     * 分页查询权限表
     *
     * @param queryParams 筛选条件
     * @return IPage<SysPermissionVO> 分页对象
     */
    @Override
    public IPage<SysPermissionVO> pageSysPermission(SysPermissionPageQuery queryParams) {
        // 参数构建
        Page<SysPermission> page = new Page<>(queryParams.getPageNum(), queryParams.getPageSize());
        //添加查询条件
        Page<SysPermission> SysPermissionPage = this.baseMapper.selectPage(page, getQueryWrapper(queryParams));
        // 实体转换
        return converter.entityToVOForPage(SysPermissionPage);
    }

    @Override
    public List<SysPermissionVO> listSysPermission() {
        LambdaQueryWrapper<SysPermission> qw = new LambdaQueryWrapper<>();
        qw.eq(SysPermission::getDeleted, 0);
        qw.eq(SysPermission::getStatus, 1);
        return converter.entityToVo(this.list(qw));
    }

    @Override
    public List<SysPermissionVO> listByPermissionIds(List<Long> permissionIds) {
        return converter.entityToVo(this.listByIds(permissionIds));
    }

    private LambdaQueryWrapper<SysPermission> getQueryWrapper(SysPermissionPageQuery queryParams) {
        LambdaQueryWrapper<SysPermission> qw = new LambdaQueryWrapper<>();
        qw.eq(SysPermission::getDeleted, 0);
        qw.like(StringUtils.isNotBlank(queryParams.getCode()), SysPermission::getCode, queryParams.getCode());
        qw.like(StringUtils.isNotBlank(queryParams.getName()), SysPermission::getName, queryParams.getName());
        qw.eq(StringUtils.isNotBlank(queryParams.getType()), SysPermission::getType, queryParams.getType());
        qw.eq(queryParams.getStatus() != null, SysPermission::getStatus, queryParams.getStatus());
        qw.orderByDesc(SysPermission::getCreateTime);
        return qw;
    }

    private SysPermission getEntity(Long id) {
        SysPermission entity = this.getOne(new LambdaQueryWrapper<SysPermission>()
                .eq(SysPermission::getId, id)
                .eq(SysPermission::getDeleted, 0)
        );
        Assert.isTrue(null != entity, "数据不存在");
        return entity;
    }
}
