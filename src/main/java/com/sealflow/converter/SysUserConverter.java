package com.sealflow.converter;

import com.sealflow.model.entity.SysUser;
import com.sealflow.model.form.SysUserForm;
import com.sealflow.model.vo.SysUserVO;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.mapstruct.Mapper;

import java.util.List;

@Mapper(componentModel = "spring")
public interface SysUserConverter {

    SysUserForm entityToForm(SysUser sysUser);

    SysUserVO entityToVo(SysUser sysUser);

    List<SysUserVO> entityToVo(List<SysUser> sysUser);

    SysUser formToEntity(SysUserForm sysUserForm);

    List<SysUser> formToEntity(List<SysUserForm> sysUserForm);

    Page<SysUserVO> entityToVOForPage(Page<SysUser> bo);
}