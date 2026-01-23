package com.sealflow.service.Impl;

import cn.hutool.core.lang.Assert;
import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.sealflow.common.context.UserContextHolder;
import com.sealflow.converter.PartyApplyConverter;
import com.sealflow.mapper.PartyApplyMapper;
import com.sealflow.model.entity.PartyApply;
import com.sealflow.model.entity.PartyApprovalRecord;
import com.sealflow.model.form.PartyApplyForm;
import com.sealflow.model.query.PartyApplyPageQuery;
import com.sealflow.model.vo.PartyApplyVO;
import com.sealflow.model.vo.PartyApprovalRecordVO;
import com.sealflow.model.vo.SysUserVO;
import com.sealflow.service.IPartyApprovalRecordService;
import com.sealflow.service.IPartyApplyService;
import com.sealflow.service.ISysUserRoleService;

import lombok.RequiredArgsConstructor;
import org.flowable.engine.HistoryService;
import org.flowable.engine.RepositoryService;
import org.flowable.engine.RuntimeService;
import org.flowable.engine.TaskService;
import org.flowable.engine.repository.ProcessDefinition;
import org.flowable.engine.runtime.ProcessInstance;
import org.flowable.task.api.Task;
import org.flowable.task.api.history.HistoricTaskInstance;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 党章申请服务实现类
 * 
 * 主要功能：
 * 1. 党章申请的增删改查
 * 2. 工作流流程启动和管理
 * 3. 审批任务处理
 * 4. 待办任务查询（支持角色候选组）
 * 5. 已办任务查询
 */
@Service
@RequiredArgsConstructor
public class PartyApplyServiceImpl extends ServiceImpl<PartyApplyMapper, PartyApply> implements IPartyApplyService {

    private final PartyApplyConverter converter;
    private final IPartyApprovalRecordService approvalRecordService;
    private final RuntimeService runtimeService;
    private final TaskService taskService;
    private final HistoryService historyService;
    private final RepositoryService repositoryService;
    private final com.sealflow.service.ISysUserService sysUserService;
    private final ISysUserRoleService sysUserRoleService;

    /**
     * 保存党章申请
     * 
     * 功能说明：
     * 1. 生成申请编号
     * 2. 设置申请状态为待审批（0）
     * 3. 设置申请人为当前登录用户
     * 4. 保存申请记录
     * 5. 自动启动工作流流程
     * 
     * @param formData 申请表单数据
     * @return 申请ID
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Long savePartyApply(PartyApplyForm formData) {
        PartyApply entity = converter.formToEntity(formData);
        entity.setApplyNo("PA" + IdUtil.getSnowflakeNextIdStr());
        entity.setStatus(0);
        entity.setApplyTime(LocalDateTime.now());

        Long currentUserId = UserContextHolder.getCurrentUserId();
        if (currentUserId != null) {
            SysUserVO userVO = sysUserService.getSysUserVo(currentUserId);
            if (userVO != null) {
                entity.setApplicantId(currentUserId);
                entity.setApplicantName(userVO.getRealName());
                entity.setApplicantNo(userVO.getUsername());
            }
        }

        Assert.isTrue(this.save(entity), "添加失败");

        startProcess(entity.getId());

        return entity.getId();
    }

    /**
     * 更新党章申请
     * 
     * 功能说明：
     * 只有状态为待审批（0）的申请才能修改
     * 
     * @param id 申请ID
     * @param formData 申请表单数据
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updatePartyApply(Long id, PartyApplyForm formData) {
        PartyApply existing = getEntity(id);
        Assert.isTrue(existing.getStatus() == 0, "只有待审批的申请才能修改");
        PartyApply entity = converter.formToEntity(formData);
        entity.setId(id);
        Assert.isTrue(this.updateById(entity), "修改失败");
    }

    /**
     * 删除党章申请
     * 
     * 功能说明：
     * 支持批量删除，采用逻辑删除方式
     * 
     * @param idStr 申请ID字符串，多个ID以逗号分隔
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deletePartyApply(String idStr) {
        Assert.isFalse(StrUtil.isEmpty(idStr), "id不能为空");
        List<Long> ids = Arrays.stream(idStr.split(","))
                .map(Long::parseLong)
                .collect(Collectors.toList());
        LambdaUpdateWrapper<PartyApply> wrapper = new LambdaUpdateWrapper<>();
        wrapper.set(PartyApply::getDeleted, 1)
                .in(PartyApply::getId, ids);
        Assert.isTrue(this.update(wrapper), "删除失败");
    }

    /**
     * 获取党章申请详情
     * 
     * @param id 申请ID
     * @return 申请详情VO
     */
    @Override
    public PartyApplyVO getPartyApplyVo(Long id) {
        PartyApply entity = getEntity(id);
        PartyApplyVO vo = converter.entityToVo(entity);
        enrichPartyApplyVO(vo);
        return vo;
    }

