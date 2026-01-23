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
import com.sealflow.model.entity.SealApplyRecord;
import com.sealflow.model.entity.SealInfo;
import com.sealflow.model.form.SealApplyForm;
import com.sealflow.model.query.SealApplyPageQuery;
import com.sealflow.model.vo.SealApplyVO;
import com.sealflow.model.vo.SealApplyRecordVO;
import com.sealflow.model.vo.SysUserVO;
import com.sealflow.service.ISealApplyRecordService;
import com.sealflow.service.ISealApplyService;
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

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class SealApplyServiceImpl extends ServiceImpl<SealApplyMapper, SealApply> implements ISealApplyService {

    private final SealApplyConverter converter;
    private final ISealApplyRecordService approvalRecordService;
    private final RuntimeService runtimeService;
    private final TaskService taskService;
    private final HistoryService historyService;
    private final RepositoryService repositoryService;
    private final com.sealflow.service.ISysUserService sysUserService;
    private final ISysUserRoleService sysUserRoleService;
    private final com.sealflow.service.ISealInfoService sealInfoService;

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

        Assert.isTrue(this.save(entity), "添加失败");

        startProcess(entity.getId());

        return entity.getId();
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updateSealApply(Long id, SealApplyForm formData) {
        SealApply existing = getEntity(id);
        Assert.isTrue(existing.getStatus() == 0, "只有待审批的申请才能修改");
        SealApply entity = converter.formToEntity(formData);
        entity.setId(id);

        if (formData.getSealId() != null) {
            com.sealflow.model.entity.SealInfo sealInfo = sealInfoService.getById(formData.getSealId());
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
            entity.setExpectedUseDate(LocalDateTime.parse(formData.getExpectedUseDate(), DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
        }

        Assert.isTrue(this.updateById(entity), "修改失败");
    }

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

    @Override
    public SealApplyVO getSealApplyVo(Long id) {
        SealApply entity = getEntity(id);
        SealApplyVO vo = converter.entityToVo(entity);
        enrichSealApplyVO(vo);
        return vo;
    }

    @Override
    public IPage<SealApplyVO> pageSealApply(SealApplyPageQuery queryParams) {
        Page<SealApply> page = new Page<>(queryParams.getPageNum(), queryParams.getPageSize());
        Page<SealApply> sealApplyPage = this.baseMapper.selectPage(page, getQueryWrapper(queryParams));
        IPage<SealApplyVO> resultPage = converter.entityToVOForPage(sealApplyPage);
        resultPage.getRecords().forEach(this::enrichSealApplyVO);
        return resultPage;
    }

    @Override
    public List<SealApplyVO> listSealApply(SealApplyPageQuery queryParams) {
        List<SealApplyVO> list = converter.entityToVo(this.list(getQueryWrapper(queryParams)));
        list.forEach(this::enrichSealApplyVO);
        return list;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void startProcess(Long applyId) {
        SealApply sealApply = getEntity(applyId);
        Assert.isTrue(sealApply.getStatus() == 0, "只有待审批的申请才能发起流程");

        Map<String, Object> variables = new HashMap<>();
        variables.put("applicantId", sealApply.getApplicantId());
        variables.put("applicantName", sealApply.getApplicantName());
        variables.put("applyId", applyId);
        variables.put("sealCategory", sealApply.getSealCategory());
        variables.put("sealType", sealApply.getSealType());

        ProcessInstance processInstance = runtimeService.startProcessInstanceByKey("sealApplyProcess", sealApply.getApplyNo(), variables);

        sealApply.setProcessInstanceId(processInstance.getId());
        sealApply.setProcessDefinitionKey(processInstance.getProcessDefinitionKey());
        sealApply.setStatus(1);

        ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery()
                .processDefinitionId(processInstance.getProcessDefinitionId())
                .singleResult();
        if (processDefinition != null) {
            sealApply.setProcessName(processDefinition.getName());
        }

        updateCurrentTaskInfo(sealApply);
        Assert.isTrue(this.updateById(sealApply), "更新申请状态失败");
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void approveTask(String taskId, Integer approveResult, String approveComment, Long approverId) {
        Task task = taskService.createTaskQuery().taskId(taskId).singleResult();
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
        LocalDateTime taskStartTime = historicTask != null ?
                historicTask.getCreateTime().toInstant().atZone(java.time.ZoneId.systemDefault()).toLocalDateTime() : LocalDateTime.now();

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
                approveComment
        );

        taskService.complete(taskId, variables);

        ProcessInstance processInstance = runtimeService.createProcessInstanceQuery()
                .processInstanceId(sealApply.getProcessInstanceId())
                .singleResult();

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

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void revokeProcess(Long applyId, Long userId) {
        SealApply sealApply = getEntity(applyId);
        Assert.isTrue(sealApply.getApplicantId().equals(userId), "只有申请人才能撤销");
        Assert.isTrue(sealApply.getStatus() == 1, "只有审批中的申请才能撤销");

        runtimeService.deleteProcessInstance(sealApply.getProcessInstanceId(), "申请人撤销");

        sealApply.setStatus(4);
        sealApply.setCurrentNodeName(null);
        sealApply.setCurrentNodeKey(null);
        sealApply.setCurrentApproverId(null);
        sealApply.setCurrentApproverName(null);
        Assert.isTrue(this.updateById(sealApply), "撤销失败");
    }

    @Override
    public IPage<SealApplyVO> pageMyStarted(SealApplyPageQuery queryParams, Long userId) {
        queryParams.setApplicantId(userId);
        return pageSealApply(queryParams);
    }

    @Override
    public IPage<SealApplyVO> pageMyApproved(SealApplyPageQuery queryParams, Long userId) {
        List<SealApplyRecord> approvalRecords = approvalRecordService.list(
                new LambdaQueryWrapper<SealApplyRecord>()
                        .eq(SealApplyRecord::getApproverId, userId)
        );

        if (approvalRecords.isEmpty()) {
            return new Page<>(queryParams.getPageNum(), queryParams.getPageSize());
        }

        Set<Long> approvedApplyIds = approvalRecords.stream()
                .map(SealApplyRecord::getApplyId)
                .collect(Collectors.toSet());

        Page<SealApply> page = new Page<>(queryParams.getPageNum(), queryParams.getPageSize());
        LambdaQueryWrapper<SealApply> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(SealApply::getDeleted, 0);
        wrapper.in(SealApply::getId, approvedApplyIds);
        wrapper.orderByDesc(SealApply::getApplyTime);

        Page<SealApply> sealApplyPage = this.baseMapper.selectPage(page, wrapper);
        IPage<SealApplyVO> resultPage = converter.entityToVOForPage(sealApplyPage);
        resultPage.getRecords().forEach(this::enrichSealApplyVO);
        return resultPage;
    }

    @Override
    public IPage<SealApplyVO> pageTodoTasks(SealApplyPageQuery queryParams, Long userId) {
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

        Page<SealApply> page = new Page<>(queryParams.getPageNum(), queryParams.getPageSize());
        LambdaQueryWrapper<SealApply> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(SealApply::getDeleted, 0);
        wrapper.in(SealApply::getProcessInstanceId, processInstanceIds);
        wrapper.orderByDesc(SealApply::getApplyTime);

        Page<SealApply> sealApplyPage = this.baseMapper.selectPage(page, wrapper);
        IPage<SealApplyVO> resultPage = converter.entityToVOForPage(sealApplyPage);
        resultPage.getRecords().forEach(this::enrichSealApplyVO);
        return resultPage;
    }

    @Override
    public SealApplyVO getProcessDetail(String processInstanceId) {
        SealApply sealApply = this.getOne(new LambdaQueryWrapper<SealApply>()
                .eq(SealApply::getProcessInstanceId, processInstanceId));
        Assert.notNull(sealApply, "申请不存在");
        SealApplyVO vo = converter.entityToVo(sealApply);
        enrichSealApplyVO(vo);
        return vo;
    }

    private void updateCurrentTaskInfo(SealApply sealApply) {
        Task currentTask = taskService.createTaskQuery()
                .processInstanceId(sealApply.getProcessInstanceId())
                .singleResult();
        if (currentTask != null) {
            sealApply.setCurrentNodeName(currentTask.getName());
            sealApply.setCurrentNodeKey(currentTask.getTaskDefinitionKey());
            if (currentTask.getAssignee() != null) {
                try {
                    Long approverId = Long.parseLong(currentTask.getAssignee());
                    sealApply.setCurrentApproverId(approverId);
                    sealApply.setCurrentApproverName(getApproverName(approverId));
                } catch (NumberFormatException e) {
                    sealApply.setCurrentApproverName(currentTask.getAssignee());
                }
            }
        }
    }

    private void enrichSealApplyVO(SealApplyVO vo) {
        vo.setSealCategoryName(getSealCategoryName(vo.getSealCategory()));
        vo.setSealTypeName(getSealTypeName(vo.getSealType()));
        vo.setUrgencyLevelName(getUrgencyLevelName(vo.getUrgencyLevel()));
        vo.setStatusName(getStatusName(vo.getStatus()));

        List<SealApplyRecordVO> approvalRecords = approvalRecordService.getApprovalRecordsByApplyId(vo.getId());
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

    private LambdaQueryWrapper<SealApply> getQueryWrapper(SealApplyPageQuery queryParams) {
        LambdaQueryWrapper<SealApply> qw = new LambdaQueryWrapper<>();
        qw.eq(SealApply::getDeleted, 0);
        qw.like(StrUtil.isNotBlank(queryParams.getApplyNo()), SealApply::getApplyNo, queryParams.getApplyNo());
        qw.eq(queryParams.getApplicantId() != null, SealApply::getApplicantId, queryParams.getApplicantId());
        qw.like(StrUtil.isNotBlank(queryParams.getApplicantName()), SealApply::getApplicantName, queryParams.getApplicantName());
        qw.like(StrUtil.isNotBlank(queryParams.getApplicantNo()), SealApply::getApplicantNo, queryParams.getApplicantNo());
        qw.eq(queryParams.getSealId() != null, SealApply::getSealId, queryParams.getSealId());
        qw.like(StrUtil.isNotBlank(queryParams.getSealName()), SealApply::getSealName, queryParams.getSealName());
        qw.eq(queryParams.getSealCategory() != null, SealApply::getSealCategory, queryParams.getSealCategory());
        qw.eq(queryParams.getSealType() != null, SealApply::getSealType, queryParams.getSealType());
        qw.eq(queryParams.getUrgencyLevel() != null, SealApply::getUrgencyLevel, queryParams.getUrgencyLevel());
        qw.eq(queryParams.getStatus() != null, SealApply::getStatus, queryParams.getStatus());
        qw.orderByDesc(SealApply::getApplyTime);
        return qw;
    }

    private SealApply getEntity(Long id) {
        SealApply entity = this.getOne(new LambdaQueryWrapper<SealApply>()
                .eq(SealApply::getId, id)
                .eq(SealApply::getDeleted, 0)
        );
        Assert.isTrue(null != entity, "数据不存在");
        return entity;
    }

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

    private String getApproverRoleName(String roleCode) {
        return switch (roleCode) {
            case "CLASSGUIDE" -> "班主任";
            case "MENTOR" -> "辅导员";
            case "DEAN" -> "学院院长";
            case "PARTYSECRETARY" -> "党委书记";
            default -> "";
        };
    }

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

    private String getSealCategoryName(Integer sealCategory) {
        if (sealCategory == null) return "";
        return switch (sealCategory) {
            case 1 -> "院章";
            case 2 -> "党章";
            default -> "";
        };
    }

    private String getSealTypeName(Integer sealType) {
        if (sealType == null) return "";
        return switch (sealType) {
            case 1 -> "物理章";
            case 2 -> "电子章";
            default -> "";
        };
    }

    private String getUrgencyLevelName(Integer urgencyLevel) {
        if (urgencyLevel == null) return "";
        return switch (urgencyLevel) {
            case 1 -> "普通";
            case 2 -> "紧急";
            case 3 -> "特急";
            default -> "";
        };
    }

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
