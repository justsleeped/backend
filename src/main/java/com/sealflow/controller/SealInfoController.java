package com.sealflow.controller;

import com.sealflow.common.Result.PageResult;
import com.sealflow.common.Result.Result;
import com.sealflow.model.form.SealInfoForm;
import com.sealflow.model.query.SealInfoPageQuery;
import com.sealflow.model.vo.SealInfoVO;
import com.sealflow.service.ISealInfoService;
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
@Tag(name = "印章信息接口")
@RequestMapping("/v1/sealInfo")
public class SealInfoController {

    private final ISealInfoService service;

    @Operation(summary = "新增")
    @PostMapping(value = "/add")
    public Result<Long> saveSealInfo(@Valid @RequestBody SealInfoForm formData) {
        Long id = service.saveSealInfo(formData);
        return Result.success(id);
    }

    @Operation(summary = "修改")
    @PutMapping(value = "/{id}/update")
    public Result<Boolean> updateSealInfo(
            @Parameter(description = "主键ID") @PathVariable Long id,
            @Valid @RequestBody SealInfoForm formData) {
        service.updateSealInfo(id, formData);
        return Result.success();
    }

    @Operation(summary = "删除")
    @DeleteMapping(value = "/{ids}/delete")
    public Result<Boolean> deleteSealInfo(@Parameter(description = "需要删除的IDs，多个以英文逗号(,)分割") @PathVariable String ids) {
        service.deleteSealInfo(ids);
        return Result.success();
    }

    @Operation(summary = "详情(根据ID获取)")
    @GetMapping("/{id}/form")
    public Result<SealInfoVO> getSealInfoForm(@Parameter(description = "主键ID") @PathVariable Long id) {
        SealInfoVO sealInfoVO = service.getSealInfoVo(id);
        return Result.success(sealInfoVO);
    }

    @Operation(summary = "列表")
    @GetMapping("/list")
    public Result<List<SealInfoVO>> listSealInfo(SealInfoPageQuery queryParams) {
        return Result.success(service.listSealInfo(queryParams));
    }

    @Operation(summary = "分页列表")
    @PostMapping("/page")
    public PageResult<SealInfoVO> pageSealInfo(@RequestBody SealInfoPageQuery queryParams) {
        IPage<SealInfoVO> result = service.pageSealInfo(queryParams);
        return PageResult.success(result);
    }
}