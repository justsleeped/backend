package com.sealflow.service.Impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.sealflow.converter.PartyApplyConverter;
import com.sealflow.mapper.PartyApprovalRecordMapper;
import com.sealflow.model.entity.PartyApprovalRecord;
import com.sealflow.model.query.PartyApplyPageQuery;
import com.sealflow.model.vo.PartyApprovalRecordVO;
import com.sealflow.service.IPartyApprovalRecordService;
import jakarta.annotation.Resource;
import lombok.RequiredArgsConstructor;
import org.flowable.engine.TaskService;
import org.flowable.engine.HistoryService;
import org.flowable.task.api.history.HistoricTaskInstance;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class PartyApprovalRecordServiceImpl extends ServiceImpl<PartyApprovalRecordMapper, PartyApprovalRecord> implements IPartyApprovalRecordService {

    @Resource
    private PartyApplyConverter converter;
    private final TaskService taskService;
    private final HistoryService historyService;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void saveApprovalRecord(Long applyId, String processInstanceId, String taskId, String taskName, String taskKey, Integer approvalStage, Long approverId, String approverName, String approverRoleCode, String approverRoleName, Integer approveResult, String approveComment) {
        HistoricTaskInstance historicTask = historyService.createHistoricTaskInstanceQuery()
                .taskId(taskId)
                .singleResult();

        LocalDateTime taskStartTime = historicTask != null ?
                historicTask.getCreateTime().toInstant().atZone(java.time.ZoneId.systemDefault()).toLocalDateTime() : LocalDateTime.now();
        LocalDateTime taskEndTime = LocalDateTime.now();

        PartyApprovalRecord record = new PartyApprovalRecord();
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
    }

    @Override
    public List<PartyApprovalRecordVO> getApprovalRecordsByApplyId(Long applyId) {
        List<PartyApprovalRecord> records = this.list(new LambdaQueryWrapper<PartyApprovalRecord>()
                .eq(PartyApprovalRecord::getApplyId, applyId)
                .orderByAsc(PartyApprovalRecord::getApprovalStage));
        return records.stream()
                .map(this::enrichApprovalRecordVO)
                .collect(Collectors.toList());
    }

    @Override
    public List<PartyApprovalRecordVO> getApprovalRecordsByProcessInstanceId(String processInstanceId) {
        List<PartyApprovalRecord> records = this.list(new LambdaQueryWrapper<PartyApprovalRecord>()
                .eq(PartyApprovalRecord::getProcessInstanceId, processInstanceId)
                .orderByAsc(PartyApprovalRecord::getApprovalStage));
        return records.stream()
                .map(this::enrichApprovalRecordVO)
                .collect(Collectors.toList());
    }

    @Override
    public IPage<PartyApprovalRecordVO> pageApprovalRecords(PartyApplyPageQuery queryParams) {
        Page<PartyApprovalRecord> page = new Page<>(queryParams.getPageNum(), queryParams.getPageSize());
        LambdaQueryWrapper<PartyApprovalRecord> wrapper = new LambdaQueryWrapper<>();

        if (queryParams.getProcessInstanceId() != null) {
            wrapper.eq(PartyApprovalRecord::getProcessInstanceId, queryParams.getProcessInstanceId());
        }

        wrapper.orderByAsc(PartyApprovalRecord::getApprovalStage);

        Page<PartyApprovalRecord> recordPage = this.baseMapper.selectPage(page, wrapper);
        IPage<PartyApprovalRecordVO> resultPage = converter.approvalRecordToVOForPage(recordPage);
        resultPage.getRecords().forEach(this::enrichApprovalRecordVO2);
        return resultPage;
    }

    @Override
    public PartyApprovalRecordVO getApprovalRecordByTaskId(String taskId) {
        PartyApprovalRecord record = this.getOne(new LambdaQueryWrapper<PartyApprovalRecord>()
                .eq(PartyApprovalRecord::getTaskId, taskId));
        if (record == null) {
            return null;
        }
        return enrichApprovalRecordVO(record);
    }

    private PartyApprovalRecordVO enrichApprovalRecordVO(PartyApprovalRecord record) {
        PartyApprovalRecordVO vo = converter.approvalRecordToVo(record);
        vo.setApprovalStageName(getApprovalStageName(record.getApprovalStage()));
        vo.setApproveResultName(getApproveResultName(record.getApproveResult()));
        return vo;
    }

    private PartyApprovalRecordVO enrichApprovalRecordVO2(PartyApprovalRecordVO vo) {
        vo.setApprovalStageName(getApprovalStageName(vo.getApprovalStage()));
        vo.setApproveResultName(getApproveResultName(vo.getApproveResult()));
        return vo;
    }

    private String getApprovalStageName(Integer approvalStage) {
        if (approvalStage == null) {
            return "";
        }
        switch (approvalStage) {
            case 1:
                return "班主任";
            case 2:
                return "辅导员";
            case 3:
                return "学院院长";
            case 4:
                return "党委书记";
            default:
                return "";
        }
    }

    private String getApproveResultName(Integer approveResult) {
        if (approveResult == null) {
            return "";
        }
        switch (approveResult) {
            case 1:
                return "同意";
            case 2:
                return "拒绝";
            default:
                return "";
        }
    }
}
