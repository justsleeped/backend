package com.sealflow.service.Impl;

import cn.hutool.core.lang.Assert;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sealflow.common.enums.ApplyStatus;
import com.sealflow.common.enums.SealCategory;
import com.sealflow.common.enums.SealType;
import com.sealflow.model.entity.SealApply;
import com.sealflow.model.entity.SealApplyRecord;
import com.sealflow.model.query.ApprovalTaskPageQuery;
import com.sealflow.model.vo.ApprovalTaskVO;
import com.sealflow.model.vo.SealApplyVO;
import com.sealflow.model.vo.SysRoleVO;
import com.sealflow.model.vo.SysUserVO;
import com.sealflow.service.IApprovalTaskService;
import com.sealflow.service.IFlowableService;
import com.sealflow.service.ISealApplyRecordService;
import com.sealflow.service.ISealApplyService;
import com.sealflow.service.ISysUserRoleService;
import com.sealflow.service.ISysUserService;
import lombok.RequiredArgsConstructor;
import org.flowable.engine.HistoryService;
import org.flowable.engine.RepositoryService;
import org.flowable.engine.repository.ProcessDefinition;
import org.flowable.task.api.Task;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 审批任务管理服务实现类
 * 该类专门负责审批任务相关的操作，包括：
 * - 待办任务查询
 * - 已办任务查询
 * - 审批操作（同意/拒绝）
 * - 任务详情查询
 * 职责说明：
 * - 不直接操作业务数据，通过ISealApplyService和ISealApplyRecordService完成
 * - 通过IFlowableService与Flowable引擎交互
 * - 专注于审批任务的查询和处理逻辑
 */
@Service
@RequiredArgsConstructor
public class ApprovalTaskServiceImpl implements IApprovalTaskService {

    /**
     * Flowable工作流服务
     */
    private final IFlowableService flowableService;

    /**
     * 印章申请服务
     */
    private final ISealApplyService sealApplyService;

    /**
     * 印章申请审批记录服务
     */
    private final ISealApplyRecordService approvalRecordService;

    /**
     * 系统用户服务
     */
    private final ISysUserService sysUserService;

    /**
     * 系统用户角色服务
     */
    private final ISysUserRoleService sysUserRoleService;

	/**
     * Flowable流程定义存储服务
     */
    private final RepositoryService repositoryService;

    /**
     * 分页查询待办任务
     * 查询分配给当前用户的任务以及用户所属角色候选的任务。
     * @param queryParams 查询参数
     * @param userId 用户ID
     * @return 分页结果
     */
    @Override
    public IPage<ApprovalTaskVO> pageTodoTasks(ApprovalTaskPageQuery queryParams, Long userId) {

		List<Task> assignedTasks = flowableService.getTasksByAssignee(userId.toString());
		Set<String> processInstanceIds = new HashSet<>(assignedTasks.stream()
				.map(Task::getProcessInstanceId)
				.toList());

        List<Long> roleIds = sysUserRoleService.getRoleIdsByUserId(userId);
        if (roleIds != null && !roleIds.isEmpty()) {
            SysUserVO userVO = sysUserService.getSysUserVo(userId);
            if (userVO != null && userVO.getRoles() != null && !userVO.getRoles().isEmpty()) {
                List<String> roleCodes = userVO.getRoles().stream()
                        .map(SysRoleVO::getCode)
                        .collect(Collectors.toList());

                List<Task> candidateTasks = flowableService.getTasksByCandidateGroups(roleCodes);
                processInstanceIds.addAll(candidateTasks.stream()
                        .map(Task::getProcessInstanceId)
                        .toList());
            }
        }

        if (processInstanceIds.isEmpty()) {
            return new Page<>(queryParams.getPageNum(), queryParams.getPageSize());
        }

        List<SealApply> sealApplies = sealApplyService.list(
                new LambdaQueryWrapper<SealApply>()
                        .in(SealApply::getProcessInstanceId, processInstanceIds)
                        .eq(SealApply::getDeleted, 0));

        Map<String, SealApply> applyMap = sealApplies.stream()
                .collect(Collectors.toMap(SealApply::getProcessInstanceId, apply -> apply));

		List<Task> allTasks = new ArrayList<>(assignedTasks);
        if (roleIds != null && !roleIds.isEmpty()) {
            SysUserVO userVO = sysUserService.getSysUserVo(userId);
            if (userVO != null && userVO.getRoles() != null && !userVO.getRoles().isEmpty()) {
                List<String> roleCodes = userVO.getRoles().stream()
                        .map(SysRoleVO::getCode)
                        .collect(Collectors.toList());
                allTasks.addAll(flowableService.getTasksByCandidateGroups(roleCodes));
            }
        }

        List<ApprovalTaskVO> taskVOList = allTasks.stream()
                .filter(task -> applyMap.containsKey(task.getProcessInstanceId()))
                .map(task -> convertToTaskVO(task, applyMap.get(task.getProcessInstanceId()), 1, null))
                .filter(Objects::nonNull)
                .filter(vo -> matchQueryParams(vo, queryParams))
                .collect(Collectors.toList());

        Page<ApprovalTaskVO> page = new Page<>(queryParams.getPageNum(), queryParams.getPageSize(), taskVOList.size());
        int fromIndex = (queryParams.getPageNum() - 1) * queryParams.getPageSize();
        int toIndex = Math.min(fromIndex + queryParams.getPageSize(), taskVOList.size());
        if (fromIndex < taskVOList.size()) {
            page.setRecords(taskVOList.subList(fromIndex, toIndex));
        }

        return page;
    }

