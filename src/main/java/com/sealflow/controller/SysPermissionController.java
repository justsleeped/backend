package com.sealflow.controller;

import com.sealflow.common.Result.PageResult;
import com.sealflow.common.Result.Result;
import com.sealflow.model.form.SysPermissionForm;
import com.sealflow.model.query.SysPermissionPageQuery;
import com.sealflow.model.vo.SysPermissionVO;
import com.sealflow.service.ISysPermissionService;
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
@Tag(name = "权限表接口")
@RequestMapping("/v1/sysPermission")
public class SysPermissionController {

    private final ISysPermissionService service;

    @Operation(summary = "新增")
    @PostMapping(value = "/add")
    @PreAuthorize("hasAuthority('system:add')")
    public Result<Long> saveSysPermission(@Valid @RequestBody SysPermissionForm formData) {
        Long id = service.saveSysPermission(formData);
        return Result.success(id);
    }

    @Operation(summary = "修改")
    @PutMapping(value = "/{id}/update")
    @PreAuthorize("hasAuthority('system:update')")
    public Result<Boolean> updateSysPermission(
            @Parameter(description = "主键ID") @PathVariable Long id,
            @Valid @RequestBody SysPermissionForm formData) {
        service.updateSysPermission(id, formData);
        return Result.success();
    }

    @Operation(summary = "删除")
    @DeleteMapping(value = "/{ids}/delete")
    @PreAuthorize("hasAuthority('system:delete')")
    public Result<Boolean> deleteSysPermission(@Parameter(description = "需要删除的IDs，多个以英文逗号(,)分割") @PathVariable String ids) {
        service.deleteSysPermission(ids);
        return Result.success();
    }

    @Operation(summary = "详情(根据ID获取)")
    @GetMapping("/{id}/form")
    @PreAuthorize("hasAuthority('system:get')")
    public Result<SysPermissionVO> getSysPermissionForm(@Parameter(description = "主键ID") @PathVariable Long id) {
        SysPermissionVO sysPermissionVO = service.getSysPermissionVo(id);
        return Result.success(sysPermissionVO);
    }

    @Operation(summary = "列表")
    @GetMapping("/list")
    @PreAuthorize("hasAnyAuthority('system:list', 'normal:list')")
    public Result<List<SysPermissionVO>> listSysPermission() {
        return Result.success(service.listSysPermission());
    }

    @Operation(summary = "分页列表")
    @PostMapping("/page")
    @PreAuthorize("hasAnyAuthority('system:page', 'normal:page')")
    public PageResult<SysPermissionVO> pageSysPermission(@RequestBody SysPermissionPageQuery queryParams) {
        IPage<SysPermissionVO> result = service.pageSysPermission(queryParams);
        return PageResult.success(result);
    }
}
