package com.sealflow.controller;

import com.sealflow.common.Result.PageResult;
import com.sealflow.common.Result.Result;
import com.sealflow.common.context.UserContextHolder;
import com.sealflow.model.form.WorkflowTemplateForm;
import com.sealflow.model.query.SysUserPageQuery;
import com.sealflow.model.query.WorkflowTemplatePageQuery;
import com.sealflow.model.vo.SysRoleVO;
import com.sealflow.model.vo.SysUserVO;
import com.sealflow.model.vo.WorkflowTemplateVO;
import com.sealflow.service.IWorkflowTemplateService;
import com.sealflow.service.ISysRoleService;
import com.sealflow.service.ISysUserService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@Tag(name = "工作流模板管理接口")
@RequestMapping("/v1/workflowTemplate")
public class WorkflowTemplateController {

    private final IWorkflowTemplateService service;
    private final ISysRoleService roleService;
    private final ISysUserService userService;

    @Operation(summary = "新增工作流模板")
    @PostMapping(value = "/add")
    public Result<Long> saveWorkflowTemplate(@Valid @RequestBody WorkflowTemplateForm formData) {
        Long id = service.saveWorkflowTemplate(formData);
        return Result.success(id);
    }

    @Operation(summary = "修改工作流模板")
    @PutMapping(value = "/{id}/update")
    public Result<Boolean> updateWorkflowTemplate(
            @Parameter(description = "主键ID") @PathVariable Long id,
            @Valid @RequestBody WorkflowTemplateForm formData) {
        service.updateWorkflowTemplate(id, formData);
        return Result.success();
    }

    @Operation(summary = "删除工作流模板")
    @DeleteMapping(value = "/{ids}/delete")
    public Result<Boolean> deleteWorkflowTemplate(
            @Parameter(description = "需要删除的IDs，多个以英文逗号(,)分割") @PathVariable String ids) {
        service.deleteWorkflowTemplate(ids);
        return Result.success();
    }

    @Operation(summary = "详情(根据ID获取)")
    @GetMapping("/{id}/form")
    public Result<WorkflowTemplateVO> getWorkflowTemplateForm(
            @Parameter(description = "主键ID") @PathVariable Long id) {
        WorkflowTemplateVO vo = service.getWorkflowTemplateVo(id);
        return Result.success(vo);
    }

    @Operation(summary = "分页列表")
    @PostMapping("/page")
    public PageResult<WorkflowTemplateVO> pageWorkflowTemplate(@RequestBody WorkflowTemplatePageQuery queryParams) {
        IPage<WorkflowTemplateVO> result = service.pageWorkflowTemplate(queryParams);
        return PageResult.success(result);
    }

    @Operation(summary = "部署模板")
    @PostMapping("/{id}/deploy")
    public Result<Boolean> deployTemplate(@Parameter(description = "模板ID") @PathVariable Long id) {
        service.deployTemplate(id);
        return Result.success();
    }

    @Operation(summary = "取消部署模板")
    @PostMapping("/{id}/undeploy")
    public Result<Boolean> undeployTemplate(@Parameter(description = "模板ID") @PathVariable Long id) {
        service.undeployTemplate(id);
        return Result.success();
    }

    @Operation(summary = "获取角色列表")
    @GetMapping("/roles")
    public Result<List<SysRoleVO>> getRoleList() {
        List<SysRoleVO> roles = roleService.listSysRole();
        return Result.success(roles);
    }

    @Operation(summary = "获取用户列表")
    @GetMapping("/users")
    public Result<List<SysUserVO>> getUserList(
            @Parameter(description = "角色ID（可选）") @RequestParam(required = false) Long roleId) {
        SysUserPageQuery query = new SysUserPageQuery();
        query.setRoleId(roleId);
        List<SysUserVO> users = userService.listSysUser(query);
        return Result.success(users);
    }

    @Operation(summary = "挂起工作流模板")
    @PostMapping("/{id}/suspend")
    public Result<Boolean> suspendTemplate(@Parameter(description = "模板ID") @PathVariable Long id) {
        service.suspendTemplate(id);
        return Result.success();
    }

    @Operation(summary = "激活工作流模板")
    @PostMapping("/{id}/activate")
    public Result<Boolean> activateTemplate(@Parameter(description = "模板ID") @PathVariable Long id) {
        service.activateTemplate(id);
        return Result.success();
    }

    @Operation(summary = "检查工作流模板是否已挂起")
    @GetMapping("/{id}/isSuspended")
    public Result<Boolean> isTemplateSuspended(@Parameter(description = "模板ID") @PathVariable Long id) {
        boolean suspended = service.isTemplateSuspended(id);
        return Result.success(suspended);
    }

    @Operation(summary = "验证用户是否有权限发起该工作流")
    @GetMapping("/{id}/hasInitiatePermission")
    public Result<Boolean> hasInitiatePermission(@Parameter(description = "模板ID") @PathVariable Long id) {
        Long currentUserId = UserContextHolder.getCurrentUserId();
        boolean hasPermission = service.hasInitiatePermission(id, currentUserId);
        return Result.success(hasPermission);
    }
}
