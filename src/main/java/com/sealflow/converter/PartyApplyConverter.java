package com.sealflow.converter;

import com.sealflow.model.entity.PartyApply;
import com.sealflow.model.entity.PartyApprovalRecord;
import com.sealflow.model.form.PartyApplyForm;
import com.sealflow.model.vo.PartyApplyVO;
import com.sealflow.model.vo.PartyApprovalRecordVO;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.mapstruct.Mapper;

import java.util.List;

@Mapper(componentModel = "spring")
public interface PartyApplyConverter {

    PartyApplyForm entityToForm(PartyApply partyApply);

    PartyApplyVO entityToVo(PartyApply partyApply);

    List<PartyApplyVO> entityToVo(List<PartyApply> partyApply);

    PartyApply formToEntity(PartyApplyForm partyApplyForm);

    List<PartyApply> formToEntity(List<PartyApplyForm> partyApplyForm);

    Page<PartyApplyVO> entityToVOForPage(Page<PartyApply> bo);

    PartyApprovalRecordVO approvalRecordToVo(PartyApprovalRecord partyApprovalRecord);

    List<PartyApprovalRecordVO> approvalRecordToVo(List<PartyApprovalRecord> partyApprovalRecord);

    Page<PartyApprovalRecordVO> approvalRecordToVOForPage(Page<PartyApprovalRecord> bo);
}
