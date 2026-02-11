package com.sealflow.controller;

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

    @Operation(summary = "验证存证记录（包含数据一致性检查）")
    @PostMapping("/verify/consistency/{evidenceId}")
    public Result<BlockchainVerifyResultVO> verifyEvidenceWithDataConsistency(
            @Parameter(description = "存证ID") @PathVariable Long evidenceId) {
        BlockchainVerifyResultVO result = blockchainEvidenceService.verifyEvidenceWithDataConsistency(evidenceId);
        return Result.success(result);
    }
}
