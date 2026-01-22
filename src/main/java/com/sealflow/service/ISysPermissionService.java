package com.sealflow.service;

import com.sealflow.model.entity.SysPermission;
import com.sealflow.model.form.SysPermissionForm;
import com.sealflow.model.query.SysPermissionPageQuery;
import com.sealflow.model.vo.SysPermissionVO;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.sealflow.model.vo.SysRoleVO;

import java.util.List;

/**
 * 权限表服务接口
 *
 * @author makejava
 * @date 2025-04-24
 */
public interface ISysPermissionService extends IService<SysPermission> {
    /**
     * 新增权限表
     *
     * @param formData 权限表表单数据
     */
    Long saveSysPermission(SysPermissionForm formData);

    /**
     * 更新权限表
     *
     * @param id       主键id
     * @param formData 权限表表单数据
     */
    void updateSysPermission(Long id, SysPermissionForm formData);

    /**
     * 删除权限表
     *
     * @param idStr 权限表IDs
     */
    void deleteSysPermission(String idStr);

    /**
     * 通过ID获取权限表
     *
     * @param id 主键
     * @return SysPermissionForm 表单对象
     */
    SysPermissionVO getSysPermissionVo(Long id);

    /**
     * 分页查询权限表
     *
     * @param queryParams 筛选条件
     * @return IPage<SysPermissionVO> 分页对象
     * @return 查询结果
     */
    IPage<SysPermissionVO> pageSysPermission(SysPermissionPageQuery queryParams);

    /**
     * 列表查询权限表
     *
     * @param queryParams 筛选条件
     * @return List<SysPermissionVO> 列表对象
     * @return 查询结果
     */
    List<SysPermissionVO> listSysPermission();

    /**
     * 通过权限ID列表获取权限表
     *
     * @param permissionIds 权限ID列表
     * @return List<SysPermissionVO> 列表对象
     */
    List<SysPermissionVO> listByPermissionIds(List<Long> permissionIds);
}
