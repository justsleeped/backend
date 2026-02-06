package com.sealflow.controller;

import com.sealflow.common.Result.PageResult;
import com.sealflow.common.Result.Result;
import com.sealflow.model.form.SysRoleForm;
import com.sealflow.model.query.SysRolePageQuery;
import com.sealflow.model.vo.SysRoleVO;
import com.sealflow.service.ISysRoleService;
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
@Tag(name = "角色表接口")
@RequestMapping("/v1/sysRole")
public class SysRoleController {

    private final ISysRoleService service;

    @Operation(summary = "新增")
    @PostMapping(value = "/add")
    @PreAuthorize("hasAuthority('system:add')")
    public Result<Long> saveSysRole(@Valid @RequestBody SysRoleForm formData) {
        Long id = service.saveSysRole(formData);
        return Result.success(id);
    }

    @Operation(summary = "修改")
    @PutMapping(value = "/{id}/update")
    @PreAuthorize("hasAuthority('system:update')")
    public Result<Boolean> updateSysRole(
            @Parameter(description = "主键ID") @PathVariable Long id,
            @Valid @RequestBody SysRoleForm formData) {
        service.updateSysRole(id, formData);
        return Result.success();
    }

    @Operation(summary = "删除")
    @DeleteMapping(value = "/{ids}/delete")
    @PreAuthorize("hasAuthority('system:delete')")
    public Result<Boolean> deleteSysRole(@Parameter(description = "需要删除的IDs，多个以英文逗号(,)分割") @PathVariable String ids) {
        service.deleteSysRole(ids);
        return Result.success();
    }

    @Operation(summary = "详情(根据ID获取)")
    @GetMapping("/{id}/form")
    @PreAuthorize("hasAuthority('system:get')")
    public Result<SysRoleVO> getSysRoleForm(@Parameter(description = "主键ID") @PathVariable Long id) {
        SysRoleVO sysRoleVO = service.getSysRoleVo(id);
        return Result.success(sysRoleVO);
    }

    @Operation(summary = "列表")
    @GetMapping("/list")
    @PreAuthorize("hasAnyAuthority('system:list', 'normal:list')")
    public Result<List<SysRoleVO>> listSysRole() {
        return Result.success(service.listSysRole());
    }

    @Operation(summary = "分页列表")
    @PostMapping("/page")
    @PreAuthorize("hasAuthority('system:page')")
    public PageResult<SysRoleVO> pageSysRole(@RequestBody SysRolePageQuery queryParams) {
        IPage<SysRoleVO> result = service.pageSysRole(queryParams);
        return PageResult.success(result);
    }
}
