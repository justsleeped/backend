package com.sealflow.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.sealflow.model.query.ApprovalTaskPageQuery;
import com.sealflow.model.vo.ApprovalTaskVO;
import com.sealflow.model.vo.SealApplyVO;

import java.util.List;

/**
 * 审批任务管理服务接口
 * 
 * 该接口专门负责审批任务相关的操作，包括：
 * - 待办任务查询
 * - 已办任务查询
 * - 审批操作（同意/拒绝）
 * - 任务详情查询
 * 
 * 将审批任务相关功能从业务服务中分离，实现职责单一原则。
 */
public interface IApprovalTaskService {

    /**
     * 分页查询待办任务
     * 
     * 查询分配给当前用户的任务以及用户所属角色候选的任务。
     * 
     * @param queryParams 查询参数
     * @param userId 用户ID
     * @return 分页结果
     */
    IPage<ApprovalTaskVO> pageTodoTasks(ApprovalTaskPageQuery queryParams, Long userId);

    /**
     * 分页查询已办任务
     * 
     * 查询当前用户已经审批过的所有任务。
     * 
     * @param queryParams 查询参数
     * @param userId 用户ID
     * @return 分页结果
     */
    IPage<ApprovalTaskVO> pageDoneTasks(ApprovalTaskPageQuery queryParams, Long userId);

    /**
     * 获取待办任务数量
     * 
     * @param userId 用户ID
     * @return 待办任务数量
     */
    Long getTodoTaskCount(Long userId);

    /**
     * 获取任务详情
     * 
     * @param taskId 任务ID
     * @return 任务详情VO
     */
    ApprovalTaskVO getTaskDetail(String taskId);

    /**
     * 审批任务（同意）
     * 
     * @param taskId 任务ID
     * @param approveComment 审批意见
     * @param approverId 审批人ID
     */
    void approveTask(String taskId, String approveComment, Long approverId);

    /**
     * 审批任务（拒绝）
     * 
     * @param taskId 任务ID
     * @param rejectReason 拒绝原因
     * @param approverId 审批人ID
     */
    void rejectTask(String taskId, String rejectReason, Long approverId);

    /**
     * 获取任务的申请详情
     * 
     * @param taskId 任务ID
     * @return 申请详情VO
     */
    SealApplyVO getApplyByTaskId(String taskId);

    /**
     * 验证用户是否有权限处理该任务
     * 
     * @param taskId 任务ID
     * @param userId 用户ID
     * @return 是否有权限
     */
    boolean hasPermission(String taskId, Long userId);
}
