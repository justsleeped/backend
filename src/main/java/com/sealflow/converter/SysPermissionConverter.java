package com.sealflow.converter;

import com.sealflow.model.entity.SysPermission;
import com.sealflow.model.form.SysPermissionForm;
import com.sealflow.model.vo.SysPermissionVO;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.mapstruct.Mapper;

import java.util.List;

@Mapper(componentModel = "spring")
public interface SysPermissionConverter {

    SysPermissionForm entityToForm(SysPermission sysPermission);

    SysPermissionVO entityToVo(SysPermission sysPermission);

    List<SysPermissionVO> entityToVo(List<SysPermission> sysPermission);

    SysPermission formToEntity(SysPermissionForm sysPermissionForm);

    List<SysPermission> formToEntity(List<SysPermissionForm> sysPermissionForm);

    Page<SysPermissionVO> entityToVOForPage(Page<SysPermission> bo);
}