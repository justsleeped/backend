package com.sealflow.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.sealflow.model.entity.PartyApprovalRecord;
import com.sealflow.model.query.PartyApplyPageQuery;
import com.sealflow.model.vo.PartyApprovalRecordVO;

import java.util.List;

public interface IPartyApprovalRecordService extends IService<PartyApprovalRecord> {

    void saveApprovalRecord(Long applyId, String processInstanceId, String taskId, String taskName, String taskKey, Integer approvalStage, Long approverId, String approverName, String approverRoleCode, String approverRoleName, Integer approveResult, String approveComment);

    List<PartyApprovalRecordVO> getApprovalRecordsByApplyId(Long applyId);

    List<PartyApprovalRecordVO> getApprovalRecordsByProcessInstanceId(String processInstanceId);

    IPage<PartyApprovalRecordVO> pageApprovalRecords(PartyApplyPageQuery queryParams);

    PartyApprovalRecordVO getApprovalRecordByTaskId(String taskId);
}
