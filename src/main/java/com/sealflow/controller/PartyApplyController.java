package com.sealflow.controller;

import com.sealflow.common.Result.PageResult;
import com.sealflow.common.Result.Result;
import com.sealflow.common.context.UserContextHolder;
import com.sealflow.model.form.PartyApplyForm;
import com.sealflow.model.form.PartyApprovalForm;
import com.sealflow.model.query.PartyApplyPageQuery;
import com.sealflow.model.vo.PartyApplyVO;
import com.sealflow.service.IPartyApplyService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@Tag(name = "党章申请接口")
@RequestMapping("/v1/partyApply")
public class PartyApplyController {

    private final IPartyApplyService service;

    @Operation(summary = "新增党章申请")
    @PostMapping(value = "/add")
    public Result<Long> savePartyApply(@Valid @RequestBody PartyApplyForm formData) {
        Long id = service.savePartyApply(formData);
        return Result.success(id);
    }

    @Operation(summary = "修改党章申请")
    @PutMapping(value = "/{id}/update")
    public Result<Boolean> updatePartyApply(
            @Parameter(description = "主键ID") @PathVariable Long id,
            @Valid @RequestBody PartyApplyForm formData) {
        service.updatePartyApply(id, formData);
        return Result.success();
    }

    @Operation(summary = "删除党章申请")
    @DeleteMapping(value = "/{ids}/delete")
    public Result<Boolean> deletePartyApply(@Parameter(description = "需要删除的IDs，多个以英文逗号(,)分割") @PathVariable String ids) {
        service.deletePartyApply(ids);
        return Result.success();
    }

    @Operation(summary = "详情(根据ID获取)")
    @GetMapping("/{id}/form")
    public Result<PartyApplyVO> getPartyApplyForm(@Parameter(description = "主键ID") @PathVariable Long id) {
        PartyApplyVO partyApplyVO = service.getPartyApplyVo(id);
        return Result.success(partyApplyVO);
    }

    @Operation(summary = "分页列表")
    @PostMapping("/page")
    public PageResult<PartyApplyVO> pagePartyApply(@RequestBody PartyApplyPageQuery queryParams) {
        IPage<PartyApplyVO> result = service.pagePartyApply(queryParams);
        return PageResult.success(result);
    }

    @Operation(summary = "审批任务")
    @PostMapping("/approve")
    public Result<Boolean> approveTask(@Valid @RequestBody PartyApprovalForm formData) {
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
    public PageResult<PartyApplyVO> pageMyStarted(@RequestBody PartyApplyPageQuery queryParams) {
        Long currentUserId = UserContextHolder.getCurrentUserId();
        IPage<PartyApplyVO> result = service.pageMyStarted(queryParams, currentUserId);
        return PageResult.success(result);
    }

    @Operation(summary = "我审批的申请")
    @PostMapping("/myApproved")
    public PageResult<PartyApplyVO> pageMyApproved(@RequestBody PartyApplyPageQuery queryParams) {
        Long currentUserId = UserContextHolder.getCurrentUserId();
        IPage<PartyApplyVO> result = service.pageMyApproved(queryParams, currentUserId);
        return PageResult.success(result);
    }

    @Operation(summary = "我的待办任务")
    @PostMapping("/todoTasks")
    public PageResult<PartyApplyVO> pageTodoTasks(@RequestBody PartyApplyPageQuery queryParams) {
        Long currentUserId = UserContextHolder.getCurrentUserId();
        IPage<PartyApplyVO> result = service.pageTodoTasks(queryParams, currentUserId);
        return PageResult.success(result);
    }

    @Operation(summary = "流程详情")
    @GetMapping("/processDetail/{processInstanceId}")
    public Result<PartyApplyVO> getProcessDetail(@Parameter(description = "流程实例ID") @PathVariable String processInstanceId) {
        PartyApplyVO partyApplyVO = service.getProcessDetail(processInstanceId);
        return Result.success(partyApplyVO);
    }
}