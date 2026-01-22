package com.sealflow.service.Impl;

import cn.hutool.core.lang.Assert;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.sealflow.converter.SysUserConverter;
import com.sealflow.mapper.SysUserMapper;
import com.sealflow.model.entity.SysUser;
import com.sealflow.model.form.SysUserForm;
import com.sealflow.model.query.SysUserPageQuery;
import com.sealflow.model.vo.SysRoleVO;
import com.sealflow.model.vo.SysUserVO;
import com.sealflow.service.ISysRoleService;
import com.sealflow.service.ISysUserRoleService;
import com.sealflow.service.ISysUserService;
import jakarta.annotation.Resource;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;


@Service
@RequiredArgsConstructor
public class SysUserServiceImpl extends ServiceImpl<SysUserMapper, SysUser> implements ISysUserService {
	private final ISysRoleService sysRoleService;
	private final ISysUserRoleService sysUserRoleService;
	private final PasswordEncoder passwordEncoder;
	@Resource
	private SysUserConverter converter;

	/**
	 * 保存用户表
	 *
	 * @param formData 用户表表单数据
	 */
	@Override
	public Long saveSysUser(SysUserForm formData) {
		formData.setPassword(passwordEncoder.encode(formData.getPassword()));
		SysUser entity = converter.formToEntity(formData);
		Assert.isTrue(this.save(entity), "添加失败");

		// 保存用户角色关联
		if (formData.getRoleIds() != null && !formData.getRoleIds().isEmpty()) {
			sysUserRoleService.setUserRoles(entity.getId(), formData.getRoleIds());
		}

		return entity.getId();
	}

	/**
	 * 更新用户表
	 *
	 * @param id       主键id
	 * @param formData 用户表表单数据
	 */
	@Override
	public void updateSysUser(Long id, SysUserForm formData) {
		//判断数据是否存在
		getEntity(id);
		if (formData.getPassword() != null && !formData.getPassword().isEmpty()) {
			formData.setPassword(passwordEncoder.encode(formData.getPassword()));
		} else {
			// 如果没有提供新密码，则不更新密码字段
			SysUser existingUser = getEntity(id);
			formData.setPassword(existingUser.getPassword());
		}
		SysUser sysUser = converter.formToEntity(formData);
		sysUser.setId(id);
		Assert.isTrue(this.updateById(sysUser), "修改失败");

		// 更新用户角色关联
		if (formData.getRoleIds() != null) {
			sysUserRoleService.setUserRoles(id, formData.getRoleIds());
		}
	}

	/**
	 * 删除用户表
	 *
	 * @param idStr 用户表IDs
	 */
	@Override
	public void deleteSysUser(String idStr) {
		Assert.isFalse(StringUtils.isEmpty(idStr), "id不能为空");
		// 逻辑删除
		List<Long> ids = Arrays.stream(idStr.split(","))
				.map(Long::parseLong).
				collect(Collectors.toList());
		LambdaUpdateWrapper<SysUser> wrapper = new LambdaUpdateWrapper<>();
		wrapper.set(SysUser::getDeleted, 1)
				.in(SysUser::getId, ids);
		Assert.isTrue(this.update(wrapper), "删除失败");
	}

	/**
	 * 通过ID获取用户表
	 *
	 * @param id 主键
	 * @return SysUserForm 表单对象
	 */
	@Override
	public SysUserVO getSysUserVo(Long id) {
		SysUser entity = getEntity(id);
		SysUserVO vo = converter.entityToVo(entity);

		// 设置用户的角色信息
		setUserRoleInfo(vo, id);

		return vo;
	}

	/**
	 * 分页查询用户表
	 *
	 * @param queryParams 筛选条件
	 * @return IPage<SysUserVO> 分页对象
	 */
	@Override
	public IPage<SysUserVO> pageSysUser(SysUserPageQuery queryParams) {
		// 参数构建
		Page<SysUser> page = new Page<>(queryParams.getPageNum(), queryParams.getPageSize());
		//添加查询条件
		Page<SysUser> SysUserPage = this.baseMapper.selectPage(page, getQueryWrapper(queryParams));
		// 实体转换
		IPage<SysUserVO> resultPage = converter.entityToVOForPage(SysUserPage);

		// 为每个用户设置角色信息
		resultPage.getRecords().forEach(userVO -> {
			setUserRoleInfo(userVO, userVO.getId());
		});

		return resultPage;
	}

	@Override
	public List<SysUserVO> listSysUser(SysUserPageQuery queryParams) {
		List<SysUserVO> userList = converter.entityToVo(this.list(getQueryWrapper(queryParams)));

		// 为每个用户设置角色信息
		userList.forEach(userVO -> {
			setUserRoleInfo(userVO, userVO.getId());
		});

		return userList;
	}

	private LambdaQueryWrapper<SysUser> getQueryWrapper(SysUserPageQuery queryParams) {
		LambdaQueryWrapper<SysUser> qw = new LambdaQueryWrapper<>();
		qw.eq(SysUser::getDeleted, 0);
		qw.like(StringUtils.isNotBlank(queryParams.getUsername()), SysUser::getUsername, queryParams.getUsername());
		qw.like(StringUtils.isNotBlank(queryParams.getRealName()), SysUser::getRealName, queryParams.getRealName());
		qw.like(StringUtils.isNotBlank(queryParams.getEmail()), SysUser::getEmail, queryParams.getEmail());
		qw.like(StringUtils.isNotBlank(queryParams.getPhone()), SysUser::getPhone, queryParams.getPhone());
		qw.eq(queryParams.getGender() != null, SysUser::getGender, queryParams.getGender());
		qw.eq(queryParams.getStatus() != null, SysUser::getStatus, queryParams.getStatus());
		qw.orderByDesc(SysUser::getCreateTime);
		return qw;
	}

	private SysUser getEntity(Long id) {
		SysUser entity = this.getOne(new LambdaQueryWrapper<SysUser>()
				.eq(SysUser::getId, id)
				.eq(SysUser::getDeleted, 0)
		);
		Assert.isTrue(null != entity, "数据不存在");
		return entity;
	}

	/**
	 * 设置用户的角色信息
	 */
	private void setUserRoleInfo(SysUserVO userVO, Long userId) {
		// 获取用户的角色ID列表
		List<Long> roleIds = sysUserRoleService.getRoleIdsByUserId(userId);
		if (roleIds != null && !roleIds.isEmpty()) {
			List<SysRoleVO> roles = sysRoleService.listByRoleIds(roleIds);
			userVO.setRoles(roles);
		} else {
			userVO.setRoles(List.of());
		}
	}
}
