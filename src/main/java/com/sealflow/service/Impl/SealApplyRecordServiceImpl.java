package com.sealflow.service.Impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.sealflow.common.enums.ApprovalStage;
import com.sealflow.common.enums.ApproveResult;
import com.sealflow.converter.SealApplyConverter;
import com.sealflow.mapper.SealApplyRecordMapper;
import com.sealflow.model.entity.SealApplyRecord;
import com.sealflow.model.query.SealApplyPageQuery;
import com.sealflow.model.vo.ApprovalEvidenceDataVO;
import com.sealflow.model.vo.SealApplyRecordVO;
import com.sealflow.service.ISealApplyRecordService;
import com.sealflow.service.IBlockchainEvidenceService;
import jakarta.annotation.Resource;
import lombok.RequiredArgsConstructor;
import org.flowable.engine.TaskService;
import org.flowable.engine.HistoryService;
import org.flowable.task.api.history.HistoricTaskInstance;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class SealApplyRecordServiceImpl extends ServiceImpl<SealApplyRecordMapper, SealApplyRecord> implements ISealApplyRecordService {

    @Resource
    private SealApplyConverter converter;
    private final TaskService taskService;
    private final HistoryService historyService;
    private final IBlockchainEvidenceService blockchainEvidenceService;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void saveApprovalRecord(Long applyId, String processInstanceId, String taskId, String taskName, String taskKey, Integer approvalStage, Long approverId, String approverName, String approverRoleCode, String approverRoleName, Integer approveResult, String approveComment) {
        HistoricTaskInstance historicTask = historyService.createHistoricTaskInstanceQuery()
                .taskId(taskId)
                .singleResult();

        LocalDateTime taskStartTime = historicTask != null ?
                historicTask.getCreateTime().toInstant().atZone(java.time.ZoneId.systemDefault()).toLocalDateTime() : LocalDateTime.now();
        LocalDateTime taskEndTime = LocalDateTime.now();

        SealApplyRecord record = new SealApplyRecord();
        record.setApplyId(applyId);
        record.setProcessInstanceId(processInstanceId);
        record.setTaskId(taskId);
        record.setTaskName(taskName);
        record.setTaskKey(taskKey);
        record.setApprovalStage(approvalStage);
        record.setApproverId(approverId);
        record.setApproverName(approverName);
        record.setApproverRoleCode(approverRoleCode);
        record.setApproverRoleName(approverRoleName);
        record.setApproveResult(approveResult);
        record.setApproveComment(approveComment);
        record.setApproveTime(taskEndTime);
        record.setTaskStartTime(taskStartTime);
        record.setTaskEndTime(taskEndTime);

        this.save(record);

        ApprovalEvidenceDataVO approvalData = new ApprovalEvidenceDataVO();
        approvalData.setRecordId(record.getId());
        approvalData.setApplyId(applyId);
        approvalData.setApproverId(approverId);
        approvalData.setApproverName(approverName);
        approvalData.setApproveResult(approveResult);
        approvalData.setComment(approveComment);
        approvalData.setApproveTime(taskEndTime);

        blockchainEvidenceService.createEvidence(
                "APPROVE",
                record.getId(),
                approvalData,
                approverId,
                approverName
        );
    }

    @Override
    public List<SealApplyRecordVO> getApprovalRecordsByApplyId(Long applyId) {
        List<SealApplyRecord> records = this.list(new LambdaQueryWrapper<SealApplyRecord>()
                .eq(SealApplyRecord::getApplyId, applyId)
                .orderByAsc(SealApplyRecord::getApprovalStage));
        return records.stream()
                .map(this::enrichApprovalRecordVO)
                .collect(Collectors.toList());
    }

    @Override
    public List<SealApplyRecordVO> getApprovalRecordsByProcessInstanceId(String processInstanceId) {
        List<SealApplyRecord> records = this.list(new LambdaQueryWrapper<SealApplyRecord>()
                .eq(SealApplyRecord::getProcessInstanceId, processInstanceId)
                .orderByAsc(SealApplyRecord::getApprovalStage));
        return records.stream()
                .map(this::enrichApprovalRecordVO)
                .collect(Collectors.toList());
    }

    @Override
    public IPage<SealApplyRecordVO> pageApprovalRecords(SealApplyPageQuery queryParams) {
        Page<SealApplyRecord> page = new Page<>(queryParams.getPageNum(), queryParams.getPageSize());
        LambdaQueryWrapper<SealApplyRecord> wrapper = new LambdaQueryWrapper<>();

        if (queryParams.getProcessInstanceId() != null) {
            wrapper.eq(SealApplyRecord::getProcessInstanceId, queryParams.getProcessInstanceId());
        }

        wrapper.orderByAsc(SealApplyRecord::getApprovalStage);

        Page<SealApplyRecord> recordPage = this.baseMapper.selectPage(page, wrapper);
        IPage<SealApplyRecordVO> resultPage = converter.approvalRecordToVOForPage(recordPage);
        resultPage.getRecords().forEach(this::enrichApprovalRecordVO2);
        return resultPage;
    }

    @Override
    public SealApplyRecordVO getApprovalRecordByTaskId(String taskId) {
        SealApplyRecord record = this.getOne(new LambdaQueryWrapper<SealApplyRecord>()
                .eq(SealApplyRecord::getTaskId, taskId));
        if (record == null) {
            return null;
        }
        return enrichApprovalRecordVO(record);
    }

    private SealApplyRecordVO enrichApprovalRecordVO(SealApplyRecord record) {
        SealApplyRecordVO vo = converter.approvalRecordToVo(record);
        vo.setApprovalStageName(ApprovalStage.getNameByCode(record.getApprovalStage()));
        vo.setApproveResultName(ApproveResult.getNameByCode(record.getApproveResult()));
        return vo;
    }

    private SealApplyRecordVO enrichApprovalRecordVO2(SealApplyRecordVO vo) {
        vo.setApprovalStageName(ApprovalStage.getNameByCode(vo.getApprovalStage()));
        vo.setApproveResultName(ApproveResult.getNameByCode(vo.getApproveResult()));
        return vo;
    }
}
