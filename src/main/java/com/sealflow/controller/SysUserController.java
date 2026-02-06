package com.sealflow.controller;

import com.sealflow.common.Result.PageResult;
import com.sealflow.common.Result.Result;
import com.sealflow.model.form.SysUserForm;
import com.sealflow.model.query.SysUserPageQuery;
import com.sealflow.model.vo.SysUserVO;
import com.sealflow.service.ISysUserService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@RestController
@RequiredArgsConstructor
@Tag(name = "用户表接口")
@RequestMapping("/v1/sysUser")
public class SysUserController {

    private final ISysUserService service;

    @Operation(summary = "新增")
    @PostMapping(value = "/add")
    @PreAuthorize("hasAuthority('system:add')")
    public Result<Long> saveSysUser(@Valid @RequestBody SysUserForm formData) {
        Long id = service.saveSysUser(formData);
        return Result.success(id);
    }

    @Operation(summary = "修改")
    @PutMapping(value = "/{id}/update")
    @PreAuthorize("hasAuthority('system:update')")
    public Result<Boolean> updateSysUser(
            @Parameter(description = "主键ID") @PathVariable Long id,
            @Valid @RequestBody SysUserForm formData) {
        service.updateSysUser(id, formData);
        return Result.success();
    }

    @Operation(summary = "删除")
    @DeleteMapping(value = "/{ids}/delete")
    @PreAuthorize("hasAuthority('system:delete')")
    public Result<Boolean> deleteSysUser(@Parameter(description = "需要删除的IDs，多个以英文逗号(,)分割") @PathVariable String ids) {
        service.deleteSysUser(ids);
        return Result.success();
    }

    @Operation(summary = "详情(根据ID获取)")
    @GetMapping("/{id}/form")
    @PreAuthorize("hasAuthority('system:get')")
    public Result<SysUserVO> getSysUserForm(@Parameter(description = "主键ID") @PathVariable Long id) {
        SysUserVO sysUserVO = service.getSysUserVo(id);
        return Result.success(sysUserVO);
    }

    @Operation(summary = "列表")
    @GetMapping("/list")
    @PreAuthorize("hasAnyAuthority('system:list', 'normal:list')")
    public Result<List<SysUserVO>> listSysUser(
            @Parameter(description = "角色ID（可选）") @RequestParam(required = false) Long roleId
    ) {
        SysUserPageQuery query = new SysUserPageQuery();
        query.setRoleId(roleId);
        List<SysUserVO> users = service.listSysUser(query);
        return Result.success(users);
    }

    @Operation(summary = "分页列表")
    @PostMapping("/page")
    @PreAuthorize("hasAuthority('system:page')")
    public PageResult<SysUserVO> pageSysUser(@RequestBody SysUserPageQuery queryParams) {
        IPage<SysUserVO> result = service.pageSysUser(queryParams);
        return PageResult.success(result);
    }
}

