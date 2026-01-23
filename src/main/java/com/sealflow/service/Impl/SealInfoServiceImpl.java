package com.sealflow.service.Impl;

import cn.hutool.core.lang.Assert;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.sealflow.converter.SealInfoConverter;
import com.sealflow.mapper.SealInfoMapper;
import com.sealflow.model.entity.SealInfo;
import com.sealflow.model.form.SealInfoForm;
import com.sealflow.model.query.SealInfoPageQuery;
import com.sealflow.model.vo.SealInfoVO;
import com.sealflow.service.ISealInfoService;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class SealInfoServiceImpl extends ServiceImpl<SealInfoMapper, SealInfo> implements ISealInfoService {

    private final SealInfoConverter converter;

    /**
     * 保存印章信息
     *
     * @param formData 印章信息表单数据
     */
    @Override
    public Long saveSealInfo(SealInfoForm formData) {
        SealInfo entity = converter.formToEntity(formData);
        Assert.isTrue(this.save(entity), "添加失败");
        return entity.getId();
    }

    /**
     * 更新印章信息
     *
     * @param id       主键id
     * @param formData 印章信息表单数据
     */
    @Override
    public void updateSealInfo(Long id, SealInfoForm formData) {
        //判断数据是否存在
        getEntity(id);
        SealInfo entity = converter.formToEntity(formData);
        entity.setId(id);
        Assert.isTrue(this.updateById(entity), "修改失败");
    }

    /**
     * 删除印章信息
     *
     * @param idStr 印章信息IDs
     */
    @Override
    public void deleteSealInfo(String idStr) {
        Assert.isFalse(StringUtils.isEmpty(idStr), "id不能为空");
        // 逻辑删除
        List<Long> ids = Arrays.stream(idStr.split(","))
                .map(Long::parseLong)
                .collect(Collectors.toList());
        LambdaUpdateWrapper<SealInfo> wrapper = new LambdaUpdateWrapper<>();
        wrapper.set(SealInfo::getDeleted, 1)
                .in(SealInfo::getId, ids);
        Assert.isTrue(this.update(wrapper), "删除失败");
    }

    /**
     * 通过ID获取印章信息
     *
     * @param id 主键
     * @return SealInfoVO 表单对象
     */
    @Override
    public SealInfoVO getSealInfoVo(Long id) {
        SealInfo entity = getEntity(id);
        return converter.entityToVo(entity);
    }

    /**
     * 分页查询印章信息
     *
     * @param queryParams 筛选条件
     * @return IPage<SealInfoVO> 分页对象
     */
    @Override
    public IPage<SealInfoVO> pageSealInfo(SealInfoPageQuery queryParams) {
        // 参数构建
        Page<SealInfo> page = new Page<>(queryParams.getPageNum(), queryParams.getPageSize());
        // 添加查询条件
        Page<SealInfo> sealInfoPage = this.baseMapper.selectPage(page, getQueryWrapper(queryParams));
        // 实体转换
        return converter.entityToVOForPage(sealInfoPage);
    }

    @Override
    public List<SealInfoVO> listSealInfo(SealInfoPageQuery queryParams) {
        LambdaQueryWrapper<SealInfo> wrapper = getQueryWrapper(queryParams);
        List<SealInfo> entities = this.list(wrapper);
        // 实体转换
        return converter.entityToVo(entities);
    }

    /**
     * 构建查询条件
     */
    private LambdaQueryWrapper<SealInfo> getQueryWrapper(SealInfoPageQuery queryParams) {
        LambdaQueryWrapper<SealInfo> qw = new LambdaQueryWrapper<>();
        qw.eq(SealInfo::getDeleted, 0);
        if (queryParams != null) {
            qw.like(StringUtils.isNotBlank(queryParams.getName()), SealInfo::getName, queryParams.getName());
            qw.eq(queryParams.getCategory() != null, SealInfo::getCategory, queryParams.getCategory());
            qw.eq(queryParams.getStatus() != null, SealInfo::getStatus, queryParams.getStatus());
            qw.eq(queryParams.getSealType() != null, SealInfo::getSealType, queryParams.getSealType());
        }
        qw.orderByDesc(SealInfo::getCreateTime);
        return qw;
    }

    private SealInfo getEntity(Long id) {
        SealInfo entity = this.getOne(new LambdaQueryWrapper<SealInfo>()
                .eq(SealInfo::getId, id)
                .eq(SealInfo::getDeleted, 0)
        );
        Assert.isTrue(null != entity, "数据不存在");
        return entity;
    }
}