    /**
     * 分页查询已办任务
     * 查询当前用户已经审批过的所有任务。
     * @param queryParams 查询参数
     * @param userId 用户ID
     * @return 分页结果
     */
    @Override
    public IPage<ApprovalTaskVO> pageDoneTasks(ApprovalTaskPageQuery queryParams, Long userId) {
        List<SealApplyRecord> approvalRecords = approvalRecordService.list(
                new LambdaQueryWrapper<SealApplyRecord>()
                        .eq(SealApplyRecord::getApproverId, userId)
                        .orderByDesc(SealApplyRecord::getApproveTime));

        if (approvalRecords.isEmpty()) {
            return new Page<>(queryParams.getPageNum(), queryParams.getPageSize());
        }

        Set<Long> applyIds = approvalRecords.stream()
                .map(SealApplyRecord::getApplyId)
                .collect(Collectors.toSet());

        List<SealApply> sealApplies = sealApplyService.list(
                new LambdaQueryWrapper<SealApply>()
                        .in(SealApply::getId, applyIds)
                        .eq(SealApply::getDeleted, 0));

        Map<Long, SealApply> applyMap = sealApplies.stream()
                .collect(Collectors.toMap(SealApply::getId, apply -> apply));

        List<ApprovalTaskVO> taskVOList = approvalRecords.stream()
                .filter(record -> applyMap.containsKey(record.getApplyId()))
                .map(record -> convertToDoneTaskVO(record, applyMap.get(record.getApplyId())))
                .filter(Objects::nonNull)
                .filter(vo -> matchQueryParams(vo, queryParams))
                .collect(Collectors.toList());

        Page<ApprovalTaskVO> page = new Page<>(queryParams.getPageNum(), queryParams.getPageSize(), taskVOList.size());
        int fromIndex = (queryParams.getPageNum() - 1) * queryParams.getPageSize();
        int toIndex = Math.min(fromIndex + queryParams.getPageSize(), taskVOList.size());
        if (fromIndex < taskVOList.size()) {
            page.setRecords(taskVOList.subList(fromIndex, toIndex));
        }

        return page;
    }