    /**
     * 分页查询党章申请列表
     * 
     * @param queryParams 查询条件
     * @return 分页结果
     */
    @Override
    public IPage<PartyApplyVO> pagePartyApply(PartyApplyPageQuery queryParams) {
        Page<PartyApply> page = new Page<>(queryParams.getPageNum(), queryParams.getPageSize());
        Page<PartyApply> partyApplyPage = this.baseMapper.selectPage(page, getQueryWrapper(queryParams));
        IPage<PartyApplyVO> resultPage = converter.entityToVOForPage(partyApplyPage);
        resultPage.getRecords().forEach(this::enrichPartyApplyVO);
        return resultPage;
    }

    /**
     * 列表查询党章申请
     * 
     * @param queryParams 查询条件
     * @return 申请列表
     */
    @Override
    public List<PartyApplyVO> listPartyApply(PartyApplyPageQuery queryParams) {
        List<PartyApplyVO> list = converter.entityToVo(this.list(getQueryWrapper(queryParams)));
        list.forEach(this::enrichPartyApplyVO);
        return list;
    }

    /**
     * 启动工作流流程
     * 
     * 功能说明：
     * 1. 验证申请状态，只有待审批（0）的申请才能启动流程
     * 2. 设置流程变量（申请人ID、申请人姓名、申请ID）
     * 3. 启动流程实例
     * 4. 更新申请状态为审批中（1）
     * 5. 更新当前任务信息
     * 
     * @param applyId 申请ID
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void startProcess(Long applyId) {
        PartyApply partyApply = getEntity(applyId);
        Assert.isTrue(partyApply.getStatus() == 0, "只有待审批的申请才能发起流程");

        Map<String, Object> variables = new HashMap<>();
        variables.put("applicantId", partyApply.getApplicantId());
        variables.put("applicantName", partyApply.getApplicantName());
        variables.put("applyId", applyId);

        ProcessInstance processInstance = runtimeService.startProcessInstanceByKey("partyApplyProcess", partyApply.getApplyNo(), variables);

        partyApply.setProcessInstanceId(processInstance.getId());
        partyApply.setProcessDefinitionKey(processInstance.getProcessDefinitionKey());
        partyApply.setStatus(1);

        ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery()
                .processDefinitionId(processInstance.getProcessDefinitionId())
                .singleResult();
        if (processDefinition != null) {
            partyApply.setProcessName(processDefinition.getName());
        }

        updateCurrentTaskInfo(partyApply);
        Assert.isTrue(this.updateById(partyApply), "更新申请状态失败");
    }

    /**
     * 审批任务
     * 
     * 功能说明：
     * 1. 验证任务是否存在
     * 2. 验证申请是否存在
     * 3. 判断审批阶段和审批角色
     * 4. 设置流程变量（审批结果、拒绝原因）
     * 5. 保存审批记录
     * 6. 完成任务
     * 7. 更新申请状态：
     *    - 流程结束：设置为已通过（2）或已拒绝（3）
     *    - 流程继续：更新当前任务信息
     * 
     * @param taskId 任务ID
     * @param approveResult 审批结果（1-通过，2-拒绝）
     * @param approveComment 审批意见
     * @param approverId 审批人ID
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void approveTask(String taskId, Integer approveResult, String approveComment, Long approverId) {
        Task task = taskService.createTaskQuery().taskId(taskId).singleResult();
        Assert.notNull(task, "任务不存在");

        PartyApply partyApply = this.getOne(new LambdaQueryWrapper<PartyApply>()
                .eq(PartyApply::getProcessInstanceId, task.getProcessInstanceId()));
        Assert.notNull(partyApply, "申请不存在");

        String taskKey = task.getTaskDefinitionKey();
        Integer approvalStage = getApprovalStage(taskKey);
        String approverRoleCode = getApproverRoleCode(taskKey);

        Map<String, Object> variables = new HashMap<>();
        variables.put("approved", approveResult == 1);
        variables.put("rejectReason", approveComment);

        HistoricTaskInstance historicTask = historyService.createHistoricTaskInstanceQuery()
                .taskId(taskId)
                .singleResult();
        LocalDateTime taskStartTime = historicTask != null ?
                historicTask.getCreateTime().toInstant().atZone(java.time.ZoneId.systemDefault()).toLocalDateTime() : LocalDateTime.now();

        approvalRecordService.saveApprovalRecord(
                partyApply.getId(),
                partyApply.getProcessInstanceId(),
                taskId,
                task.getName(),
                taskKey,
                approvalStage,
                approverId,
                getApproverName(approverId),
                approverRoleCode,
                getApproverRoleName(approverRoleCode),
                approveResult,
                approveComment
        );

        taskService.complete(taskId, variables);

        ProcessInstance processInstance = runtimeService.createProcessInstanceQuery()
                .processInstanceId(partyApply.getProcessInstanceId())
                .singleResult();

        if (processInstance == null) {
            partyApply.setStatus(approveResult == 1 ? 2 : 3);
            partyApply.setFinishTime(LocalDateTime.now());
            if (approveResult == 2) {
                partyApply.setRejectReason(approveComment);
            }
            partyApply.setCurrentNodeName(null);
            partyApply.setCurrentNodeKey(null);
        } else {
            updateCurrentTaskInfo(partyApply);
        }

        Assert.isTrue(this.updateById(partyApply), "更新申请状态失败");
    }

    /**
     * 撤销流程
     * 
     * 功能说明：
     * 1. 验证只有申请人才能撤销
     * 2. 验证只有审批中（1）的申请才能撤销
     * 3. 删除流程实例
     * 4. 更新申请状态为已撤销（4）
     * 
     * @param applyId 申请ID
     * @param userId 用户ID
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void revokeProcess(Long applyId, Long userId) {
        PartyApply partyApply = getEntity(applyId);
        Assert.isTrue(partyApply.getApplicantId().equals(userId), "只有申请人才能撤销");
        Assert.isTrue(partyApply.getStatus() == 1, "只有审批中的申请才能撤销");

        runtimeService.deleteProcessInstance(partyApply.getProcessInstanceId(), "申请人撤销");

        partyApply.setStatus(4);
        partyApply.setCurrentNodeName(null);
        partyApply.setCurrentNodeKey(null);
        Assert.isTrue(this.updateById(partyApply), "撤销失败");
    }

    /**
     * 分页查询我发起的申请
     * 
     * 功能说明：
     * 查询当前用户作为申请人的所有申请
     * 
     * @param queryParams 查询条件
     * @param userId 用户ID
     * @return 分页结果
     */
    @Override
    public IPage<PartyApplyVO> pageMyStarted(PartyApplyPageQuery queryParams, Long userId) {
        queryParams.setApplicantId(userId);
        return pagePartyApply(queryParams);
    }

