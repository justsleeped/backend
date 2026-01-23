package com.sealflow.converter;

import com.sealflow.model.entity.SealApply;
import com.sealflow.model.entity.SealApplyRecord;
import com.sealflow.model.form.SealApplyForm;
import com.sealflow.model.vo.SealApplyVO;
import com.sealflow.model.vo.SealApplyRecordVO;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.mapstruct.NullValuePropertyMappingStrategy;

import java.util.List;

@Mapper(componentModel = "spring", nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
public interface SealApplyConverter {

    SealApplyForm entityToForm(SealApply sealApply);

    SealApplyVO entityToVo(SealApply sealApply);

    List<SealApplyVO> entityToVo(List<SealApply> sealApply);

    SealApply formToEntity(SealApplyForm sealApplyForm);

    List<SealApply> formToEntity(List<SealApplyForm> sealApplyForm);

    Page<SealApplyVO> entityToVOForPage(Page<SealApply> bo);

    @Mapping(target = "approvalStageName", ignore = true)
    @Mapping(target = "approveResultName", ignore = true)
    SealApplyRecordVO approvalRecordToVo(SealApplyRecord sealApplyRecord);

    @Mapping(target = "approvalStageName", ignore = true)
    @Mapping(target = "approveResultName", ignore = true)
    List<SealApplyRecordVO> approvalRecordToVo(List<SealApplyRecord> sealApplyRecord);

    // For Page conversion, we need to convert the records inside the page
    default Page<SealApplyRecordVO> approvalRecordToVOForPage(Page<SealApplyRecord> bo) {
        Page<SealApplyRecordVO> result = new Page<>();
        result.setCurrent(bo.getCurrent());
        result.setSize(bo.getSize());
        result.setTotal(bo.getTotal());
        result.setPages(bo.getPages());
        result.setRecords(approvalRecordToVo(bo.getRecords()));
        return result;
    }
}
