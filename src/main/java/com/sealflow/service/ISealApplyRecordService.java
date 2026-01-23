package com.sealflow.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.sealflow.model.entity.SealApplyRecord;
import com.sealflow.model.query.SealApplyPageQuery;
import com.sealflow.model.vo.SealApplyRecordVO;

import java.util.List;

public interface ISealApplyRecordService extends IService<SealApplyRecord> {

    void saveApprovalRecord(Long applyId, String processInstanceId, String taskId, String taskName, String taskKey, Integer approvalStage, Long approverId, String approverName, String approverRoleCode, String approverRoleName, Integer approveResult, String approveComment);

    List<SealApplyRecordVO> getApprovalRecordsByApplyId(Long applyId);

    List<SealApplyRecordVO> getApprovalRecordsByProcessInstanceId(String processInstanceId);

    IPage<SealApplyRecordVO> pageApprovalRecords(SealApplyPageQuery queryParams);

    SealApplyRecordVO getApprovalRecordByTaskId(String taskId);
}
