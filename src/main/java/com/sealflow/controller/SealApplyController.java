package com.sealflow.controller;

import com.sealflow.common.Result.PageResult;
import com.sealflow.common.Result.Result;
import com.sealflow.model.form.SealApplyForm;
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

/**
 * 印章使用申请Controller
 * 
 * 该Controller专门负责印章申请的CRUD操作和流程管理，包括：
 * - 申请的增删改查
 * - 申请的分页查询
 * - 流程启动
 * - 流程撤销
 * 
 * 注意：审批任务相关的接口已迁移到ApprovalTaskController
 */
@RestController
@RequiredArgsConstructor
@Tag(name = "印章使用申请接口")
@RequestMapping("/v1/sealApply")
public class SealApplyController {

    private final ISealApplyService service;

    /**
     * 新增印章使用申请
     * 
     * 保存印章申请信息后，自动根据印章类型匹配工作流模板并启动审批流程。
     * 
     * @param formData 申请表单数据
     * @return 新创建的申请ID
     */
    @Operation(summary = "新增印章使用申请")
    @PostMapping(value = "/add")
    public Result<Long> saveSealApply(@Valid @RequestBody SealApplyForm formData) {
        Long id = service.saveSealApply(formData);
        return Result.success(id);
    }

    /**
     * 修改印章使用申请
     * 
     * 只有待审批的申请才能修改，审批中或已完成的申请不能修改。
     * 
     * @param id 申请ID
     * @param formData 更新后的申请数据
     * @return 操作结果
     */
    @Operation(summary = "修改印章使用申请")
    @PutMapping(value = "/{id}/update")
    public Result<Boolean> updateSealApply(
            @Parameter(description = "主键ID") @PathVariable Long id,
            @Valid @RequestBody SealApplyForm formData) {
        service.updateSealApply(id, formData);
        return Result.success();
    }

    /**
     * 删除印章使用申请
     * 
     * 批量删除申请，标记为删除状态而非物理删除。
     * 
     * @param ids 申请ID字符串，多个用逗号分隔
     * @return 操作结果
     */
    @Operation(summary = "删除印章使用申请")
    @DeleteMapping(value = "/{ids}/delete")
    public Result<Boolean> deleteSealApply(@Parameter(description = "需要删除的IDs，多个以英文逗号(,)分割") @PathVariable String ids) {
        service.deleteSealApply(ids);
        return Result.success();
    }

    /**
     * 获取申请详情
     * 
     * @param id 申请ID
     * @return 申请详情
     */
    @Operation(summary = "详情(根据ID获取)")
    @GetMapping("/{id}/form")
    public Result<SealApplyVO> getSealApplyForm(@Parameter(description = "主键ID") @PathVariable Long id) {
        SealApplyVO sealApplyVO = service.getSealApplyVo(id);
        return Result.success(sealApplyVO);
    }

    /**
     * 分页查询印章申请
     * 
     * @param queryParams 查询参数
     * @return 分页结果
     */
    @Operation(summary = "分页列表")
    @PostMapping("/page")
    public PageResult<SealApplyVO> pageSealApply(@RequestBody SealApplyPageQuery queryParams) {
        IPage<SealApplyVO> result = service.pageSealApply(queryParams);
        return PageResult.success(result);
    }

    /**
     * 撤销流程
     * 
     * 申请人可以撤销自己发起的、尚在审批中的申请。
     * 
     * @param id 申请单ID
     * @return 操作结果
     */
    @Operation(summary = "撤销流程")
    @PostMapping("/{id}/revoke")
    public Result<Boolean> revokeProcess(@Parameter(description = "申请单ID") @PathVariable Long id) {
        Long currentUserId = com.sealflow.common.context.UserContextHolder.getCurrentUserId();
        service.revokeProcess(id, currentUserId);
        return Result.success();
    }

    /**
     * 我发起的申请
     * 
     * 查询当前用户发起的所有申请，支持分页和状态筛选。
     * 
     * @param queryParams 查询参数
     * @return 分页结果
     */
    @Operation(summary = "我发起的申请")
    @PostMapping("/myStarted")
    public PageResult<SealApplyVO> pageMyStarted(@RequestBody SealApplyPageQuery queryParams) {
        Long currentUserId = com.sealflow.common.context.UserContextHolder.getCurrentUserId();
        IPage<SealApplyVO> result = service.pageMyStarted(queryParams, currentUserId);
        return PageResult.success(result);
    }

    /**
     * 流程详情
     * 
     * 获取申请对应的流程详情，包括流程节点信息和各节点的审批状态。
     * 
     * @param processInstanceId 流程实例ID
     * @return 包含流程节点信息的申请VO
     */
    @Operation(summary = "流程详情")
    @GetMapping("/processDetail/{processInstanceId}")
    public Result<SealApplyVO> getProcessDetail(@Parameter(description = "流程实例ID") @PathVariable String processInstanceId) {
        SealApplyVO sealApplyVO = service.getProcessDetail(processInstanceId);
        return Result.success(sealApplyVO);
    }
}
