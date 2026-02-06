package com.sealflow.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.sealflow.common.Result.Result;
import com.sealflow.model.vo.BlockchainEvidenceVO;
import com.sealflow.model.vo.BlockchainVerifyResultVO;
import com.sealflow.service.IBlockchainEvidenceService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Tag(name = "区块链存证管理", description = "区块链存证相关接口")
@RestController
@RequestMapping("/api/blockchain/evidence")
@RequiredArgsConstructor
public class BlockchainEvidenceController {

    private final IBlockchainEvidenceService blockchainEvidenceService;

    @Operation(summary = "根据业务类型和ID查询存证记录")
    @GetMapping("/business")
    public Result<BlockchainEvidenceVO> getEvidenceByBusiness(
            @Parameter(description = "业务类型") @RequestParam String businessType,
            @Parameter(description = "业务ID") @RequestParam Long businessId) {
        BlockchainEvidenceVO evidence = blockchainEvidenceService.getEvidenceByBusiness(businessType, businessId);
        return Result.success(evidence);
    }

    @Operation(summary = "根据业务ID查询所有存证记录")
    @GetMapping("/business/{businessId}")
    public Result<List<BlockchainEvidenceVO>> getEvidenceListByBusiness(
            @Parameter(description = "业务ID") @PathVariable Long businessId) {
        List<BlockchainEvidenceVO> evidenceList = blockchainEvidenceService.getEvidenceListByBusiness(businessId);
        return Result.success(evidenceList);
    }

    @Operation(summary = "根据存证编号查询存证记录")
    @GetMapping("/no/{evidenceNo}")
    public Result<BlockchainEvidenceVO> getEvidenceByNo(
            @Parameter(description = "存证编号") @PathVariable String evidenceNo) {
        BlockchainEvidenceVO evidence = blockchainEvidenceService.getEvidenceByNo(evidenceNo);
        return Result.success(evidence);
    }

    @Operation(summary = "分页查询存证记录")
    @GetMapping("/page")
    public Result<IPage<BlockchainEvidenceVO>> pageEvidence(
            @Parameter(description = "业务ID") @RequestParam(required = false) Long businessId,
            @Parameter(description = "业务类型") @RequestParam(required = false) String businessType,
            @Parameter(description = "页码") @RequestParam(defaultValue = "1") Integer page,
            @Parameter(description = "每页大小") @RequestParam(defaultValue = "10") Integer size) {
        IPage<BlockchainEvidenceVO> result = blockchainEvidenceService.pageEvidence(businessId, businessType, page, size);
        return Result.success(result);
    }

    @Operation(summary = "验证存证记录")
    @PostMapping("/verify/{evidenceId}")
    public Result<BlockchainVerifyResultVO> verifyEvidence(
            @Parameter(description = "存证ID") @PathVariable Long evidenceId) {
        BlockchainVerifyResultVO result = blockchainEvidenceService.verifyEvidence(evidenceId);
        return Result.success(result);
    }

    @Operation(summary = "验证存证记录（包含数据一致性检查）")
    @PostMapping("/verify/consistency/{evidenceId}")
    public Result<BlockchainVerifyResultVO> verifyEvidenceWithDataConsistency(
            @Parameter(description = "存证ID") @PathVariable Long evidenceId) {
        BlockchainVerifyResultVO result = blockchainEvidenceService.verifyEvidenceWithDataConsistency(evidenceId);
        return Result.success(result);
    }

    @Operation(summary = "根据业务验证存证记录")
    @PostMapping("/verify/business")
    public Result<BlockchainVerifyResultVO> verifyEvidenceByBusiness(
            @Parameter(description = "业务类型") @RequestParam String businessType,
            @Parameter(description = "业务ID") @RequestParam Long businessId) {
        BlockchainVerifyResultVO result = blockchainEvidenceService.verifyEvidenceByBusiness(businessType, businessId);
        return Result.success(result);
    }
}
