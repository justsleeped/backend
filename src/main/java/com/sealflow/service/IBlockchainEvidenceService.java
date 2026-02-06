package com.sealflow.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.sealflow.model.entity.BlockchainEvidence;
import com.sealflow.model.vo.BlockchainEvidenceVO;
import com.sealflow.model.vo.BlockchainVerifyResultVO;

import java.util.List;

public interface IBlockchainEvidenceService extends IService<BlockchainEvidence> {

    BlockchainEvidenceVO createEvidence(String businessType, Long businessId, Object businessData, Long operatorId, String operatorName);

    BlockchainEvidenceVO createEvidence(String businessType, Long businessId, String businessDataJson, Long operatorId, String operatorName);

    BlockchainEvidenceVO getEvidenceByBusiness(String businessType, Long businessId);

    List<BlockchainEvidenceVO> getEvidenceListByBusiness(Long businessId);

    BlockchainEvidenceVO getEvidenceByNo(String evidenceNo);

    IPage<BlockchainEvidenceVO> pageEvidence(Long businessId, String businessType, Integer page, Integer size);

    BlockchainVerifyResultVO verifyEvidence(Long evidenceId);

    BlockchainVerifyResultVO verifyEvidenceByBusiness(String businessType, Long businessId);

    BlockchainVerifyResultVO verifyEvidenceWithDataConsistency(Long evidenceId);

    String generateDataHash(String data);

    String generateBlockHash(Long blockHeight, String dataHash, String previousHash, String timestamp);

    Long getCurrentBlockHeight();
}