    /**
     * 获取待办任务数量
     *
     * @param userId 用户ID
     * @return 待办任务数量
     */
    @Override
    public Long getTodoTaskCount(Long userId) {

		List<Task> assignedTasks = flowableService.getTasksByAssignee(userId.toString());
		Set<String> processInstanceIds = new HashSet<>(assignedTasks.stream()
				.map(Task::getProcessInstanceId)
				.toList());

        List<Long> roleIds = sysUserRoleService.getRoleIdsByUserId(userId);
        if (roleIds != null && !roleIds.isEmpty()) {
            SysUserVO userVO = sysUserService.getSysUserVo(userId);
            if (userVO != null && userVO.getRoles() != null && !userVO.getRoles().isEmpty()) {
                List<String> roleCodes = userVO.getRoles().stream()
                        .map(SysRoleVO::getCode)
                        .collect(Collectors.toList());

                List<Task> candidateTasks = flowableService.getTasksByCandidateGroups(roleCodes);
                processInstanceIds.addAll(candidateTasks.stream()
                        .map(Task::getProcessInstanceId)
                        .toList());
            }
        }

        if (processInstanceIds.isEmpty()) {
            return 0L;
        }

		return sealApplyService.count(
                new LambdaQueryWrapper<SealApply>()
                        .in(SealApply::getProcessInstanceId, processInstanceIds)
                        .eq(SealApply::getDeleted, 0));
    }

    /**
     * 获取任务详情
     *
     * @param taskId 任务ID
     * @return 任务详情VO
     */
    @Override
    public ApprovalTaskVO getTaskDetail(String taskId) {
        Task task = flowableService.getTaskById(taskId);
        Assert.notNull(task, "任务不存在");

        SealApply sealApply = sealApplyService.getOne(
                new LambdaQueryWrapper<SealApply>()
                        .eq(SealApply::getProcessInstanceId, task.getProcessInstanceId())
                        .eq(SealApply::getDeleted, 0));
        Assert.notNull(sealApply, "申请不存在");

        return convertToTaskVO(task, sealApply, 1, null);
    }

    /**
     * 审批任务（同意）
     *
     * @param taskId 任务ID
     * @param approveComment 审批意见
     * @param approverId 审批人ID
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void approveTask(String taskId, String approveComment, Long approverId) {
        sealApplyService.approveTask(taskId, 1, approveComment, approverId);
    }

    /**
     * 审批任务（拒绝）
     *
     * @param taskId 任务ID
     * @param rejectReason 拒绝原因
     * @param approverId 审批人ID
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void rejectTask(String taskId, String rejectReason, Long approverId) {
        sealApplyService.approveTask(taskId, 0, rejectReason, approverId);
    }

    /**
     * 获取任务的申请详情
     *
     * @param taskId 任务ID
     * @return 申请详情VO
     */
    @Override
    public SealApplyVO getApplyByTaskId(String taskId) {
        Task task = flowableService.getTaskById(taskId);
        Assert.notNull(task, "任务不存在");

        SealApply sealApply = sealApplyService.getOne(
                new LambdaQueryWrapper<SealApply>()
                        .eq(SealApply::getProcessInstanceId, task.getProcessInstanceId())
                        .eq(SealApply::getDeleted, 0));
        Assert.notNull(sealApply, "申请不存在");

        return sealApplyService.getSealApplyVo(sealApply.getId());
    }

    /**
     * 验证用户是否有权限处理该任务
     *
     * @param taskId 任务ID
     * @param userId 用户ID
     * @return 是否有权限
     */
    @Override
    public boolean hasPermission(String taskId, Long userId) {
        Task task = flowableService.getTaskById(taskId);
        if (task == null) {
            return false;
        }

        if (userId.toString().equals(task.getAssignee())) {
            return true;
        }

        List<Long> roleIds = sysUserRoleService.getRoleIdsByUserId(userId);
        if (roleIds != null && !roleIds.isEmpty()) {
            SysUserVO userVO = sysUserService.getSysUserVo(userId);
            if (userVO != null && userVO.getRoles() != null && !userVO.getRoles().isEmpty()) {
                List<String> roleCodes = userVO.getRoles().stream()
                        .map(SysRoleVO::getCode)
                        .collect(Collectors.toList());

                List<Task> candidateTasks = flowableService.getTasksByCandidateGroups(roleCodes);
                return candidateTasks.stream()
                        .anyMatch(t -> t.getId().equals(taskId));
            }
        }

        return false;
    }

