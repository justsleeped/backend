package com.sealflow.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.sealflow.model.entity.PartyApply;
import com.sealflow.model.form.PartyApplyForm;
import com.sealflow.model.query.PartyApplyPageQuery;
import com.sealflow.model.vo.PartyApplyVO;

import java.util.List;

public interface IPartyApplyService extends IService<PartyApply> {

    Long savePartyApply(PartyApplyForm formData);

    void updatePartyApply(Long id, PartyApplyForm formData);

    void deletePartyApply(String idStr);

    PartyApplyVO getPartyApplyVo(Long id);

    IPage<PartyApplyVO> pagePartyApply(PartyApplyPageQuery queryParams);

    List<PartyApplyVO> listPartyApply(PartyApplyPageQuery queryParams);

    void startProcess(Long applyId);

    void approveTask(String taskId, Integer approveResult, String approveComment, Long approverId);

    void revokeProcess(Long applyId, Long userId);

    IPage<PartyApplyVO> pageMyStarted(PartyApplyPageQuery queryParams, Long userId);

    IPage<PartyApplyVO> pageMyApproved(PartyApplyPageQuery queryParams, Long userId);

    IPage<PartyApplyVO> pageTodoTasks(PartyApplyPageQuery queryParams, Long userId);

    PartyApplyVO getProcessDetail(String processInstanceId);
}
