package com.sealflow.controller;

import com.sealflow.common.Result.PageResult;
import com.sealflow.common.Result.Result;
import com.sealflow.common.context.UserContextHolder;
import com.sealflow.model.query.ApprovalTaskPageQuery;
import com.sealflow.model.vo.ApprovalTaskVO;
import com.sealflow.model.vo.SealApplyVO;
import com.sealflow.service.IApprovalTaskService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

/**
 * 审批任务管理Controller
 * 该Controller专门负责审批任务相关的接口，包括：
 * - 待办任务查询
 * - 已办任务查询
 * - 审批操作（同意/拒绝）
 * - 任务详情查询
 * 
 * 职责说明：
 * - 专注于审批任务的查询和处理
 * - 不直接操作业务数据，通过IApprovalTaskService完成
 */
@RestController
@RequiredArgsConstructor
@Tag(name = "审批任务管理接口")
@RequestMapping("/v1/approvalTask")
public class ApprovalTaskController {

    /**
     * 审批任务管理服务
     */
    private final IApprovalTaskService approvalTaskService;

    /**
     * 分页查询待办任务
     * 
     * 查询分配给当前用户的任务以及用户所属角色候选的任务。
     * 支持按任务名称、流程名称、申请人、申请编号等条件筛选。
     * 
     * @param queryParams 查询参数
     * @return 分页结果
     */
    @Operation(summary = "分页查询待办任务")
    @PostMapping("/todoTasks/page")
    public PageResult<ApprovalTaskVO> pageTodoTasks(@RequestBody ApprovalTaskPageQuery queryParams) {
        Long currentUserId = UserContextHolder.getCurrentUserId();
        IPage<ApprovalTaskVO> result = approvalTaskService.pageTodoTasks(queryParams, currentUserId);
        return PageResult.success(result);
    }

    /**
     * 分页查询已办任务
     * 
     * 查询当前用户已经审批过的所有任务。
     * 支持按任务名称、流程名称、申请人、申请编号等条件筛选。
     * 
     * @param queryParams 查询参数
     * @return 分页结果
     */
    @Operation(summary = "分页查询已办任务")
    @PostMapping("/doneTasks/page")
    public PageResult<ApprovalTaskVO> pageDoneTasks(@RequestBody ApprovalTaskPageQuery queryParams) {
        Long currentUserId = UserContextHolder.getCurrentUserId();
        IPage<ApprovalTaskVO> result = approvalTaskService.pageDoneTasks(queryParams, currentUserId);
        return PageResult.success(result);
    }

    /**
     * 获取待办任务数量
     * 
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
     * 获取任务详情
     * 
     * @param taskId 任务ID
     * @return 任务详情
     */
    @Operation(summary = "获取任务详情")
    @GetMapping("/detail/{taskId}")
    public Result<ApprovalTaskVO> getTaskDetail(
            @Parameter(description = "任务ID") @PathVariable String taskId) {
        ApprovalTaskVO taskVO = approvalTaskService.getTaskDetail(taskId);
        return Result.success(taskVO);
    }

    /**
     * 获取任务的申请详情
     * 
     * @param taskId 任务ID
     * @return 申请详情
     */
    @Operation(summary = "获取任务的申请详情")
    @GetMapping("/apply/{taskId}")
    public Result<SealApplyVO> getApplyByTaskId(
            @Parameter(description = "任务ID") @PathVariable String taskId) {
        SealApplyVO applyVO = approvalTaskService.getApplyByTaskId(taskId);
        return Result.success(applyVO);
    }

    /**
     * 审批任务（同意）
     * 
     * @param taskId 任务ID
     * @param approveComment 审批意见
     * @return 操作结果
     */
    @Operation(summary = "审批任务（同意）")
    @PostMapping("/approve/{taskId}")
    public Result<Boolean> approveTask(
            @Parameter(description = "任务ID") @PathVariable String taskId,
            @Parameter(description = "审批意见") @RequestParam(required = false) String approveComment) {
        Long currentUserId = UserContextHolder.getCurrentUserId();
        approvalTaskService.approveTask(taskId, approveComment, currentUserId);
        return Result.success();
    }

    /**
     * 审批任务（拒绝）
     * 
     * @param taskId 任务ID
     * @param rejectReason 拒绝原因
     * @return 操作结果
     */
    @Operation(summary = "审批任务（拒绝）")
    @PostMapping("/reject/{taskId}")
    public Result<Boolean> rejectTask(
            @Parameter(description = "任务ID") @PathVariable String taskId,
            @Parameter(description = "拒绝原因", required = true) @RequestParam String rejectReason) {
        Long currentUserId = UserContextHolder.getCurrentUserId();
        approvalTaskService.rejectTask(taskId, rejectReason, currentUserId);
        return Result.success();
    }

    /**
     * 验证用户是否有权限处理该任务
     * 
     * @param taskId 任务ID
     * @return 是否有权限
     */
    @Operation(summary = "验证用户是否有权限处理该任务")
    @GetMapping("/hasPermission/{taskId}")
    public Result<Boolean> hasPermission(
            @Parameter(description = "任务ID") @PathVariable String taskId) {
        Long currentUserId = UserContextHolder.getCurrentUserId();
        boolean hasPermission = approvalTaskService.hasPermission(taskId, currentUserId);
        return Result.success(hasPermission);
    }
}
