package com.sealflow.controller;

import com.sealflow.common.Result.PageResult;
import com.sealflow.common.Result.Result;
import com.sealflow.common.context.UserContextHolder;
import com.sealflow.model.query.ApprovalTaskPageQuery;
import com.sealflow.model.vo.ApprovalTaskVO;
import com.sealflow.service.IApprovalTaskService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

/**
 * 审批任务管理Controller
 */
@RestController
@RequiredArgsConstructor
@Tag(name = "审批任务管理接口")
@RequestMapping("/v1/approvalTask")
public class ApprovalTaskController {

    /** 审批任务管理服务 */
    private final IApprovalTaskService approvalTaskService;

    /**
     * 分页查询待办任务
     * @param queryParams 查询参数
     * @return 分页结果
     */
    @Operation(summary = "分页查询待办任务")
    @PostMapping("/todoTasks/page")
    @PreAuthorize("hasAnyAuthority('normal:page', 'system:page')")
    public PageResult<ApprovalTaskVO> pageTodoTasks(@RequestBody ApprovalTaskPageQuery queryParams) {
        Long currentUserId = UserContextHolder.getCurrentUserId();
        IPage<ApprovalTaskVO> result = approvalTaskService.pageTodoTasks(queryParams, currentUserId);
        return PageResult.success(result);
    }

    /**
     * 分页查询已办任务
     * @param queryParams 查询参数
     * @return 分页结果
     */
    @Operation(summary = "分页查询已办任务")
    @PostMapping("/doneTasks/page")
    @PreAuthorize("hasAnyAuthority('normal:page', 'system:page')")
    public PageResult<ApprovalTaskVO> pageDoneTasks(@RequestBody ApprovalTaskPageQuery queryParams) {
        Long currentUserId = UserContextHolder.getCurrentUserId();
        IPage<ApprovalTaskVO> result = approvalTaskService.pageDoneTasks(queryParams, currentUserId);
        return PageResult.success(result);
    }

    /**
     * 获取待办任务数量
     * @return 待办任务数量
     */
    @Operation(summary = "获取待办任务数量")
    @GetMapping("/todoTasks/count")
    public Result<Long> getTodoTaskCount() {
        Long currentUserId = UserContextHolder.getCurrentUserId();
        Long count = approvalTaskService.getTodoTaskCount(currentUserId);
        return Result.success(count);
    }

    /**
     * 审批任务（同意）
     * @param taskId 任务ID
     * @param approveComment 审批意见
     * @return 操作结果
     */
    @Operation(summary = "审批任务（同意）")
    @PostMapping("/approve/{taskId}")
    @PreAuthorize("hasAuthority('system:approve')")
    public Result<Boolean> approveTask(
            @Parameter(description = "任务ID") @PathVariable String taskId,
            @Parameter(description = "审批意见") @RequestParam(required = false) String approveComment) {
        Long currentUserId = UserContextHolder.getCurrentUserId();
        approvalTaskService.approveTask(taskId, approveComment, currentUserId);
        return Result.success();
    }

    /**
     * 审批任务（拒绝）
     * @param taskId 任务ID
     * @param rejectReason 拒绝原因
     * @return 操作结果
     */
    @Operation(summary = "审批任务（拒绝）")
    @PostMapping("/reject/{taskId}")
    @PreAuthorize("hasAuthority('system:reject')")
    public Result<Boolean> rejectTask(
            @Parameter(description = "任务ID") @PathVariable String taskId,
            @Parameter(description = "拒绝原因", required = true) @RequestParam String rejectReason) {
        Long currentUserId = UserContextHolder.getCurrentUserId();
        approvalTaskService.rejectTask(taskId, rejectReason, currentUserId);
        return Result.success();
    }
}
