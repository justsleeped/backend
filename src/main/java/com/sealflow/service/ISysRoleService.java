package com.sealflow.service;

import com.sealflow.model.entity.SysRole;
import com.sealflow.model.form.SysRoleForm;
import com.sealflow.model.query.SysRolePageQuery;
import com.sealflow.model.vo.SysRoleVO;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * 角色表服务接口
 */
public interface ISysRoleService extends IService<SysRole> {
    /**
     * 新增角色表
     *
     * @param formData 角色表表单数据
     */
    Long saveSysRole(SysRoleForm formData);

    /**
     * 更新角色表
     *
     * @param id       主键id
     * @param formData 角色表表单数据
     */
    void updateSysRole(Long id, SysRoleForm formData);

    /**
     * 删除角色表
     *
     * @param idStr 角色表IDs
     */
    void deleteSysRole(String idStr);

    /**
     * 通过ID获取角色表
     *
     * @param id 主键
     * @return SysRoleForm 表单对象
     */
    SysRoleVO getSysRoleVo(Long id);

    /**
     * 分页查询角色表
     *
     * @param queryParams 筛选条件
     * @return IPage<SysRoleVO> 分页对象
     */
    IPage<SysRoleVO> pageSysRole(SysRolePageQuery queryParams);

    /**
     * 列表查询角色表
     *
     * @return List<SysRoleVO> 列表对象
     */
    List<SysRoleVO> listSysRole();

    /**
     * 获取角色表列表
     *
     * @param roleIds 角色ID列表
     * @return List<SysRoleVO> 列表对象
     */
    List<SysRoleVO> listByRoleIds(List<Long> roleIds);
}
