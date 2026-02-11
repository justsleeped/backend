package com.sealflow.controller;

import com.sealflow.common.Result.PageResult;
import com.sealflow.common.Result.Result;
import com.sealflow.common.context.UserContextHolder;
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
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

/**
 * 印章使用申请Controller
 * 负责印章申请的CRUD操作和流程管理
 */
@RestController
@RequiredArgsConstructor
@Tag(name = "印章使用申请接口")
@RequestMapping("/v1/sealApply")
public class SealApplyController {

    private final ISealApplyService service;

    /**
     * 新增印章使用申请
     * 保存申请信息并启动审批流程
     * @param formData 申请表单数据
     * @return 新创建的申请ID
     */
    @Operation(summary = "新增印章使用申请")
    @PostMapping(value = "/add")
    @PreAuthorize("hasAnyAuthority('normal:add', 'system:add')")
    public Result<Long> saveSealApply(@Valid @RequestBody SealApplyForm formData) {
        Long id = service.saveSealApply(formData);
        return Result.success(id);
    }

    /**
     * 修改印章使用申请
     * 仅待审批状态可修改
     * @param id 申请ID
     * @param formData 更新后的申请数据
     * @return 操作结果
     */
    @Operation(summary = "修改印章使用申请")
    @PutMapping(value = "/{id}/update")
    @PreAuthorize("hasAnyAuthority('normal:update', 'system:update')")
    public Result<Boolean> updateSealApply(
            @Parameter(description = "主键ID") @PathVariable Long id,
            @Valid @RequestBody SealApplyForm formData) {
        service.updateSealApply(id, formData);
        return Result.success();
    }

    /**
     * 删除印章使用申请
     * 批量删除申请（逻辑删除）
     * @param ids 申请ID字符串，多个用逗号分隔
     * @return 操作结果
     */
    @Operation(summary = "删除印章使用申请")
    @DeleteMapping(value = "/{ids}/delete")
    @PreAuthorize("hasAnyAuthority('normal:delete', 'system:delete')")
    public Result<Boolean> deleteSealApply(@Parameter(description = "需要删除的IDs，多个以英文逗号(,)分割") @PathVariable String ids) {
        service.deleteSealApply(ids);
        return Result.success();
    }

    /**
     * 获取申请详情
     * @param id 申请ID
     * @return 申请详情
     */
    @Operation(summary = "详情(根据ID获取)")
    @GetMapping("/{id}/form")
    @PreAuthorize("hasAnyAuthority('normal:get', 'system:get')")
    public Result<SealApplyVO> getSealApplyForm(@Parameter(description = "主键ID") @PathVariable Long id) {
        SealApplyVO sealApplyVO = service.getSealApplyVo(id);
        return Result.success(sealApplyVO);
    }

    /**
     * 分页查询印章申请
     * @param queryParams 查询参数
     * @return 分页结果
     */
    @Operation(summary = "分页列表")
    @PostMapping("/page")
    @PreAuthorize("hasAnyAuthority('normal:page', 'system:page')")
    public PageResult<SealApplyVO> pageSealApply(@RequestBody SealApplyPageQuery queryParams) {
        IPage<SealApplyVO> result = service.pageSealApply(queryParams);
        return PageResult.success(result);
    }

    /**
     * 撤销流程
     * 撤销本人发起的审批中申请
     * @param id 申请单ID
     * @return 操作结果
     */
    @Operation(summary = "撤销流程")
    @PostMapping("/{id}/revoke")
    @PreAuthorize("hasAuthority('normal:update')")
    public Result<Boolean> revokeProcess(@Parameter(description = "申请单ID") @PathVariable Long id) {
        Long currentUserId = UserContextHolder.getCurrentUserId();
        service.revokeProcess(id, currentUserId);
        return Result.success();
    }

    /**
     * 我发起的申请
     * 查询当前用户发起的申请
     * @param queryParams 查询参数
     * @return 分页结果
     */
    @Operation(summary = "我发起的申请")
    @PostMapping("/myStarted")
    @PreAuthorize("hasAnyAuthority('normal:page', 'system:page')")
    public PageResult<SealApplyVO> pageMyStarted(@RequestBody SealApplyPageQuery queryParams) {
        Long currentUserId = UserContextHolder.getCurrentUserId();
        IPage<SealApplyVO> result = service.pageMyStarted(queryParams, currentUserId);
        return PageResult.success(result);
    }
}
