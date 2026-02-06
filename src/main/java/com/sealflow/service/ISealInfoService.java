package com.sealflow.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.sealflow.model.entity.SealInfo;
import com.sealflow.model.form.SealInfoForm;
import com.sealflow.model.query.SealInfoPageQuery;
import com.sealflow.model.vo.SealInfoVO;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface ISealInfoService extends IService<SealInfo> {

    /**
     * 保存印章信息
     */
    Long saveSealInfo(SealInfoForm formData);

    /**
     * 更新印章信息
     */
    void updateSealInfo(Long id, SealInfoForm formData);

    /**
     * 删除印章信息
     */
    void deleteSealInfo(String idStr);

    /**
     * 根据ID获取印章信息
     */
    SealInfoVO getSealInfoVo(Long id);

    /**
     * 分页查询印章信息
     */
    IPage<SealInfoVO> pageSealInfo(SealInfoPageQuery queryParams);

    /**
     * 列表查询印章信息
     */
    List<SealInfoVO> listSealInfo(SealInfoPageQuery queryParams);

    /**
     * 上传印章图片
     */
    String uploadSealImage(MultipartFile file);
}
