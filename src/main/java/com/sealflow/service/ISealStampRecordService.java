package com.sealflow.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.sealflow.model.entity.SealStampRecord;

import java.util.List;

public interface ISealStampRecordService extends IService<SealStampRecord> {

    /**
     * 创建盖章记录
     */
    SealStampRecord createStampRecord(Long applyId, Long sealId, String sealName, Long stamperId, String stamperName,
                                     String pdfUrl, String sealImageUrl, Integer status, String remark);

    /**
     * 根据申请ID查询盖章记录
     */
    List<SealStampRecord> getByApplyId(Long applyId);

    /**
     * 根据盖章记录编号查询
     */
    SealStampRecord getByStampNo(String stampNo);

    /**
     * 分页查询盖章记录
     */
    IPage<SealStampRecord> pageRecords(Integer page, Integer size, Long applyId, String sealName, String stamperName);
}
