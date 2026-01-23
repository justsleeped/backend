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

/**
 * 党章申请控制器
 * 主要功能：
 * 1. 党章申请的增删改查
 * 2. 审批任务处理
 * 3. 流程撤销
 * 4. 我发起的申请查询
 * 5. 我已审批的申请查询
 * 6. 我的待办任务查询
 * 7. 流程详情查询
 */
@RestController
@RequiredArgsConstructor
@Tag(name = "党章申请接口")
@RequestMapping("/v1/partyApply")
public class PartyApplyController {

    private final IPartyApplyService service;

    /**
     * 新增党章申请
     * 功能说明：
     * 1. 接收申请表单数据
     * 2. 调用服务层保存申请
     * 3. 自动启动工作流流程
     *
     * @param formData 申请表单数据
     * @return 申请ID
     */
    @Operation(summary = "新增党章申请")
    @PostMapping(value = "/add")
    public Result<Long> savePartyApply(@Valid @RequestBody PartyApplyForm formData) {
        Long id = service.savePartyApply(formData);
        return Result.success(id);
    }

    /**
     * 修改党章申请
     * 功能说明：
     * 1. 验证申请ID
     * 2. 接收修改表单数据
     * 3. 调用服务层更新申请
     *
     * @param id 申请ID
     * @param formData 申请表单数据
     * @return 操作结果
     */
    @Operation(summary = "修改党章申请")
    @PutMapping(value = "/{id}/update")
    public Result<Boolean> updatePartyApply(
            @Parameter(description = "主键ID") @PathVariable Long id,
            @Valid @RequestBody PartyApplyForm formData) {
        service.updatePartyApply(id, formData);
        return Result.success();
    }

    /**
     * 删除党章申请
     *
     * 功能说明：
     * 1. 支持批量删除
     * 2. 多个ID以英文逗号分隔
     * 3. 调用服务层删除申请
     *
     * @param ids 需要删除的IDs，多个以英文逗号(,)分割
     * @return 操作结果
     */
    @Operation(summary = "删除党章申请")
    @DeleteMapping(value = "/{ids}/delete")
    public Result<Boolean> deletePartyApply(@Parameter(description = "需要删除的IDs，多个以英文逗号(,)分割") @PathVariable String ids) {
        service.deletePartyApply(ids);
        return Result.success();
    }

    /**
     * 获取党章申请详情
     *
     * 功能说明：
     * 1. 根据ID查询申请详情
     * 2. 包含申请信息和审批记录
     *
     * @param id 主键ID
     * @return 申请详情VO
     */
    @Operation(summary = "详情(根据ID获取)")
    @GetMapping("/{id}/form")
    public Result<PartyApplyVO> getPartyApplyForm(@Parameter(description = "主键ID") @PathVariable Long id) {
        PartyApplyVO partyApplyVO = service.getPartyApplyVo(id);
        return Result.success(partyApplyVO);
    }

    /**
     * 分页查询党章申请列表
     *
     * 功能说明：
     * 1. 支持多条件查询
     * 2. 支持分页
     *
     * @param queryParams 查询条件
     * @return 分页结果
     */
    @Operation(summary = "分页列表")
    @PostMapping("/page")
    public PageResult<PartyApplyVO> pagePartyApply(@RequestBody PartyApplyPageQuery queryParams) {
        IPage<PartyApplyVO> result = service.pagePartyApply(queryParams);
        return PageResult.success(result);
    }

    /**
     * 审批任务
     *
     * 功能说明：
     * 1. 接收审批表单数据
     * 2. 获取当前登录用户ID
     * 3. 调用服务层完成审批
     *
     * @param formData 审批表单数据
     * @return 操作结果
     */
    @Operation(summary = "审批任务")
    @PostMapping("/approve")
    public Result<Boolean> approveTask(@Valid @RequestBody PartyApprovalForm formData) {
        Long currentUserId = UserContextHolder.getCurrentUserId();
        service.approveTask(formData.getTaskId(), formData.getApproveResult(), formData.getApproveComment(), currentUserId);
        return Result.success();
    }

    /**
     * 撤销流程
     *
     * 功能说明：
     * 1. 验证只有申请人才能撤销
     * 2. 获取当前登录用户ID
     * 3. 调用服务层撤销流程
     *
     * @param id 申请单ID
     * @return 操作结果
     */
    @Operation(summary = "撤销流程")
    @PostMapping("/{id}/revoke")
    public Result<Boolean> revokeProcess(@Parameter(description = "申请单ID") @PathVariable Long id) {
        Long currentUserId = UserContextHolder.getCurrentUserId();
        service.revokeProcess(id, currentUserId);
        return Result.success();
    }

    /**
     * 分页查询我发起的申请
     *
     * 功能说明：
     * 1. 获取当前登录用户ID
     * 2. 查询该用户作为申请人的所有申请
     * 3. 支持分页
     *
     * @param queryParams 查询条件
     * @return 分页结果
     */
    @Operation(summary = "我发起的申请")
    @PostMapping("/myStarted")
    public PageResult<PartyApplyVO> pageMyStarted(@RequestBody PartyApplyPageQuery queryParams) {
        Long currentUserId = UserContextHolder.getCurrentUserId();
        IPage<PartyApplyVO> result = service.pageMyStarted(queryParams, currentUserId);
        return PageResult.success(result);
    }

    /**
     * 分页查询我已审批的申请
     *
     * 功能说明：
     * 1. 获取当前登录用户ID
     * 2. 查询该用户审批过的所有申请
     * 3. 支持分页
     *
     * @param queryParams 查询条件
     * @return 分页结果
     */
    @Operation(summary = "我审批的申请")
    @PostMapping("/myApproved")
    public PageResult<PartyApplyVO> pageMyApproved(@RequestBody PartyApplyPageQuery queryParams) {
        Long currentUserId = UserContextHolder.getCurrentUserId();
        IPage<PartyApplyVO> result = service.pageMyApproved(queryParams, currentUserId);
        return PageResult.success(result);
    }

    /**
     * 分页查询我的待办任务
     *
     * 功能说明：
     * 1. 获取当前登录用户ID
     * 2. 查询该用户的待办任务（包括直接分配和角色候选组）
     * 3. 支持分页
     *
     * @param queryParams 查询条件
     * @return 分页结果
     */
    @Operation(summary = "我的待办任务")
    @PostMapping("/todoTasks")
    public PageResult<PartyApplyVO> pageTodoTasks(@RequestBody PartyApplyPageQuery queryParams) {
        Long currentUserId = UserContextHolder.getCurrentUserId();
        IPage<PartyApplyVO> result = service.pageTodoTasks(queryParams, currentUserId);
        return PageResult.success(result);
    }

    /**
     * 获取流程详情
     *
     * 功能说明：
     * 1. 根据流程实例ID查询流程详情
     * 2. 包含申请信息和审批记录
     *
     * @param processInstanceId 流程实例ID
     * @return 流程详情VO
     */
    @Operation(summary = "流程详情")
    @GetMapping("/processDetail/{processInstanceId}")
    public Result<PartyApplyVO> getProcessDetail(@Parameter(description = "流程实例ID") @PathVariable String processInstanceId) {
        PartyApplyVO partyApplyVO = service.getProcessDetail(processInstanceId);
        return Result.success(partyApplyVO);
    }
}