    /**
     * 将Flowable任务转换为待办任务VO
     *
     * @param task Flowable任务对象
     * @param sealApply 印章申请实体
     * @param taskStatus 任务状态（1-待办，2-已办）
     * @param record 审批记录（已办任务时传入）
     * @return 任务VO
     */
    private ApprovalTaskVO convertToTaskVO(Task task, SealApply sealApply, Integer taskStatus, SealApplyRecord record) {
        if (task == null || sealApply == null) {
            return null;
        }

        ApprovalTaskVO vo = new ApprovalTaskVO();
        vo.setTaskId(task.getId());
        vo.setTaskName(task.getName());
        vo.setTaskDefinitionKey(task.getTaskDefinitionKey());
        vo.setProcessInstanceId(task.getProcessInstanceId());
        vo.setProcessDefinitionId(task.getProcessDefinitionId());
        vo.setTaskCreateTime(task.getCreateTime().toInstant()
                .atZone(ZoneId.systemDefault()).toLocalDateTime());
        vo.setTaskStatus(taskStatus);
        vo.setTaskStatusName(taskStatus == 1 ? "待办" : "已办");

        vo.setApplyId(sealApply.getId());
        vo.setApplyNo(sealApply.getApplyNo());
        vo.setApplicantId(sealApply.getApplicantId());
        vo.setApplicantName(sealApply.getApplicantName());
        vo.setApplicantNo(sealApply.getApplicantNo());
        vo.setSealId(sealApply.getSealId());
        vo.setSealName(sealApply.getSealName());
        vo.setSealCategory(sealApply.getSealCategory());
        vo.setSealCategoryName(SealCategory.getNameByCode(sealApply.getSealCategory()));
        vo.setSealType(sealApply.getSealType());
        vo.setSealTypeName(SealType.getNameByCode(sealApply.getSealType()));
        vo.setApplyReason(sealApply.getApplyReason());
        vo.setApplyTime(sealApply.getApplyTime());
        vo.setExpectedUseDate(sealApply.getExpectedUseDate());
        vo.setStatus(sealApply.getStatus());
        vo.setStatusName(ApplyStatus.getNameByCode(sealApply.getStatus()));
        vo.setCurrentNodeName(sealApply.getCurrentNodeName());
        vo.setCurrentNodeKey(sealApply.getCurrentNodeKey());
        vo.setCurrentApproverId(sealApply.getCurrentApproverId());
        vo.setCurrentApproverName(sealApply.getCurrentApproverName());

        String processDefinitionId = task.getProcessDefinitionId();
        if (StrUtil.isNotBlank(processDefinitionId)) {
            ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery()
                    .processDefinitionId(processDefinitionId)
                    .singleResult();
            if (processDefinition != null) {
                vo.setProcessName(processDefinition.getName());
                vo.setProcessDefinitionKey(processDefinition.getKey());
            }
        }

        return vo;
    }

