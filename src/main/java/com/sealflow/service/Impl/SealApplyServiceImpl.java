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
import com.sealflow.converter.SealApplyConverter;
import com.sealflow.mapper.SealApplyMapper;
import com.sealflow.model.entity.SealApply;
import com.sealflow.model.entity.SealInfo;
import com.sealflow.model.entity.WorkflowTemplate;
import com.sealflow.model.form.SealApplyForm;
import com.sealflow.model.query.SealApplyPageQuery;
import com.sealflow.model.vo.SealApplyRecordVO;
import com.sealflow.model.vo.SealApplyVO;
import com.sealflow.model.vo.SysUserVO;
import com.sealflow.model.vo.WorkflowNodeVO;
import com.sealflow.service.*;
import lombok.RequiredArgsConstructor;
import org.flowable.bpmn.model.BpmnModel;
import org.flowable.bpmn.model.FlowElement;
import org.flowable.bpmn.model.UserTask;
import org.flowable.engine.HistoryService;
import org.flowable.engine.RepositoryService;
import org.flowable.task.api.history.HistoricTaskInstance;
import org.flowable.task.api.Task;
import org.flowable.engine.runtime.ProcessInstance;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class SealApplyServiceImpl extends ServiceImpl<SealApplyMapper, SealApply> implements ISealApplyService {

    /**
     * 实体与表单/VO之间的转换器
     */
    private final SealApplyConverter converter;

    /**
     * 印章申请审批记录服务
     * 用于保存审批过程中的审批记录
     */
    private final ISealApplyRecordService approvalRecordService;

    /**
     * Flowable工作流服务
     * 用于启动流程、处理任务、撤销流程等Flowable相关操作
     */
    private final IFlowableService flowableService;

    /**
     * Flowable历史服务
     * 用于查询已完成的任务、历史流程实例等
     */
    private final HistoryService historyService;

    /**
     * Flowable流程定义存储服务
     * 用于查询流程定义、获取BPMN模型等
     */
    private final RepositoryService repositoryService;

    /**
     * 系统用户服务
     * 用于获取用户信息
     */
    private final ISysUserService sysUserService;

    /**
     * 系统用户角色服务
     * 用于获取用户的角色信息
     */
    private final ISysUserRoleService sysUserRoleService;

    /**
     * 印章信息管理服务
     * 用于获取印章相关信息
     */
    private final ISealInfoService sealInfoService;

    /**
     * 工作流模板服务
     * 用于根据条件匹配工作流模板
     */
    private final com.sealflow.service.IWorkflowTemplateService workflowTemplateService;

    /**
     * 保存印章申请并启动审批流程
     *
     * 保存印章申请信息后，自动根据印章类型匹配工作流模板并启动审批流程。
     *
     * 处理流程：
     * 1. 将表单数据转换为实体
     * 2. 生成申请编号、设置初始状态
     * 3. 设置申请人信息
     * 4. 保存申请信息
     * 5. 调用startProcess()启动审批流程
     *
     * @param formData 申请表单数据
     * @return 新创建的申请ID
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Long saveSealApply(SealApplyForm formData) {
        SealApply entity = converter.formToEntity(formData);
        entity.setApplyNo("SA" + IdUtil.getSnowflakeNextIdStr());
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

        if (formData.getSealId() != null) {
            SealInfo sealInfo = sealInfoService.getById(formData.getSealId());
            if (sealInfo != null) {
                entity.setSealName(sealInfo.getName());
                entity.setSealCategory(sealInfo.getCategory());
                entity.setSealType(sealInfo.getSealType());
            }
        }

        entity.setTemplateId(formData.getTemplateId());

        Assert.isTrue(this.save(entity), "添加失败");

        startProcess(entity.getId());

        return entity.getId();
    }

    /**
     * 更新印章申请
     *
     * 只有待审批的申请才能修改，审批中或已完成的申请不能修改。
     *
     * @param id 申请ID
     * @param formData 更新后的申请数据
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updateSealApply(Long id, SealApplyForm formData) {
        SealApply existing = getEntity(id);
        Assert.isTrue(existing.getStatus() == 0, "只有待审批的申请才能修改");
        SealApply entity = converter.formToEntity(formData);
        entity.setId(id);

        if (formData.getSealId() != null) {
            SealInfo sealInfo = sealInfoService.getById(formData.getSealId());
            if (sealInfo != null) {
                entity.setSealName(sealInfo.getName());
                entity.setSealCategory(sealInfo.getCategory());
                entity.setSealType(sealInfo.getSealType());
            }
        }

        if (StrUtil.isNotBlank(formData.getApplyDate())) {
            entity.setApplyDate(LocalDate.parse(formData.getApplyDate(), DateTimeFormatter.ofPattern("yyyy-MM-dd")));
        }
        if (StrUtil.isNotBlank(formData.getExpectedUseDate())) {
            entity.setExpectedUseDate(LocalDateTime.parse(formData.getExpectedUseDate(),
                    DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
        }

        Assert.isTrue(this.updateById(entity), "修改失败");
    }

    /**
     * 删除印章申请
     *
     * 批量删除申请，标记为删除状态而非物理删除。
     *
     * @param idStr 申请ID字符串，多个用逗号分隔
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deleteSealApply(String idStr) {
        Assert.isFalse(StrUtil.isEmpty(idStr), "id不能为空");
        List<Long> ids = Arrays.stream(idStr.split(","))
                .map(Long::parseLong)
                .collect(Collectors.toList());
        LambdaUpdateWrapper<SealApply> wrapper = new LambdaUpdateWrapper<>();
        wrapper.set(SealApply::getDeleted, 1)
                .in(SealApply::getId, ids);
        Assert.isTrue(this.update(wrapper), "删除失败");
    }

    /**
     * 获取印章申请详情
     *
     * @param id 申请ID
     * @return 申请详情VO
     */
    @Override
    public SealApplyVO getSealApplyVo(Long id) {
        SealApply entity = getEntity(id);
        SealApplyVO vo = converter.entityToVo(entity);
        enrichSealApplyVO(vo);
        return vo;
    }

    /**
     * 分页查询印章申请
     *
     * @param queryParams 查询参数
     * @return 分页结果
     */
    @Override
    public IPage<SealApplyVO> pageSealApply(SealApplyPageQuery queryParams) {
        Page<SealApply> page = new Page<>(queryParams.getPageNum(), queryParams.getPageSize());
        Page<SealApply> sealApplyPage = this.baseMapper.selectPage(page, getQueryWrapper(queryParams));
        IPage<SealApplyVO> resultPage = converter.entityToVOForPage(sealApplyPage);
        resultPage.getRecords().forEach(this::enrichSealApplyVO);
        return resultPage;
    }

    /**
     * 查询印章申请列表
     *
     * @param queryParams 查询参数
     * @return 申请列表
     */
    @Override
    public List<SealApplyVO> listSealApply(SealApplyPageQuery queryParams) {
        List<SealApplyVO> list = converter.entityToVo(this.list(getQueryWrapper(queryParams)));
        list.forEach(this::enrichSealApplyVO);
        return list;
    }

    /**
     * 启动审批流程
     *
     * 根据申请信息匹配工作流模板，并将模板部署到Flowable引擎后启动流程实例。
     *
     * 处理流程：
     * 1. 验证申请状态为待审批
     * 2. 根据印章类型和申请人匹配工作流模板
     * 3. 验证模板已部署
     * 4. 验证用户是否有权限发起该工作流
     * 5. 构建流程变量（包含申请人信息、申请ID等）
     * 6. 调用IFlowableService启动流程实例
     * 7. 更新申请的流程实例ID和状态
     *
     * @param applyId 申请ID
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void startProcess(Long applyId) {
        SealApply sealApply = getEntity(applyId);
        Assert.isTrue(sealApply.getStatus() == 0, "只有待审批的申请才能发起流程");

        WorkflowTemplate template;
        if (sealApply.getTemplateId() != null) {
            template = workflowTemplateService.getById(sealApply.getTemplateId());
        } else {
            template = workflowTemplateService.findMatchedTemplate(sealApply.getApplicantId());
        }

        Assert.notNull(template, "未找到匹配的工作流模板，请联系管理员配置");
        Assert.isTrue(template.getDeployed() == 1, "工作流模板未部署，请联系管理员");

        Assert.isTrue(workflowTemplateService.hasInitiatePermission(template.getId(), sealApply.getApplicantId()),
                "您没有权限发起该工作流，请联系管理员");

        Assert.isTrue(!workflowTemplateService.isTemplateSuspended(template.getId()),
                "该工作流模板已挂起，暂时无法发起");

        Map<String, Object> variables = new HashMap<>();
        variables.put("applicantId", sealApply.getApplicantId());
        variables.put("applicantName", sealApply.getApplicantName());
        variables.put("applyId", applyId);
        variables.put("sealCategory", sealApply.getSealCategory());
        variables.put("sealType", sealApply.getSealType());

        ProcessInstance processInstance = flowableService.startProcessInstanceByKey(
                template.getProcessKey(), sealApply.getApplyNo(), variables);

        sealApply.setProcessInstanceId(processInstance.getId());
        sealApply.setProcessDefinitionKey(processInstance.getProcessDefinitionKey());
        sealApply.setStatus(1);

        String processDefinitionId = processInstance.getProcessDefinitionId();
        if (StrUtil.isNotBlank(processDefinitionId)) {
            String processName = flowableService.getProcessDefinitionName(processDefinitionId);
            if (StrUtil.isNotBlank(processName)) {
                sealApply.setProcessName(processName);
            }
        }

        updateCurrentTaskInfo(sealApply);
        Assert.isTrue(this.updateById(sealApply), "更新申请状态失败");
    }

    /**
     * 审批任务
     *
     * 处理待办任务，记录审批结果，并推进流程。
     *
     * 处理流程：
     * 1. 验证任务存在
     * 2. 验证申请存在
     * 3. 保存审批记录
     * 4. 调用IFlowableService完成任务
     * 5. 检查流程是否结束，更新申请状态
     *
     * @param taskId 任务ID
     * @param approveResult 审批结果（1-通过，0-拒绝）
     * @param approveComment 审批意见
     * @param approverId 审批人ID
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void approveTask(String taskId, Integer approveResult, String approveComment, Long approverId) {
        Task task = flowableService.getTaskById(taskId);
        Assert.notNull(task, "任务不存在");

        SealApply sealApply = this.getOne(new LambdaQueryWrapper<SealApply>()
                .eq(SealApply::getProcessInstanceId, task.getProcessInstanceId()));
        Assert.notNull(sealApply, "申请不存在");

        String taskKey = task.getTaskDefinitionKey();
        Integer approvalStage = getApprovalStage(taskKey);
        String approverRoleCode = getApproverRoleCode(taskKey);

        Map<String, Object> variables = new HashMap<>();
        variables.put("approved", approveResult == 1);
        variables.put("rejectReason", approveComment);

        HistoricTaskInstance historicTask = historyService.createHistoricTaskInstanceQuery()
                .taskId(taskId)
                .singleResult();
        LocalDateTime taskStartTime = historicTask != null
                ? historicTask.getCreateTime().toInstant().atZone(java.time.ZoneId.systemDefault()).toLocalDateTime()
                : LocalDateTime.now();

        approvalRecordService.saveApprovalRecord(
                sealApply.getId(),
                sealApply.getProcessInstanceId(),
                taskId,
                task.getName(),
                taskKey,
                approvalStage,
                approverId,
                getApproverName(approverId),
                approverRoleCode,
                getApproverRoleName(approverRoleCode),
                approveResult,
                approveComment);

        flowableService.completeTask(taskId, variables);

        String processInstanceId = sealApply.getProcessInstanceId();
        ProcessInstance processInstance = flowableService.getRuntimeProcessInstance(processInstanceId);

        if (processInstance == null) {
            sealApply.setStatus(approveResult == 1 ? 2 : 3);
            sealApply.setFinishTime(LocalDateTime.now());
            if (approveResult != 1) {
                sealApply.setRejectReason(approveComment);
            }
            sealApply.setCurrentNodeName(null);
            sealApply.setCurrentNodeKey(null);
            sealApply.setCurrentApproverId(null);
            sealApply.setCurrentApproverName(null);
        } else {
            updateCurrentTaskInfo(sealApply);
        }

        Assert.isTrue(this.updateById(sealApply), "更新申请状态失败");
    }

    /**
     * 撤销审批流程
     *
     * 申请人可以撤销自己发起的、尚在审批中的申请。
     *
     * @param applyId 申请ID
     * @param userId 用户ID（用于验证是否为申请人）
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void revokeProcess(Long applyId, Long userId) {
        SealApply sealApply = getEntity(applyId);
        Assert.isTrue(sealApply.getApplicantId().equals(userId), "只有申请人才能撤销");
        Assert.isTrue(sealApply.getStatus() == 1, "只有审批中的申请才能撤销");

        flowableService.deleteProcessInstance(sealApply.getProcessInstanceId(), "申请人撤销");

        sealApply.setStatus(4);
        sealApply.setCurrentNodeName(null);
        sealApply.setCurrentNodeKey(null);
        sealApply.setCurrentApproverId(null);
        sealApply.setCurrentApproverName(null);
        sealApply.setFinishTime(LocalDateTime.now());
        Assert.isTrue(this.updateById(sealApply), "撤销失败");
    }

    /**
     * 分页查询我发起的申请
     *
     * @param queryParams 查询参数
     * @param userId 用户ID
     * @return 分页结果
     */
    @Override
    public IPage<SealApplyVO> pageMyStarted(SealApplyPageQuery queryParams, Long userId) {
        queryParams.setApplicantId(userId);
        return pageSealApply(queryParams);
    }

    /**
     * 获取流程详情
     *
     * 获取申请对应的流程详情，包括流程节点信息和各节点的审批状态。
     *
     * @param processInstanceId 流程实例ID
     * @return 包含流程节点信息的申请VO
     */
    @Override
    public SealApplyVO getProcessDetail(String processInstanceId) {
        SealApply sealApply = this.getOne(new LambdaQueryWrapper<SealApply>()
                .eq(SealApply::getProcessInstanceId, processInstanceId));
        Assert.notNull(sealApply, "申请不存在");
        SealApplyVO vo = converter.entityToVo(sealApply);
        enrichSealApplyVO(vo);

        String processDefinitionId = flowableService.getProcessDefinitionIdByInstanceId(processInstanceId);

        if (StrUtil.isNotBlank(processDefinitionId)) {
            BpmnModel bpmnModel = repositoryService.getBpmnModel(processDefinitionId);
            List<WorkflowNodeVO> nodes = new ArrayList<>();

            List<HistoricTaskInstance> historicTasks = historyService.createHistoricTaskInstanceQuery()
                    .processInstanceId(processInstanceId)
                    .orderByHistoricTaskInstanceEndTime().asc()
                    .list();

            List<Task> activeTasks = flowableService.getTasksByProcessInstanceId(processInstanceId);
            Set<String> activeTaskDefKeys = activeTasks.stream()
                    .map(Task::getTaskDefinitionKey).collect(Collectors.toSet());

            Collection<FlowElement> flowElements = bpmnModel.getMainProcess().getFlowElements();
            for (FlowElement element : flowElements) {
                if (element instanceof UserTask userTask) {
					WorkflowNodeVO nodeVO = new WorkflowNodeVO();
                    nodeVO.setId(userTask.getId());
                    nodeVO.setNodeName(userTask.getName());

                    HistoricTaskInstance hti = historicTasks.stream()
                            .filter(h -> h.getTaskDefinitionKey().equals(userTask.getId()) && h.getEndTime() != null)
                            .findFirst().orElse(null);

                    if (hti != null) {
                        nodeVO.setStatus(2);
                        nodeVO.setApproverName(
                                getApproverName(Long.parseLong(hti.getAssignee() != null ? hti.getAssignee() : "0")));
                        nodeVO.setFinishTime(LocalDateTime.ofInstant(hti.getEndTime().toInstant(),
                                java.time.ZoneId.systemDefault()));
                    } else if (activeTaskDefKeys.contains(userTask.getId())) {
                        nodeVO.setStatus(1);
                    } else {
                        nodeVO.setStatus(0);
                    }

                    List<String> groups = userTask.getCandidateGroups();
                    if (groups != null && !groups.isEmpty()) {
                        nodeVO.setRoleName(getApproverRoleName(groups.get(0)));
                    }

                    nodes.add(nodeVO);
                }
            }
            vo.setProcessNodes(nodes);
        }

        return vo;
    }

    /**
     * 更新当前任务信息
     *
     * 查询流程实例的当前待办任务，更新申请表的当前节点信息。
     *
     * @param sealApply 申请实体
     */
    private void updateCurrentTaskInfo(SealApply sealApply) {
        String processInstanceId = sealApply.getProcessInstanceId();
        List<Task> tasks = flowableService.getTasksByProcessInstanceId(processInstanceId);
        if (tasks != null && !tasks.isEmpty()) {
            Task currentTask = tasks.get(0);
            sealApply.setCurrentNodeName(currentTask.getName());
            sealApply.setCurrentNodeKey(currentTask.getTaskDefinitionKey());
            sealApply.setCurrentApproverId(Long.parseLong(currentTask.getAssignee()));
            sealApply.setCurrentApproverName(getApproverName(Long.parseLong(currentTask.getAssignee())));
        }
    }

    /**
     * 根据ID获取申请实体
     *
     * @param id 申请ID
     * @return 申请实体
     */
    private SealApply getEntity(Long id) {
        SealApply entity = this.getOne(new LambdaQueryWrapper<SealApply>()
                .eq(SealApply::getId, id)
                .eq(SealApply::getDeleted, 0));
        Assert.notNull(entity, "申请不存在");
        return entity;
    }

    /**
     * 构建查询条件
     *
     * @param queryParams 查询参数
     * @return 查询条件包装器
     */
    private LambdaQueryWrapper<SealApply> getQueryWrapper(SealApplyPageQuery queryParams) {
        LambdaQueryWrapper<SealApply> qw = new LambdaQueryWrapper<>();
        qw.eq(SealApply::getDeleted, 0);
        qw.like(StrUtil.isNotBlank(queryParams.getSealName()), SealApply::getSealName, queryParams.getSealName());
        qw.eq(queryParams.getSealCategory() != null, SealApply::getSealCategory, queryParams.getSealCategory());
        qw.eq(queryParams.getStatus() != null, SealApply::getStatus, queryParams.getStatus());
        qw.eq(queryParams.getApplicantId() != null, SealApply::getApplicantId, queryParams.getApplicantId());
        qw.orderByDesc(SealApply::getApplyTime);
        return qw;
    }

    /**
     * 补充申请VO的关联信息
     *
     * @param vo 申请VO对象
     */
    private void enrichSealApplyVO(SealApplyVO vo) {
        vo.setSealCategoryName(getSealCategoryName(vo.getSealCategory()));
        vo.setSealTypeName(getSealTypeName(vo.getSealType()));
        vo.setUrgencyLevelName(getUrgencyLevelName(vo.getUrgencyLevel()));
        vo.setStatusName(getStatusName(vo.getStatus()));

        if (vo.getSealId() != null) {
            SealInfo sealInfo = sealInfoService.getById(vo.getSealId());
            if (sealInfo != null) {
                vo.setSealImageUrl(sealInfo.getImageUrl());
            }
        }

        if (vo.getId() != null) {
            List<SealApplyRecordVO> approvalRecords = approvalRecordService.getApprovalRecordsByApplyId(vo.getId());
            vo.setApprovalRecords(approvalRecords);
            vo.setProcessNodes(buildProcessNodes(vo, approvalRecords));
        }
    }

    private List<WorkflowNodeVO> buildProcessNodes(SealApplyVO vo, List<SealApplyRecordVO> approvalRecords) {
        List<WorkflowNodeVO> nodes = new ArrayList<>();

        nodes.add(WorkflowNodeVO.builder()
                .id("start")
                .type("start")
                .nodeName("发起申请")
                .status(2)
                .approverName(vo.getApplicantName())
                .roleName("申请人")
                .finishTime(vo.getApplyTime())
                .build());

        if (StrUtil.isNotBlank(vo.getProcessInstanceId())) {
            String processDefinitionId = flowableService.getProcessDefinitionIdByInstanceId(vo.getProcessInstanceId());

            if (StrUtil.isNotBlank(processDefinitionId)) {
                BpmnModel bpmnModel = repositoryService.getBpmnModel(processDefinitionId);

                if (bpmnModel != null) {
                    List<HistoricTaskInstance> historicTasks = historyService.createHistoricTaskInstanceQuery()
                            .processInstanceId(vo.getProcessInstanceId())
                            .orderByHistoricTaskInstanceEndTime().asc()
                            .list();

                    List<Task> activeTasks = flowableService.getTasksByProcessInstanceId(vo.getProcessInstanceId());
                    Set<String> activeTaskDefKeys = activeTasks.stream()
                            .map(Task::getTaskDefinitionKey).collect(Collectors.toSet());

                    Collection<FlowElement> flowElements = bpmnModel.getMainProcess().getFlowElements();

                    for (FlowElement element : flowElements) {
                        if (element instanceof UserTask userTask) {
							WorkflowNodeVO nodeVO = new WorkflowNodeVO();
                            nodeVO.setId(userTask.getId());
                            nodeVO.setType("approve");
                            nodeVO.setNodeName(userTask.getName());

                            HistoricTaskInstance hti = historicTasks.stream()
                                    .filter(h -> h.getTaskDefinitionKey().equals(userTask.getId()) && h.getEndTime() != null)
                                    .findFirst().orElse(null);

                            SealApplyRecordVO record = approvalRecords.stream()
                                    .filter(r -> r.getTaskKey() != null && r.getTaskKey().equals(userTask.getId()))
                                    .findFirst().orElse(null);

                            if (record != null) {
                                nodeVO.setStatus(2);
                                nodeVO.setApproverName(
                                        getApproverName(Long.parseLong(record.getApproverId() != null ? record.getApproverId().toString() : "0")));
                                nodeVO.setFinishTime(record.getApproveTime());
                                nodeVO.setComment(record.getApproveComment());
                                nodeVO.setApproveResult(record.getApproveResult());
                            } else if (activeTaskDefKeys.contains(userTask.getId())) {
                                nodeVO.setStatus(1);
                            } else {
                                nodeVO.setStatus(0);
                            }

                            List<String> groups = userTask.getCandidateGroups();
                            if (groups != null && !groups.isEmpty()) {
                                nodeVO.setRoleName(getApproverRoleName(groups.get(0)));
                            }

                            nodes.add(nodeVO);
                        }
                    }
                }
            }
        }

        if (vo.getStatus() == 2) {
            nodes.add(WorkflowNodeVO.builder()
                    .id("end")
                    .type("end")
                    .nodeName("流程结束")
                    .status(2)
                    .finishTime(vo.getFinishTime())
                    .build());
        } else if (vo.getStatus() == 3) {
            nodes.add(WorkflowNodeVO.builder()
                    .id("end")
                    .type("end")
                    .nodeName("流程结束")
                    .status(3)
                    .finishTime(vo.getFinishTime())
                    .build());
        } else if (vo.getStatus() == 4) {
            nodes.add(WorkflowNodeVO.builder()
                    .id("revoke")
                    .type("revoke")
                    .nodeName("流程撤销")
                    .status(3)
                    .approverName(vo.getApplicantName())
                    .roleName("申请人")
                    .finishTime(vo.getFinishTime())
                    .build());
            nodes.add(WorkflowNodeVO.builder()
                    .id("end")
                    .type("end")
                    .nodeName("流程结束")
                    .status(3)
                    .finishTime(vo.getFinishTime())
                    .build());
        }

        return nodes;
    }

    /**
     * 根据任务Key获取审批人角色代码
     *
     * @param taskKey 任务定义Key
     * @return 角色代码
     */
    private String getApproverRoleCode(String taskKey) {
        if (StrUtil.isBlank(taskKey)) {
            return "";
        }
        return taskKey;
    }

    /**
     * 根据任务Key获取审批阶段
     *
     * @param taskKey 任务定义Key
     * @return 审批阶段
     */
    private Integer getApprovalStage(String taskKey) {
        if (StrUtil.isBlank(taskKey)) {
            return 0;
        }
        return 1;
    }

    /**
     * 获取角色名称
     *
     * @param roleCode 角色代码
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
     * 获取审批人名称
     *
     * @param approverId 审批人ID
     * @return 审批人名称
     */
    private String getApproverName(Long approverId) {
        if (approverId == null) {
            return "";
        }
        try {
            SysUserVO userVO = sysUserService.getSysUserVo(approverId);
            return userVO != null ? userVO.getRealName() : "审批人" + approverId;
        } catch (Exception e) {
            return "审批人" + approverId;
        }
    }

    /**
     * 获取印章类别名称
     *
     * @param sealCategory 印章类别代码
     * @return 印章类别名称
     */
    private String getSealCategoryName(Integer sealCategory) {
        if (sealCategory == null)
            return "";
        return switch (sealCategory) {
            case 1 -> "院章";
            case 2 -> "党章";
            default -> "";
        };
    }

    /**
     * 获取印章类型名称
     *
     * @param sealType 印章类型代码
     * @return 印章类型名称
     */
    private String getSealTypeName(Integer sealType) {
        if (sealType == null)
            return "";
        return switch (sealType) {
            case 1 -> "物理章";
            case 2 -> "电子章";
            default -> "";
        };
    }

    /**
     * 获取紧急程度名称
     *
     * @param urgencyLevel 紧急程度代码
     * @return 紧急程度名称
     */
    private String getUrgencyLevelName(Integer urgencyLevel) {
        if (urgencyLevel == null)
            return "";
        return switch (urgencyLevel) {
            case 1 -> "普通";
            case 2 -> "紧急";
            case 3 -> "特急";
            default -> "";
        };
    }

    /**
     * 获取申请状态名称
     *
     * @param status 状态代码
     * @return 状态名称
     */
    private String getStatusName(Integer status) {
        if (status == null)
            return "";
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