    /**
     * 分页查询我已审批的申请
     * 
     * 功能说明：
     * 1. 查询当前用户的所有审批记录
     * 2. 提取已审批的申请ID
     * 3. 根据申请ID查询申请详情
     * 4. 不限制申请状态，无论申请处于什么状态，只要审批过就能看到
     * 
     * @param queryParams 查询条件
     * @param userId 用户ID
     * @return 分页结果
     */
    @Override
    public IPage<PartyApplyVO> pageMyApproved(PartyApplyPageQuery queryParams, Long userId) {
        List<PartyApprovalRecord> approvalRecords = approvalRecordService.list(
                new LambdaQueryWrapper<PartyApprovalRecord>()
                        .eq(PartyApprovalRecord::getApproverId, userId)
        );

        if (approvalRecords.isEmpty()) {
            return new Page<>(queryParams.getPageNum(), queryParams.getPageSize());
        }

        Set<Long> approvedApplyIds = approvalRecords.stream()
                .map(PartyApprovalRecord::getApplyId)
                .collect(Collectors.toSet());

        Page<PartyApply> page = new Page<>(queryParams.getPageNum(), queryParams.getPageSize());
        LambdaQueryWrapper<PartyApply> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(PartyApply::getDeleted, 0);
        wrapper.in(PartyApply::getId, approvedApplyIds);
        wrapper.orderByDesc(PartyApply::getApplyTime);

        Page<PartyApply> partyApplyPage = this.baseMapper.selectPage(page, wrapper);
        IPage<PartyApplyVO> resultPage = converter.entityToVOForPage(partyApplyPage);
        resultPage.getRecords().forEach(this::enrichPartyApplyVO);
        return resultPage;
    }