    /**
     * 将审批记录转换为已办任务VO
     *
     * @param record 审批记录
     * @param sealApply 印章申请实体
     * @return 任务VO
     */
    private ApprovalTaskVO convertToDoneTaskVO(SealApplyRecord record, SealApply sealApply) {
        if (record == null || sealApply == null) {
            return null;
        }

        ApprovalTaskVO vo = new ApprovalTaskVO();
        vo.setTaskId(record.getTaskId());
        vo.setTaskName(record.getTaskName());
        vo.setTaskDefinitionKey(record.getTaskKey());
        vo.setProcessInstanceId(record.getProcessInstanceId());
        vo.setProcessDefinitionKey(sealApply.getProcessDefinitionKey());
        vo.setProcessName(sealApply.getProcessName());
        vo.setTaskCreateTime(record.getCreateTime());
        vo.setTaskEndTime(record.getApproveTime());
        vo.setTaskStatus(2);
        vo.setTaskStatusName("已办");

        vo.setApplyId(sealApply.getId());
        vo.setApplyNo(sealApply.getApplyNo());
        vo.setApplicantId(sealApply.getApplicantId());
        vo.setApplicantName(sealApply.getApplicantName());
        vo.setApplicantNo(sealApply.getApplicantNo());
        vo.setSealId(sealApply.getSealId());
        vo.setSealName(sealApply.getSealName());
        vo.setSealCategory(sealApply.getSealCategory());
        vo.setSealCategoryName(SealCategory.getNameByCode(sealApply.getSealCategory()));
        vo.setSealType(sealApply.getSealType());
        vo.setSealTypeName(SealType.getNameByCode(sealApply.getSealType()));
        vo.setApplyReason(sealApply.getApplyReason());
        vo.setApplyTime(sealApply.getApplyTime());
        vo.setExpectedUseDate(sealApply.getExpectedUseDate());
        vo.setStatus(sealApply.getStatus());
        vo.setStatusName(ApplyStatus.getNameByCode(sealApply.getStatus()));
        vo.setCurrentNodeName(sealApply.getCurrentNodeName());
        vo.setCurrentNodeKey(sealApply.getCurrentNodeKey());
        vo.setCurrentApproverId(sealApply.getCurrentApproverId());
        vo.setCurrentApproverName(sealApply.getCurrentApproverName());

        vo.setApproverId(record.getApproverId());
        vo.setApproverName(record.getApproverName());
        vo.setApproveResult(record.getApproveResult());
        vo.setApproveResultName(record.getApproveResult() == 1 ? "通过" : "拒绝");
        vo.setApproveComment(record.getApproveComment());
        vo.setApproveTime(record.getApproveTime());

        return vo;
    }

    /**
     * 匹配查询参数
     *
     * @param vo 任务VO
     * @param queryParams 查询参数
     * @return 是否匹配
     */
    private boolean matchQueryParams(ApprovalTaskVO vo, ApprovalTaskPageQuery queryParams) {
        if (StrUtil.isNotBlank(queryParams.getTaskName())
                && !vo.getTaskName().contains(queryParams.getTaskName())) {
            return false;
        }
        if (StrUtil.isNotBlank(queryParams.getProcessName())
                && !vo.getProcessName().contains(queryParams.getProcessName())) {
            return false;
        }
        if (queryParams.getApplicantId() != null
                && !queryParams.getApplicantId().equals(vo.getApplicantId())) {
            return false;
        }
        if (StrUtil.isNotBlank(queryParams.getApplicantName())
                && !vo.getApplicantName().contains(queryParams.getApplicantName())) {
            return false;
        }
        if (StrUtil.isNotBlank(queryParams.getApplyNo())
                && !vo.getApplyNo().contains(queryParams.getApplyNo())) {
            return false;
        }
        if (queryParams.getSealCategory() != null
                && !queryParams.getSealCategory().equals(vo.getSealCategory())) {
            return false;
        }
        if (queryParams.getStatus() != null
                && !queryParams.getStatus().equals(vo.getStatus())) {
            return false;
        }
        if (StrUtil.isNotBlank(queryParams.getTaskDefinitionKey())
                && !queryParams.getTaskDefinitionKey().equals(vo.getTaskDefinitionKey())) {
            return false;
        }
        if (StrUtil.isNotBlank(queryParams.getStartTime())) {
            LocalDateTime startTime = LocalDateTime.parse(queryParams.getStartTime(),
                    DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
            if (vo.getTaskCreateTime().isBefore(startTime)) {
                return false;
            }
        }
        if (StrUtil.isNotBlank(queryParams.getEndTime())) {
            LocalDateTime endTime = LocalDateTime.parse(queryParams.getEndTime(),
                    DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
            if (vo.getTaskCreateTime().isAfter(endTime)) {
                return false;
            }
        }
        return true;
    }
}
