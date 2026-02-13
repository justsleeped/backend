package com.sealflow.service.Impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sealflow.converter.BlockchainEvidenceConverter;
import com.sealflow.mapper.BlockchainEvidenceMapper;
import com.sealflow.model.entity.BlockchainEvidence;
import com.sealflow.model.entity.SealApply;
import com.sealflow.model.entity.SealApplyRecord;
import com.sealflow.model.entity.SealStampRecord;
import com.sealflow.model.vo.ApprovalEvidenceDataVO;
import com.sealflow.model.vo.ApplyEvidenceDataVO;
import com.sealflow.model.vo.BlockchainEvidenceVO;
import com.sealflow.model.vo.BlockchainVerifyResultVO;
import com.sealflow.service.IBlockchainEvidenceService;
import com.sealflow.service.ISealApplyRecordService;
import com.sealflow.service.ISealApplyService;
import com.sealflow.service.ISealStampRecordService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Objects;
import java.util.UUID;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class BlockchainEvidenceServiceImpl extends ServiceImpl<BlockchainEvidenceMapper, BlockchainEvidence> implements IBlockchainEvidenceService {

    private final BlockchainEvidenceConverter converter;
    private final ObjectMapper objectMapper;
    private final ApplicationContext applicationContext;

    private ISealApplyService getSealApplyService() {
        return applicationContext.getBean(ISealApplyService.class);
    }

    private ISealApplyRecordService getSealApplyRecordService() {
        return applicationContext.getBean(ISealApplyRecordService.class);
    }

    private ISealStampRecordService getSealStampRecordService() {
        return applicationContext.getBean(ISealStampRecordService.class);
    }

    private static final String HASH_ALGORITHM = "SHA-256";
    private static final DateTimeFormatter TIMESTAMP_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    /**
     * 创建区块链存证
     *
     * @param businessType 业务类型
     * @param businessId   业务ID
     * @param businessData 业务数据
     * @param operatorId   操作人ID
     * @param operatorName 操作人名称
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void createEvidence(String businessType, Long businessId, Object businessData, Long operatorId, String operatorName) {
        try {
            String businessDataJson = objectMapper.writeValueAsString(businessData);
            createEvidence(businessType, businessId, businessDataJson, operatorId, operatorName);
        } catch (Exception e) {
            log.error("序列化业务数据失败", e);
            throw new RuntimeException("序列化业务数据失败", e);
        }
    }

    /**
     * 创建区块链存证
     *
     * @param businessType 业务类型
     * @param businessId   业务ID
     * @param businessDataJson 业务数据JSON
     * @param operatorId   操作人ID
     * @param operatorName 操作人名称
     */
    @Transactional(rollbackFor = Exception.class)
    public void createEvidence(String businessType, Long businessId, String businessDataJson, Long operatorId, String operatorName) {
        try {
            Long blockHeight = getCurrentBlockHeight() + 1; // 获取当前区块高度
            String dataHash = generateDataHash(businessDataJson); // 生成数据Hash
            LocalDateTime now = LocalDateTime.now(); // 获取当前时间
            String timestamp = now.format(TIMESTAMP_FORMATTER); // 生成时间戳

            BlockchainEvidence previousBlock = getPreviousBlock(); // 获取前一个区块
            String previousHash = previousBlock != null ? previousBlock.getBlockHash() : "0"; // 获取前一个区块的Hash

            String blockHash = generateBlockHash(blockHeight, dataHash, previousHash, timestamp); // 生成区块Hash
            String transactionHash = generateTransactionHash(blockHash, businessType, businessId); // 生成交易Hash

            BlockchainEvidence evidence = new BlockchainEvidence();
            evidence.setEvidenceNo(generateEvidenceNo());
            evidence.setBusinessType(businessType);
            evidence.setBusinessId(businessId);
            evidence.setBusinessData(businessDataJson);
            evidence.setDataHash(dataHash);
            evidence.setBlockHeight(blockHeight);
            evidence.setBlockHash(blockHash);
            evidence.setTransactionHash(transactionHash);
            evidence.setPreviousHash(previousHash);
            evidence.setTimestamp(now);
            evidence.setOperatorId(operatorId);
            evidence.setOperatorName(operatorName);
            evidence.setStatus(1);
            evidence.setVerifyStatus(0);

            save(evidence);

            log.info("区块链存证创建成功: 存证编号={}, 业务类型={}, 业务ID={}, 区块高度={}",
                    evidence.getEvidenceNo(), businessType, businessId, blockHeight);

            converter.toVO(evidence);
        } catch (Exception e) {
            log.error("创建区块链存证失败", e);
            throw new RuntimeException("创建区块链存证失败", e);
        }
    }

    @Override
    public BlockchainEvidenceVO getEvidenceByBusiness(String businessType, Long businessId) {
        LambdaQueryWrapper<BlockchainEvidence> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(BlockchainEvidence::getBusinessType, businessType)
                .eq(BlockchainEvidence::getBusinessId, businessId)
                .orderByDesc(BlockchainEvidence::getCreateTime)
                .last("LIMIT 1");
        BlockchainEvidence evidence = getOne(wrapper);
        return evidence != null ? converter.toVO(evidence) : null;
    }

    @Override
    public java.util.List<BlockchainEvidenceVO> getEvidenceListByBusiness(Long businessId) {
        // 先查询直接关联的存证记录（申请）
        LambdaQueryWrapper<BlockchainEvidence> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(BlockchainEvidence::getBusinessId, businessId)
                .orderByAsc(BlockchainEvidence::getTimestamp);
        java.util.List<BlockchainEvidence> evidenceList = list(wrapper);

        // 查询与该申请相关的审批记录
        LambdaQueryWrapper<BlockchainEvidence> approvalWrapper = new LambdaQueryWrapper<>();
        approvalWrapper.eq(BlockchainEvidence::getBusinessType, "APPROVE")
                .or()
                .eq(BlockchainEvidence::getBusinessType, "APPROVAL")
                .orderByAsc(BlockchainEvidence::getTimestamp);
        List<BlockchainEvidence> approvalEvidenceList = list(approvalWrapper);

        // 过滤出与当前申请相关的审批记录
        List<BlockchainEvidence> relatedApprovalEvidence = new ArrayList<>();
        for (BlockchainEvidence evidence : approvalEvidenceList) {
            try {
                String businessData = evidence.getBusinessData();
                if (businessData.contains("\"applyId\":\"" + businessId + "\"")) {
                    relatedApprovalEvidence.add(evidence);
                }
            } catch (Exception e) {
                log.error("解析审批存证数据失败", e);
            }
        }

        // 查询与该申请相关的盖章记录
        List<SealStampRecord> stampRecords = getSealStampRecordService().getByApplyId(businessId);
        List<BlockchainEvidence> relatedStampEvidence = new ArrayList<>();

        for (SealStampRecord stampRecord : stampRecords) {
            LambdaQueryWrapper<BlockchainEvidence> stampWrapper = new LambdaQueryWrapper<>();
            stampWrapper.eq(BlockchainEvidence::getBusinessType, "STAMP")
                    .eq(BlockchainEvidence::getBusinessId, stampRecord.getId())
                    .orderByAsc(BlockchainEvidence::getTimestamp);
            List<BlockchainEvidence> stampEvidenceList = list(stampWrapper);
            relatedStampEvidence.addAll(stampEvidenceList);
        }

        // 合并所有相关记录
        List<BlockchainEvidence> allEvidence = new ArrayList<>();
        allEvidence.addAll(evidenceList);
        allEvidence.addAll(relatedApprovalEvidence);
        allEvidence.addAll(relatedStampEvidence);

        // 按时间戳排序
        allEvidence.sort(Comparator.comparing(BlockchainEvidence::getTimestamp));

        return allEvidence.stream().map(converter::toVO).collect(Collectors.toList());
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public BlockchainVerifyResultVO verifyEvidenceWithDataConsistency(Long evidenceId) {
        BlockchainEvidence evidence = getById(evidenceId);
        if (evidence == null) {
            throw new RuntimeException("存证记录不存在");
        }

        BlockchainVerifyResultVO result = new BlockchainVerifyResultVO();
        result.setEvidenceId(evidenceId);
        result.setEvidenceNo(evidence.getEvidenceNo());

        boolean isValid = verifyDataIntegrity(evidence); // 数据完整性验证
        result.setIsValid(isValid);

        boolean isDataConsistent = verifyDataConsistency(evidence); // 数据一致性验证
        result.setIsDataConsistent(isDataConsistent);

        if (isValid && isDataConsistent) {
            evidence.setVerifyStatus(1);
            result.setVerifyStatus("验证通过");
            result.setMessage("数据完整性验证通过，未被篡改，且与当前数据库数据一致");
        } else if (!isValid) {
            evidence.setVerifyStatus(2);
            result.setVerifyStatus("验证失败");
            result.setMessage("数据完整性验证失败，可能已被篡改");
        } else {
            evidence.setVerifyStatus(2);
            result.setVerifyStatus("验证失败");
            result.setMessage("数据完整性验证通过，但与当前数据库数据不一致，数据可能已被篡改");
        }

        evidence.setVerifyTime(LocalDateTime.now());
        updateById(evidence);

        return result;
    }

    /**
     * 数据一致性验证
     *
     * @param evidence 存证记录
     * @return 是否一致
     */
    private boolean verifyDataConsistency(BlockchainEvidence evidence) {
        try {
            String businessType = evidence.getBusinessType();
            Long businessId = evidence.getBusinessId();

            if ("APPLY".equals(businessType)) {
                SealApply currentApply = getSealApplyService().getById(businessId);
                if (currentApply == null) {
                    log.warn("申请记录不存在，业务ID: {}", businessId);
                    return false;
                }

                ApplyEvidenceDataVO currentData = new ApplyEvidenceDataVO();
                currentData.setApplyNo(currentApply.getApplyNo());
                currentData.setApplicantId(currentApply.getApplicantId());
                currentData.setApplicantName(currentApply.getApplicantName());
                currentData.setSealId(currentApply.getSealId());
                currentData.setSealName(currentApply.getSealName());
                currentData.setApplyReason(currentApply.getApplyReason());
                currentData.setApplyTime(currentApply.getApplyTime());

                try {
                    ApplyEvidenceDataVO storedData = objectMapper.readValue(evidence.getBusinessData(), ApplyEvidenceDataVO.class);

                    return isApplyDataConsistent(storedData, currentData, evidence.getEvidenceNo(), businessId);

                } catch (Exception e) {
                    log.error("解析存证业务数据失败", e);
                    return false;
                }

            }
            else if ("APPROVAL".equals(businessType)) {
                SealApplyRecord currentRecord = getSealApplyRecordService().getById(businessId);
                if (currentRecord == null) {
                    log.warn("审批记录不存在，业务ID: {}", businessId);
                    return false;
                }

                ApprovalEvidenceDataVO currentData = new ApprovalEvidenceDataVO();
                currentData.setRecordId(currentRecord.getId());
                currentData.setApplyId(currentRecord.getApplyId());
                currentData.setApproverId(currentRecord.getApproverId());
                currentData.setApproverName(currentRecord.getApproverName());
                currentData.setApproveResult(currentRecord.getApproveResult());
                currentData.setComment(currentRecord.getApproveComment());
                currentData.setApproveTime(currentRecord.getApproveTime());

                try {
                    ApprovalEvidenceDataVO storedData = objectMapper.readValue(evidence.getBusinessData(), ApprovalEvidenceDataVO.class);

                    return isApprovalDataConsistent(storedData, currentData, evidence.getEvidenceNo(), businessId);

                } catch (Exception e) {
                    log.error("解析存证业务数据失败", e);
                    return false;
                }
            }
            else if ("STAMP".equals(businessType)) {
                SealStampRecord stampRecord = getSealStampRecordService().getById(businessId);
                if (stampRecord == null) {
                    log.warn("盖章记录不存在，业务ID: {}", businessId);
                    return false;
                }

                try {
                    String businessDataJson = evidence.getBusinessData();

                    JsonNode businessData = objectMapper.readTree(businessDataJson);
                    String pdfUrl = businessData.has("pdfUrl") ? businessData.get("pdfUrl").asText() : null;
                    String sealImageUrl = businessData.has("sealImageUrl") ? businessData.get("sealImageUrl").asText() : null;
                    String applyId = businessData.has("applyId") ? businessData.get("applyId").asText() : null;

                    if (pdfUrl != null && !pdfUrl.equals(stampRecord.getPdfUrl())) {
                        log.warn("PDF URL不匹配，存证编号: {}, 数据库值: {}, 存证值: {}",
                                evidence.getEvidenceNo(), stampRecord.getPdfUrl(), pdfUrl);
                        return false;
                    }
                    if (sealImageUrl != null && !sealImageUrl.equals(stampRecord.getSealImageUrl())) {
                        log.warn("印章图片URL不匹配，存证编号: {}, 数据库值: {}, 存证值: {}",
                                evidence.getEvidenceNo(), stampRecord.getSealImageUrl(), sealImageUrl);
                        return false;
                    }
                    if (applyId != null && !applyId.equals(stampRecord.getApplyId().toString())) {
                        log.warn("申请ID不匹配，存证编号: {}, 数据库值: {}, 存证值: {}",
                                evidence.getEvidenceNo(), stampRecord.getApplyId(), applyId);
                        return false;
                    }

                    return true;
                } catch (Exception e) {
                    log.error("验证盖章存证数据失败", e);
                    return false;
                }
            }

            return true;
        } catch (Exception e) {
            log.error("验证数据一致性失败", e);
            return false;
        }
    }

    /**
     * 验证申请存证数据一致性
     *
     * @param storedData   存证数据
     * @param currentData  数据库数据
     * @param evidenceNo   存证编号
     * @param businessId   业务ID
     * @return 是否一致
     */
    private boolean isApplyDataConsistent(ApplyEvidenceDataVO storedData, ApplyEvidenceDataVO currentData, String evidenceNo, Long businessId) {
        boolean isConsistent = true;

        if (!Objects.equals(storedData.getApplyReason(), currentData.getApplyReason())) {
            log.warn("申请事由不匹配: 存证值={}, 数据库值={}", storedData.getApplyReason(), currentData.getApplyReason());
            isConsistent = false;
        }
        if (!isTimeEqual(storedData.getApplyTime(), currentData.getApplyTime())) {
            log.warn("申请时间不匹配: 存证值={}, 数据库值={}", storedData.getApplyTime(), currentData.getApplyTime());
            isConsistent = false;
        }
        if (!Objects.equals(storedData.getApplyNo(), currentData.getApplyNo())) {
            log.warn("申请单号不匹配: 存证值={}, 数据库值={}", storedData.getApplyNo(), currentData.getApplyNo());
            isConsistent = false;
        }
        if (!Objects.equals(storedData.getApplicantId(), currentData.getApplicantId())) {
            log.warn("申请人ID不匹配: 存证值={}, 数据库值={}", storedData.getApplicantId(), currentData.getApplicantId());
            isConsistent = false;
        }
        if (!Objects.equals(storedData.getApplicantName(), currentData.getApplicantName())) {
            log.warn("申请人姓名不匹配: 存证值={}, 数据库值={}", storedData.getApplicantName(), currentData.getApplicantName());
            isConsistent = false;
        }
        if (!Objects.equals(storedData.getSealId(), currentData.getSealId())) {
            log.warn("印章ID不匹配: 存证值={}, 数据库值={}", storedData.getSealId(), currentData.getSealId());
            isConsistent = false;
        }
        if (!Objects.equals(storedData.getSealName(), currentData.getSealName())) {
            log.warn("印章名称不匹配: 存证值={}, 数据库值={}", storedData.getSealName(), currentData.getSealName());
            isConsistent = false;
        }

        if (!isConsistent) {
            log.warn("数据一致性检查失败，存证编号: {}, 业务ID: {}", evidenceNo, businessId);
        }
        return isConsistent;
    }

    private boolean isApprovalDataConsistent(ApprovalEvidenceDataVO storedData, ApprovalEvidenceDataVO currentData, String evidenceNo, Long businessId) {
        boolean isConsistent = true;

        if (!Objects.equals(storedData.getComment(), currentData.getComment())) {
            log.warn("审批意见不匹配: 存证值={}, 数据库值={}", storedData.getComment(), currentData.getComment());
            isConsistent = false;
        }
        if (!isTimeEqual(storedData.getApproveTime(), currentData.getApproveTime())) {
            log.warn("审批时间不匹配: 存证值={}, 数据库值={}", storedData.getApproveTime(), currentData.getApproveTime());
            isConsistent = false;
        }
        if (!Objects.equals(storedData.getApproveResult(), currentData.getApproveResult())) {
            log.warn("审批结果不匹配: 存证值={}, 数据库值={}", storedData.getApproveResult(), currentData.getApproveResult());
            isConsistent = false;
        }
        if (!Objects.equals(storedData.getApproverId(), currentData.getApproverId())) {
            log.warn("审批人ID不匹配: 存证值={}, 数据库值={}", storedData.getApproverId(), currentData.getApproverId());
            isConsistent = false;
        }
        if (!Objects.equals(storedData.getApproverName(), currentData.getApproverName())) {
            log.warn("审批人姓名不匹配: 存证值={}, 数据库值={}", storedData.getApproverName(), currentData.getApproverName());
            isConsistent = false;
        }
        if (!Objects.equals(storedData.getApplyId(), currentData.getApplyId())) {
            log.warn("申请ID不匹配: 存证值={}, 数据库值={}", storedData.getApplyId(), currentData.getApplyId());
            isConsistent = false;
        }

        if (!isConsistent) {
            log.warn("Data consistency check failed for evidence: {}, businessId: {}", evidenceNo, businessId);
        }
        return isConsistent;
    }

    private boolean isTimeEqual(LocalDateTime time1, LocalDateTime time2) {
        if (time1 == null && time2 == null) return true;
        if (time1 == null || time2 == null) return false;
        return time1.truncatedTo(ChronoUnit.SECONDS).equals(time2.truncatedTo(ChronoUnit.SECONDS)) ||
               time1.truncatedTo(ChronoUnit.MILLIS).equals(time2.truncatedTo(ChronoUnit.MILLIS));
    }

    /**
     * 生成数据哈希
     * @param data 数据
     * @return 数据哈希
     */
    private String generateDataHash(String data) {
        try {
            MessageDigest digest = MessageDigest.getInstance(HASH_ALGORITHM);
            byte[] hashBytes = digest.digest(data.getBytes(StandardCharsets.UTF_8));
            return bytesToHex(hashBytes);
        } catch (NoSuchAlgorithmException e) {
            log.error("生成数据哈希失败", e);
            throw new RuntimeException("生成数据哈希失败", e);
        }
    }

    private String generateBlockHash(Long blockHeight, String dataHash, String previousHash, String timestamp) {
        String blockData = blockHeight + "|" + dataHash + "|" + previousHash + "|" + timestamp;
        return generateDataHash(blockData);
    }

    /**
     * 获取当前块的高度
     * @return 当前块的高度
     */
    private Long getCurrentBlockHeight() {
        LambdaQueryWrapper<BlockchainEvidence> wrapper = new LambdaQueryWrapper<>();
        wrapper.orderByDesc(BlockchainEvidence::getBlockHeight).last("LIMIT 1");
        BlockchainEvidence latestBlock = getOne(wrapper);
        return latestBlock != null ? latestBlock.getBlockHeight() : 0L;
    }

    /**
     * 生成交易哈希
     * @param blockHash 区块哈希
     * @param businessType 业务类型
     * @param businessId 业务ID
     * @return 交易哈希
     */
    private String generateTransactionHash(String blockHash, String businessType, Long businessId) {
        String transactionData = blockHash + "|" + businessType + "|" + businessId + "|" + System.currentTimeMillis();
        return generateDataHash(transactionData);
    }

    /**
     * 生成存证编号
     * @return 存证编号
     */
    private String generateEvidenceNo() {
        return "EV" + System.currentTimeMillis() + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
    }

    /**
     * 获取前一个块
     * @return 前一个块
     */
    private BlockchainEvidence getPreviousBlock() {
        LambdaQueryWrapper<BlockchainEvidence> wrapper = new LambdaQueryWrapper<>();
        wrapper.orderByDesc(BlockchainEvidence::getBlockHeight).last("LIMIT 1");
        return getOne(wrapper);
    }

    private boolean verifyDataIntegrity(BlockchainEvidence evidence) {
        try {
            String currentDataHash = generateDataHash(evidence.getBusinessData());
            log.info("验证存证: 存证编号={}, 存储哈希={}, 计算哈希={}",
                    evidence.getEvidenceNo(), evidence.getDataHash(), currentDataHash);

            if (!currentDataHash.equals(evidence.getDataHash())) {
                log.warn("数据哈希不匹配，存证编号: {}", evidence.getEvidenceNo());
                return false;
            }

            if (evidence.getBlockHeight() > 1) {
                BlockchainEvidence previousBlock = lambdaQuery()
                        .eq(BlockchainEvidence::getBlockHeight, evidence.getBlockHeight() - 1)
                        .one();

                if (previousBlock != null && !previousBlock.getBlockHash().equals(evidence.getPreviousHash())) {
                    log.warn("前一个区块哈希不匹配，存证编号: {}", evidence.getEvidenceNo());
                    return false;
                }
            }

            return true;
        } catch (Exception e) {
            log.error("验证数据完整性失败", e);
            return false;
        }
    }

    /**
     * 将字节数组转换为16进制字符串
     * @param bytes 字节数组
     * @return 16进制字符串
     */
    private String bytesToHex(byte[] bytes) {
        StringBuilder hexString = new StringBuilder();
        for (byte b : bytes) {
            String hex = Integer.toHexString(0xff & b);
            if (hex.length() == 1) {
                hexString.append('0');
            }
            hexString.append(hex);
        }
        return hexString.toString();
    }
}
