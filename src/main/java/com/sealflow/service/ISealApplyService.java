package com.sealflow.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.sealflow.model.entity.SealApply;
import com.sealflow.model.form.SealApplyForm;
import com.sealflow.model.query.SealApplyPageQuery;
import com.sealflow.model.vo.SealApplyVO;

import java.util.List;

/**
 * 印章申请服务接口
 * 提供印章申请相关的业务操作，包括增删改查、流程审批等功能
 */
public interface ISealApplyService extends IService<SealApply> {

    /**
     * 保存印章申请
     *
     * @param formData 申请表单数据
     * @return 申请记录ID
     */
    Long saveSealApply(SealApplyForm formData);

    /**
     * 更新印章申请
     *
     * @param id       申请记录ID
     * @param formData 申请表单数据
     */
    void updateSealApply(Long id, SealApplyForm formData);

    /**
     * 删除印章申请
     *
     * @param idStr 申请记录ID字符串（支持多个ID，逗号分隔）
     */
    void deleteSealApply(String idStr);

    /**
     * 根据ID获取印章申请详情
     *
     * @param id 申请记录ID
     * @return 印章申请视图对象
     */
    SealApplyVO getSealApplyVo(Long id);

    /**
     * 分页查询印章申请列表
     *
     * @param queryParams 查询参数
     * @return 分页结果
     */
    IPage<SealApplyVO> pageSealApply(SealApplyPageQuery queryParams);

    /**
     * 获取印章申请列表
     *
     * @param queryParams 查询参数
     * @return 列表结果
     */
    List<SealApplyVO> listSealApply(SealApplyPageQuery queryParams);

    /**
     * 启动审批流程
     *
     * @param applyId 申请记录ID
     */
    void startProcess(Long applyId);

    /**
     * 审批任务
     *
     * @param taskId         任务ID
     * @param approveResult  审批结果（1-通过，0-拒绝）
     * @param approveComment 审批意见
     * @param approverId     审批人ID
     */
    void approveTask(String taskId, Integer approveResult, String approveComment, Long approverId);

    /**
     * 撤销审批流程
     *
     * @param applyId 申请记录ID
     * @param userId  操作用户ID
     */
    void revokeProcess(Long applyId, Long userId);

    /**
     * 分页查询我发起的印章申请
     *
     * @param queryParams 查询参数
     * @param userId      用户ID
     * @return 分页结果
     */
    IPage<SealApplyVO> pageMyStarted(SealApplyPageQuery queryParams, Long userId);
}