    /**
     * 分页查询我的待办任务
     * 
     * 功能说明：
     * 1. 查询直接分配给当前用户的任务
     * 2. 查询用户所属角色
     * 3. 查询角色候选组任务
     * 4. 合并两种任务的流程实例ID
     * 5. 根据流程实例ID查询申请详情
     * 
     * @param queryParams 查询条件
     * @param userId 用户ID
     * @return 分页结果
     */
    @Override
    public IPage<PartyApplyVO> pageTodoTasks(PartyApplyPageQuery queryParams, Long userId) {
        Long currentUserId = userId != null ? userId : UserContextHolder.getCurrentUserId();

        Set<String> processInstanceIds = new HashSet<>();

        List<Task> assignedTasks = taskService.createTaskQuery()
                .taskAssignee(currentUserId.toString())
                .list();
        processInstanceIds.addAll(assignedTasks.stream()
                .map(Task::getProcessInstanceId)
                .collect(Collectors.toList()));

        List<Long> roleIds = sysUserRoleService.getRoleIdsByUserId(currentUserId);
        if (roleIds != null && !roleIds.isEmpty()) {
            List<com.sealflow.model.vo.SysRoleVO> roles = sysUserService.getSysUserVo(currentUserId).getRoles();
            if (roles != null && !roles.isEmpty()) {
                List<String> roleCodes = roles.stream()
                        .map(com.sealflow.model.vo.SysRoleVO::getCode)
                        .collect(Collectors.toList());
                
                List<Task> candidateTasks = taskService.createTaskQuery()
                        .taskCandidateGroupIn(roleCodes)
                        .list();
                processInstanceIds.addAll(candidateTasks.stream()
                        .map(Task::getProcessInstanceId)
                        .collect(Collectors.toList()));
            }
        }

        if (processInstanceIds.isEmpty()) {
            return new Page<>(queryParams.getPageNum(), queryParams.getPageSize());
        }

        Page<PartyApply> page = new Page<>(queryParams.getPageNum(), queryParams.getPageSize());
        LambdaQueryWrapper<PartyApply> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(PartyApply::getDeleted, 0);
        wrapper.in(PartyApply::getProcessInstanceId, processInstanceIds);
        wrapper.orderByDesc(PartyApply::getApplyTime);

        Page<PartyApply> partyApplyPage = this.baseMapper.selectPage(page, wrapper);
        IPage<PartyApplyVO> resultPage = converter.entityToVOForPage(partyApplyPage);
        resultPage.getRecords().forEach(this::enrichPartyApplyVO);
        return resultPage;
    }

