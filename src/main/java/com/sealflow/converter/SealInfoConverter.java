package com.sealflow.converter;

import com.sealflow.model.entity.SealInfo;
import com.sealflow.model.form.SealInfoForm;
import com.sealflow.model.vo.SealInfoVO;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.mapstruct.Mapper;

import java.util.List;

@Mapper(componentModel = "spring")
public interface SealInfoConverter {

    SealInfoForm entityToForm(SealInfo sealInfo);

    SealInfoVO entityToVo(SealInfo sealInfo);

    List<SealInfoVO> entityToVo(List<SealInfo> sealInfoList);

    SealInfo formToEntity(SealInfoForm sealInfoForm);

    List<SealInfo> formToEntity(List<SealInfoForm> sealInfoFormList);

    Page<SealInfoVO> entityToVOForPage(Page<SealInfo> entityPage);
}