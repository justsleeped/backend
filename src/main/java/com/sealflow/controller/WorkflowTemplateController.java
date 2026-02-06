package com.sealflow.controller;

import com.sealflow.common.Result.PageResult;
import com.sealflow.common.Result.Result;
import com.sealflow.model.form.WorkflowTemplateForm;
import com.sealflow.model.query.WorkflowTemplatePageQuery;
import com.sealflow.model.vo.WorkflowTemplateVO;
import com.sealflow.service.IWorkflowTemplateService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@Tag(name = "工作流模板管理接口")
@RequestMapping("/v1/workflowTemplate")
public class WorkflowTemplateController {

    private final IWorkflowTemplateService service;

    @Operation(summary = "新增工作流模板")
    @PostMapping(value = "/add")
    @PreAuthorize("hasAuthority('system:add')")
    public Result<Long> saveWorkflowTemplate(@Valid @RequestBody WorkflowTemplateForm formData) {
        Long id = service.saveWorkflowTemplate(formData);
        return Result.success(id);
    }

    @Operation(summary = "修改工作流模板")
    @PutMapping(value = "/{id}/update")
    @PreAuthorize("hasAuthority('system:update')")
    public Result<Boolean> updateWorkflowTemplate(
            @Parameter(description = "主键ID") @PathVariable Long id,
            @Valid @RequestBody WorkflowTemplateForm formData) {
        service.updateWorkflowTemplate(id, formData);
        return Result.success();
    }

    @Operation(summary = "删除工作流模板")
    @DeleteMapping(value = "/{ids}/delete")
    @PreAuthorize("hasAuthority('system:delete')")
    public Result<Boolean> deleteWorkflowTemplate(
            @Parameter(description = "需要删除的IDs，多个以英文逗号(,)分割") @PathVariable String ids) {
        service.deleteWorkflowTemplate(ids);
        return Result.success();
    }

    @Operation(summary = "详情(根据ID获取)")
    @GetMapping("/{id}/form")
    @PreAuthorize("hasAnyAuthority('system:get', 'normal:get')")
    public Result<WorkflowTemplateVO> getWorkflowTemplateForm(
            @Parameter(description = "主键ID") @PathVariable Long id) {
        WorkflowTemplateVO vo = service.getWorkflowTemplateVo(id);
        return Result.success(vo);
    }

    @Operation(summary = "分页列表")
    @PostMapping("/page")
    @PreAuthorize("hasAnyAuthority('system:page', 'normal:page')")
    public PageResult<WorkflowTemplateVO> pageWorkflowTemplate(@RequestBody WorkflowTemplatePageQuery queryParams) {
        IPage<WorkflowTemplateVO> result = service.pageWorkflowTemplate(queryParams);
        return PageResult.success(result);
    }

    @Operation(summary = "部署模板")
    @PostMapping("/{id}/deploy")
    @PreAuthorize("hasAuthority('workflow:deploy')")
    public Result<Boolean> deployTemplate(@Parameter(description = "模板ID") @PathVariable Long id) {
        service.deployTemplate(id);
        return Result.success();
    }

    @Operation(summary = "取消部署模板")
    @PostMapping("/{id}/undeploy")
    @PreAuthorize("hasAuthority('workflow:undeploy')")
    public Result<Boolean> undeployTemplate(@Parameter(description = "模板ID") @PathVariable Long id) {
        service.undeployTemplate(id);
        return Result.success();
    }

    @Operation(summary = "挂起工作流模板")
    @PostMapping("/{id}/suspend")
    @PreAuthorize("hasAuthority('workflow:suspend')")
    public Result<Boolean> suspendTemplate(@Parameter(description = "模板ID") @PathVariable Long id) {
        service.suspendTemplate(id);
        return Result.success();
    }

    @Operation(summary = "激活工作流模板")
    @PostMapping("/{id}/activate")
    @PreAuthorize("hasAuthority('workflow:activate')")
    public Result<Boolean> activateTemplate(@Parameter(description = "模板ID") @PathVariable Long id) {
        service.activateTemplate(id);
        return Result.success();
    }
}
