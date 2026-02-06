package com.sealflow.service.Impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.sealflow.mapper.SealStampRecordMapper;
import com.sealflow.model.entity.SealStampRecord;
import com.sealflow.service.ISealStampRecordService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Slf4j
@Service
@RequiredArgsConstructor
public class SealStampRecordServiceImpl extends ServiceImpl<SealStampRecordMapper, SealStampRecord> implements ISealStampRecordService {

    @Override
    @Transactional(rollbackFor = Exception.class)
    public SealStampRecord createStampRecord(Long applyId, Long sealId, String sealName, Long stamperId, String stamperName,
                                           String pdfUrl, String sealImageUrl, Integer status, String remark) {
        SealStampRecord record = new SealStampRecord();
        record.setStampNo(generateStampNo());
        record.setApplyId(applyId);
        record.setSealId(sealId);
        record.setSealName(sealName);
        record.setStamperId(stamperId);
        record.setStamperName(stamperName);
        record.setPdfUrl(pdfUrl);
        record.setSealImageUrl(sealImageUrl);
        record.setStampTime(LocalDateTime.now());
        record.setStatus(status);
        record.setRemark(remark);

        save(record);
        log.info("Created stamp record: {}, applyId: {}, sealName: {}", record.getStampNo(), applyId, sealName);
        return record;
    }

    @Override
    public List<SealStampRecord> getByApplyId(Long applyId) {
        LambdaQueryWrapper<SealStampRecord> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(SealStampRecord::getApplyId, applyId)
                .orderByDesc(SealStampRecord::getStampTime);
        return list(wrapper);
    }

    @Override
    public SealStampRecord getByStampNo(String stampNo) {
        LambdaQueryWrapper<SealStampRecord> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(SealStampRecord::getStampNo, stampNo);
        return getOne(wrapper);
    }

    @Override
    public IPage<SealStampRecord> pageRecords(Integer page, Integer size, Long applyId, String sealName, String stamperName) {
        Page<SealStampRecord> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<SealStampRecord> wrapper = new LambdaQueryWrapper<>();

        if (applyId != null) {
            wrapper.eq(SealStampRecord::getApplyId, applyId);
        }
        if (sealName != null && !sealName.isEmpty()) {
            wrapper.like(SealStampRecord::getSealName, sealName);
        }
        if (stamperName != null && !stamperName.isEmpty()) {
            wrapper.like(SealStampRecord::getStamperName, stamperName);
        }

        wrapper.orderByDesc(SealStampRecord::getStampTime);
        return page(pageParam, wrapper);
    }

    private String generateStampNo() {
        return "ST" + System.currentTimeMillis() + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
    }
}