    /**
     * 获取流程详情
     * 
     * @param processInstanceId 流程实例ID
     * @return 申请详情VO
     */
    @Override
    public PartyApplyVO getProcessDetail(String processInstanceId) {
        PartyApply partyApply = this.getOne(new LambdaQueryWrapper<PartyApply>()
                .eq(PartyApply::getProcessInstanceId, processInstanceId));
        Assert.notNull(partyApply, "申请不存在");
        PartyApplyVO vo = converter.entityToVo(partyApply);
        enrichPartyApplyVO(vo);
        return vo;
    }

    /**
     * 更新当前任务信息
     * 
     * 功能说明：
     * 查询流程的当前任务，更新申请的当前节点名称和节点Key
     * 
     * @param partyApply 申请实体
     */
    private void updateCurrentTaskInfo(PartyApply partyApply) {
        Task currentTask = taskService.createTaskQuery()
                .processInstanceId(partyApply.getProcessInstanceId())
                .singleResult();
        if (currentTask != null) {
            partyApply.setCurrentNodeName(currentTask.getName());
            partyApply.setCurrentNodeKey(currentTask.getTaskDefinitionKey());
        }
    }

    /**
     * 丰富申请VO信息
     * 
     * 功能说明：
     * 1. 设置申请类型名称
     * 2. 设置紧急程度名称
     * 3. 设置状态名称
     * 4. 设置审批记录列表
     * 5. 设置当前任务ID
     * 
     * @param vo 申请VO对象
     */
    private void enrichPartyApplyVO(PartyApplyVO vo) {
        vo.setApplyTypeName(getApplyTypeName(vo.getApplyType()));
        vo.setUrgencyLevelName(getUrgencyLevelName(vo.getUrgencyLevel()));
        vo.setStatusName(getStatusName(vo.getStatus()));

        List<PartyApprovalRecordVO> approvalRecords = approvalRecordService.getApprovalRecordsByApplyId(vo.getId());
        vo.setApprovalRecords(approvalRecords);

        if (vo.getProcessInstanceId() != null) {
            Task currentTask = taskService.createTaskQuery()
                    .processInstanceId(vo.getProcessInstanceId())
                    .singleResult();
            if (currentTask != null) {
                vo.setCurrentTaskId(currentTask.getId());
            }
        }
    }

    /**
     * 构建查询条件
     * 
     * @param queryParams 查询参数
     * @return 查询包装器
     */
    private LambdaQueryWrapper<PartyApply> getQueryWrapper(PartyApplyPageQuery queryParams) {
        LambdaQueryWrapper<PartyApply> qw = new LambdaQueryWrapper<>();
        qw.eq(PartyApply::getDeleted, 0);
        qw.like(StrUtil.isNotBlank(queryParams.getApplyNo()), PartyApply::getApplyNo, queryParams.getApplyNo());
        qw.eq(queryParams.getApplicantId() != null, PartyApply::getApplicantId, queryParams.getApplicantId());
        qw.like(StrUtil.isNotBlank(queryParams.getApplicantName()), PartyApply::getApplicantName, queryParams.getApplicantName());
        qw.like(StrUtil.isNotBlank(queryParams.getApplicantNo()), PartyApply::getApplicantNo, queryParams.getApplicantNo());
        qw.like(StrUtil.isNotBlank(queryParams.getTitle()), PartyApply::getTitle, queryParams.getTitle());
        qw.eq(queryParams.getApplyType() != null, PartyApply::getApplyType, queryParams.getApplyType());
        qw.eq(queryParams.getUrgencyLevel() != null, PartyApply::getUrgencyLevel, queryParams.getUrgencyLevel());
        qw.eq(queryParams.getStatus() != null, PartyApply::getStatus, queryParams.getStatus());
        qw.orderByDesc(PartyApply::getApplyTime);
        return qw;
    }

