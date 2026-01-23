package com.sealflow.controller;

import com.sealflow.common.Result.PageResult;
import com.sealflow.common.Result.Result;
import com.sealflow.common.context.UserContextHolder;
import com.sealflow.model.form.SealApplyForm;
import com.sealflow.model.form.SealApprovalForm;
import com.sealflow.model.query.SealApplyPageQuery;
import com.sealflow.model.vo.SealApplyVO;
import com.sealflow.service.ISealApplyService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@Tag(name = "印章使用申请接口")
@RequestMapping("/v1/sealApply")
public class SealApplyController {

    private final ISealApplyService service;

    @Operation(summary = "新增印章使用申请")
    @PostMapping(value = "/add")
    public Result<Long> saveSealApply(@Valid @RequestBody SealApplyForm formData) {
        Long id = service.saveSealApply(formData);
        return Result.success(id);
    }

    @Operation(summary = "修改印章使用申请")
    @PutMapping(value = "/{id}/update")
    public Result<Boolean> updateSealApply(
            @Parameter(description = "主键ID") @PathVariable Long id,
            @Valid @RequestBody SealApplyForm formData) {
        service.updateSealApply(id, formData);
        return Result.success();
    }

    @Operation(summary = "删除印章使用申请")
    @DeleteMapping(value = "/{ids}/delete")
    public Result<Boolean> deleteSealApply(@Parameter(description = "需要删除的IDs，多个以英文逗号(,)分割") @PathVariable String ids) {
        service.deleteSealApply(ids);
        return Result.success();
    }

    @Operation(summary = "详情(根据ID获取)")
    @GetMapping("/{id}/form")
    public Result<SealApplyVO> getSealApplyForm(@Parameter(description = "主键ID") @PathVariable Long id) {
        SealApplyVO sealApplyVO = service.getSealApplyVo(id);
        return Result.success(sealApplyVO);
    }

    @Operation(summary = "分页列表")
    @PostMapping("/page")
    public PageResult<SealApplyVO> pageSealApply(@RequestBody SealApplyPageQuery queryParams) {
        IPage<SealApplyVO> result = service.pageSealApply(queryParams);
        return PageResult.success(result);
    }

    @Operation(summary = "发起流程")
    @PostMapping("/{id}/startProcess")
    public Result<Boolean> startProcess(@Parameter(description = "申请单ID") @PathVariable Long id) {
        service.startProcess(id);
        return Result.success();
    }

    @Operation(summary = "审批任务")
    @PostMapping("/approve")
    public Result<Boolean> approveTask(@Valid @RequestBody SealApprovalForm formData) {
        Long currentUserId = UserContextHolder.getCurrentUserId();
        service.approveTask(formData.getTaskId(), formData.getApproveResult(), formData.getApproveComment(), currentUserId);
        return Result.success();
    }

    @Operation(summary = "撤销流程")
    @PostMapping("/{id}/revoke")
    public Result<Boolean> revokeProcess(@Parameter(description = "申请单ID") @PathVariable Long id) {
        Long currentUserId = UserContextHolder.getCurrentUserId();
        service.revokeProcess(id, currentUserId);
        return Result.success();
    }

    @Operation(summary = "我发起的申请")
    @PostMapping("/myStarted")
    public PageResult<SealApplyVO> pageMyStarted(@RequestBody SealApplyPageQuery queryParams) {
        Long currentUserId = UserContextHolder.getCurrentUserId();
        IPage<SealApplyVO> result = service.pageMyStarted(queryParams, currentUserId);
        return PageResult.success(result);
    }

    @Operation(summary = "我审批的申请")
    @PostMapping("/myApproved")
    public PageResult<SealApplyVO> pageMyApproved(@RequestBody SealApplyPageQuery queryParams) {
        Long currentUserId = UserContextHolder.getCurrentUserId();
        IPage<SealApplyVO> result = service.pageMyApproved(queryParams, currentUserId);
        return PageResult.success(result);
    }

    @Operation(summary = "我的待办任务")
    @PostMapping("/todoTasks")
    public PageResult<SealApplyVO> pageTodoTasks(@RequestBody SealApplyPageQuery queryParams) {
        Long currentUserId = UserContextHolder.getCurrentUserId();
        IPage<SealApplyVO> result = service.pageTodoTasks(queryParams, currentUserId);
        return PageResult.success(result);
    }

    @Operation(summary = "流程详情")
    @GetMapping("/processDetail/{processInstanceId}")
    public Result<SealApplyVO> getProcessDetail(@Parameter(description = "流程实例ID") @PathVariable String processInstanceId) {
        SealApplyVO sealApplyVO = service.getProcessDetail(processInstanceId);
        return Result.success(sealApplyVO);
    }
}
