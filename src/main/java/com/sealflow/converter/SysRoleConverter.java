package com.sealflow.converter;

import com.sealflow.model.entity.SysRole;
import com.sealflow.model.form.SysRoleForm;
import com.sealflow.model.vo.SysRoleVO;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.mapstruct.Mapper;

import java.util.List;

@Mapper(componentModel = "spring")
public interface SysRoleConverter {

    SysRoleForm entityToForm(SysRole sysRole);

    SysRoleVO entityToVo(SysRole sysRole);

    List<SysRoleVO> entityToVo(List<SysRole> sysRole);

    SysRole formToEntity(SysRoleForm sysRoleForm);

    List<SysRole> formToEntity(List<SysRoleForm> sysRoleForm);

    Page<SysRoleVO> entityToVOForPage(Page<SysRole> bo);
}