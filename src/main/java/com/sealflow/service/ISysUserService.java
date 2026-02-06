package com.sealflow.service;

import com.sealflow.model.entity.SysUser;
import com.sealflow.model.form.SysUserForm;
import com.sealflow.model.query.SysUserPageQuery;
import com.sealflow.model.vo.SysUserVO;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * 用户表表服务接口
 */
public interface ISysUserService extends IService<SysUser> {
    /**
     * 新增用户表
     *
     * @param formData 用户表表单数据
     */
    Long saveSysUser(SysUserForm formData);

    /**
     * 更新用户表
     *
     * @param id       主键id
     * @param formData 用户表表单数据
     */
    void updateSysUser(Long id, SysUserForm formData);

    /**
     * 删除用户表
     *
     * @param idStr 用户表IDs
     */
    void deleteSysUser(String idStr);

    /**
     * 通过ID获取用户表
     *
     * @param id 主键
     * @return SysUserForm 表单对象
     */
    SysUserVO getSysUserVo(Long id);

    /**
     * 分页查询用户表
     *
     * @param queryParams 筛选条件
     * @return IPage<SysUserVO> 分页对象
     */
    IPage<SysUserVO> pageSysUser(SysUserPageQuery queryParams);

    /**
     * 列表查询用户表
     *
     * @param queryParams 筛选条件
     * @return List<SysUserVO> 列表对象
     */
    List<SysUserVO> listSysUser(SysUserPageQuery queryParams);

    /**
     * 获取用户角色
     *
     * @param userId 用户ID
     * @return List<String> 角色列表
     */
    List<String> getRole(Long userId);

    /**
     * 获取用户权限
     *
     * @param userId 用户ID
     * @return List<String> 权限列表
     */
    List<String> getPermissions(Long userId);
}
