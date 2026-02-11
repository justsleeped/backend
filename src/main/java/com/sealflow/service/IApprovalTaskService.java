package com.sealflow.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.sealflow.model.query.ApprovalTaskPageQuery;
import com.sealflow.model.vo.ApprovalTaskVO;

/**
 * 审批任务管理服务接口
 */
public interface IApprovalTaskService {

    /**
     * 分页查询待办任务
     * @param queryParams 查询参数
     * @param userId 用户ID
     * @return 分页结果
     */
    IPage<ApprovalTaskVO> pageTodoTasks(ApprovalTaskPageQuery queryParams, Long userId);

    /**
     * 分页查询已办任务
     * @param queryParams 查询参数
     * @param userId 用户ID
     * @return 分页结果
     */
    IPage<ApprovalTaskVO> pageDoneTasks(ApprovalTaskPageQuery queryParams, Long userId);

    /**
     * 获取待办任务数量
     * @param userId 用户ID
     * @return 待办任务数量
     */
    Long getTodoTaskCount(Long userId);

    /**
     * 审批任务（同意）
     * @param taskId 任务ID
     * @param approveComment 审批意见
     * @param approverId 审批人ID
     */
    void approveTask(String taskId, String approveComment, Long approverId);

    /**
     * 审批任务（拒绝）
     * @param taskId 任务ID
     * @param rejectReason 拒绝原因
     * @param approverId 审批人ID
     */
    void rejectTask(String taskId, String rejectReason, Long approverId);
}