    /**
     * 获取实体
     * 
     * @param id 主键ID
     * @return 实体对象
     */
    private PartyApply getEntity(Long id) {
        PartyApply entity = this.getOne(new LambdaQueryWrapper<PartyApply>()
                .eq(PartyApply::getId, id)
                .eq(PartyApply::getDeleted, 0)
        );
        Assert.isTrue(null != entity, "数据不存在");
        return entity;
    }

    /**
     * 根据任务Key获取审批阶段
     * 
     * @param taskKey 任务定义Key
     * @return 审批阶段（1-班主任，2-辅导员，3-院长，4-书记）
     */
    private Integer getApprovalStage(String taskKey) {
        switch (taskKey) {
            case "headTeacherApproval":
                return 1;
            case "counselorApproval":
                return 2;
            case "deanApproval":
                return 3;
            case "partySecretaryApproval":
                return 4;
            default:
                return 0;
        }
    }

    /**
     * 根据任务Key获取审批角色编码
     * 
     * @param taskKey 任务定义Key
     * @return 角色编码
     */
    private String getApproverRoleCode(String taskKey) {
        switch (taskKey) {
            case "headTeacherApproval":
                return "CLASSGUIDE";
            case "counselorApproval":
                return "MENTOR";
            case "deanApproval":
                return "DEAN";
            case "partySecretaryApproval":
                return "PARTYSECRETARY";
            default:
                return "";
        }
    }

    /**
     * 根据角色编码获取角色名称
     * 
     * @param roleCode 角色编码
     * @return 角色名称
     */
    private String getApproverRoleName(String roleCode) {
		return switch (roleCode) {
			case "CLASSGUIDE" -> "班主任";
			case "MENTOR" -> "辅导员";
			case "DEAN" -> "学院院长";
			case "PARTYSECRETARY" -> "党委书记";
			default -> "";
		};
    }

    /**
     * 获取审批人姓名
     * 
     * @param approverId 审批人ID
     * @return 审批人姓名
     */
    private String getApproverName(Long approverId) {
        if (approverId == null) {
            return "";
        }
        try {
            com.sealflow.model.vo.SysUserVO userVO = sysUserService.getSysUserVo(approverId);
            return userVO != null ? userVO.getRealName() : "审批人" + approverId;
        } catch (Exception e) {
            return "审批人" + approverId;
        }
    }

    /**
     * 根据申请类型获取类型名称
     * 
     * @param applyType 申请类型
     * @return 类型名称
     */
    private String getApplyTypeName(Integer applyType) {
        if (applyType == null) return "";
		return switch (applyType) {
			case 1 -> "入党申请";
			case 2 -> "转正申请";
			case 3 -> "其他";
			default -> "";
		};
    }

    /**
     * 根据紧急程度获取程度名称
     * 
     * @param urgencyLevel 紧急程度
     * @return 程度名称
     */
    private String getUrgencyLevelName(Integer urgencyLevel) {
        if (urgencyLevel == null) return "";
		return switch (urgencyLevel) {
			case 1 -> "普通";
			case 2 -> "紧急";
			case 3 -> "特急";
			default -> "";
		};
    }

    /**
     * 根据状态获取状态名称
     * 
     * @param status 状态值
     * @return 状态名称
     */
    private String getStatusName(Integer status) {
        if (status == null) return "";
		return switch (status) {
			case 0 -> "待审批";
			case 1 -> "审批中";
			case 2 -> "已通过";
			case 3 -> "已拒绝";
			case 4 -> "已撤销";
			default -> "";
		};
    }
}
