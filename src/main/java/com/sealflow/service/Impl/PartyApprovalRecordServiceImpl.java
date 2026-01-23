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

/**
 * 党章审批记录服务实现类
 * 
 * 主要功能：
 * 1. 保存审批记录
 * 2. 根据申请ID查询审批记录列表
 * 3. 根据流程实例ID查询审批记录列表
 * 4. 分页查询审批记录
 * 5. 根据任务ID查询审批记录
 * 6. 丰富审批记录VO信息（设置审批阶段名称、审批结果名称）
 */
@Service
@RequiredArgsConstructor
public class PartyApprovalRecordServiceImpl extends ServiceImpl<PartyApprovalRecordMapper, PartyApprovalRecord> implements IPartyApprovalRecordService {

    @Resource
    private PartyApplyConverter converter;
    private final TaskService taskService;
    private final HistoryService historyService;

    /**
     * 保存审批记录
     * 
     * 功能说明：
     * 1. 查询历史任务实例，获取任务开始时间
     * 2. 设置任务结束时间为当前时间
     * 3. 保存审批记录到数据库
     * 
     * @param applyId 申请ID
     * @param processInstanceId 流程实例ID
     * @param taskId 任务ID
     * @param taskName 任务名称
     * @param taskKey 任务Key
     * @param approvalStage 审批阶段
     * @param approverId 审批人ID
     * @param approverName 审批人姓名
     * @param approverRoleCode 审批角色编码
     * @param approverRoleName 审批角色名称
     * @param approveResult 审批结果（1-同意，2-拒绝）
     * @param approveComment 审批意见
     */
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

    /**
     * 根据申请ID查询审批记录列表
     * 
     * 功能说明：
     * 1. 根据申请ID查询所有审批记录
     * 2. 按审批阶段升序排序
     * 3. 丰富VO信息（设置审批阶段名称、审批结果名称）
     * 
     * @param applyId 申请ID
     * @return 审批记录VO列表
     */
    @Override
    public List<PartyApprovalRecordVO> getApprovalRecordsByApplyId(Long applyId) {
        List<PartyApprovalRecord> records = this.list(new LambdaQueryWrapper<PartyApprovalRecord>()
                .eq(PartyApprovalRecord::getApplyId, applyId)
                .orderByAsc(PartyApprovalRecord::getApprovalStage));
        return records.stream()
                .map(this::enrichApprovalRecordVO)
                .collect(Collectors.toList());
    }

    /**
     * 根据流程实例ID查询审批记录列表
     * 
     * 功能说明：
     * 1. 根据流程实例ID查询所有审批记录
     * 2. 按审批阶段升序排序
     * 3. 丰富VO信息（设置审批阶段名称、审批结果名称）
     * 
     * @param processInstanceId 流程实例ID
     * @return 审批记录VO列表
     */
    @Override
    public List<PartyApprovalRecordVO> getApprovalRecordsByProcessInstanceId(String processInstanceId) {
        List<PartyApprovalRecord> records = this.list(new LambdaQueryWrapper<PartyApprovalRecord>()
                .eq(PartyApprovalRecord::getProcessInstanceId, processInstanceId)
                .orderByAsc(PartyApprovalRecord::getApprovalStage));
        return records.stream()
                .map(this::enrichApprovalRecordVO)
                .collect(Collectors.toList());
    }

    /**
     * 分页查询审批记录
     * 
     * 功能说明：
     * 1. 支持根据流程实例ID过滤
     * 2. 按审批阶段升序排序
     * 3. 丰富VO信息（设置审批阶段名称、审批结果名称）
     * 
     * @param queryParams 查询条件
     * @return 分页结果
     */
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

    /**
     * 根据任务ID查询审批记录
     * 
     * @param taskId 任务ID
     * @return 审批记录VO
     */
    @Override
    public PartyApprovalRecordVO getApprovalRecordByTaskId(String taskId) {
        PartyApprovalRecord record = this.getOne(new LambdaQueryWrapper<PartyApprovalRecord>()
                .eq(PartyApprovalRecord::getTaskId, taskId));
        if (record == null) {
            return null;
        }
        return enrichApprovalRecordVO(record);
    }

    /**
     * 丰富审批记录VO信息
     * 
     * 功能说明：
     * 设置审批阶段名称和审批结果名称
     * 
     * @param record 审批记录实体
     * @return 审批记录VO
     */
    private PartyApprovalRecordVO enrichApprovalRecordVO(PartyApprovalRecord record) {
        PartyApprovalRecordVO vo = converter.approvalRecordToVo(record);
        vo.setApprovalStageName(getApprovalStageName(record.getApprovalStage()));
        vo.setApproveResultName(getApproveResultName(record.getApproveResult()));
        return vo;
    }

    /**
     * 丰富审批记录VO信息（重载方法）
     * 
     * 功能说明：
     * 设置审批阶段名称和审批结果名称
     * 
     * @param vo 审批记录VO
     * @return 审批记录VO
     */
    private PartyApprovalRecordVO enrichApprovalRecordVO2(PartyApprovalRecordVO vo) {
        vo.setApprovalStageName(getApprovalStageName(vo.getApprovalStage()));
        vo.setApproveResultName(getApproveResultName(vo.getApproveResult()));
        return vo;
    }

    /**
     * 根据审批阶段获取阶段名称
     * 
     * @param approvalStage 审批阶段
     * @return 阶段名称
     */
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

    /**
     * 根据审批结果获取结果名称
     * 
     * @param approveResult 审批结果
     * @return 结果名称
     */
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
