package com.sealflow.service.Impl;

import cn.hutool.core.util.StrUtil;
import com.sealflow.service.IFlowableService;
import lombok.RequiredArgsConstructor;
import org.flowable.engine.HistoryService;
import org.flowable.engine.RepositoryService;
import org.flowable.engine.RuntimeService;
import org.flowable.engine.TaskService;
import org.flowable.engine.repository.Deployment;
import org.flowable.engine.repository.ProcessDefinition;
import org.flowable.engine.runtime.ProcessInstance;
import org.flowable.task.api.Task;
import org.springframework.stereotype.Service;

import java.io.ByteArrayInputStream;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * Flowable工作流服务实现类
 *
 * 该类封装了与Flowable引擎交互的所有核心操作，包括：
 * - 流程部署：deployProcess()
 * - 流程启动：startProcessInstanceByKey()
 * - 任务处理：completeTask()、getTaskById()
 * - 任务查询：getTasksByAssignee()、getTasksByCandidateGroups()、getTasksByProcessInstanceId()
 * - 流程管理：deleteProcessInstance()、getRuntimeProcessInstance()
 * - 信息查询：getProcessDefinitionId()、getProcessDefinitionName()等
 *
 * 业务模块应通过注入IFlowableService接口来调用这些方法，
 * 而不是直接使用Flowable引擎API，以实现解耦和统一管理。
 */
@Service
@RequiredArgsConstructor
public class FlowableServiceImpl implements IFlowableService {

    /**
     * 流程定义存储服务
     * 用于查询流程定义、部署流程等操作
     */
    private final RepositoryService repositoryService;

    /**
     * 运行时服务
     * 用于启动流程实例、管理运行中的流程等操作
     */
    private final RuntimeService runtimeService;

    /**
     * 任务服务
     * 用于查询任务、完成任务等操作
     */
    private final TaskService taskService;

    /**
     * 历史服务
     * 用于查询历史数据，如已完成的任务、历史流程实例等
     */
    private final HistoryService historyService;

    /**
     * 部署流程定义
     *
     * 将BPMN 2.0 XML格式的流程定义部署到Flowable引擎中。
     * 部署后，可以使用返回的部署信息获取流程定义ID。
     *
     * @param processName 流程名称，用于展示
     * @param processKey 流程标识（唯一），用于后续通过Key启动流程
     * @param bpmnXml BPMN XML格式的流程定义内容
     * @return 部署信息对象，包含部署ID等元数据
     */
    @Override
    public Deployment deployProcess(String processName, String processKey, String bpmnXml) {
        return repositoryService.createDeployment()
                .name(processName)
                .addInputStream(processKey + ".bpmn20.xml",
                        new ByteArrayInputStream(bpmnXml.getBytes(StandardCharsets.UTF_8)))
                .deploy();
    }

    /**
     * 根据部署ID获取流程定义ID
     *
     * 部署流程后，Flowable会生成一个部署ID。
     * 通过该部署ID可以查询到对应的流程定义ID。
     *
     * @param deploymentId 部署ID，由deployProcess()方法返回
     * @return 流程定义ID，如果未找到则返回null
     */
    @Override
    public String getProcessDefinitionId(String deploymentId) {
        ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery()
                .deploymentId(deploymentId)
                .singleResult();
        return processDefinition != null ? processDefinition.getId() : null;
    }

    /**
     * 根据流程Key启动流程实例
     *
     * 通过流程定义Key启动一个新的流程实例。
     * 启动后，流程会从开始节点向下流转到第一个用户任务。
     *
     * @param processKey 流程定义Key，对应流程模板的processKey字段
     * @param businessKey 业务Key，用于将流程实例与业务数据关联
     * @param variables 流程变量，会传递给流程中的各个节点使用
     * @return 新创建的流程实例对象，包含流程实例ID等信息
     */
    @Override
    public ProcessInstance startProcessInstanceByKey(String processKey, String businessKey, Map<String, Object> variables) {
        return runtimeService.startProcessInstanceByKey(processKey, businessKey, variables);
    }

    /**
     * 完成任务
     *
     * 完成指定的任务，并可选地传递流程变量。
     * 调用此方法后，流程会流转到下一个节点。
     *
     * @param taskId 要完成的任务ID
     * @param variables 流程变量，如审批结果(approved)、拒绝原因(rejectReason)等
     */
    @Override
    public void completeTask(String taskId, Map<String, Object> variables) {
        taskService.complete(taskId, variables);
    }

    /**
     * 根据任务ID获取任务信息
     *
     * 通过任务ID查询任务的详细信息，包括任务名称、所属流程、任务候选人等。
     *
     * @param taskId 任务ID
     * @return 任务对象，如果未找到则返回null
     */
    @Override
    public Task getTaskById(String taskId) {
        return taskService.createTaskQuery().taskId(taskId).singleResult();
    }

    /**
     * 获取分配给指定用户的任务列表
     *
     * 查询所有直接分配给该用户的待办任务。
     * 注意：这是直接分配给用户的任务，不包括候选人角色任务。
     *
     * @param assignee 用户ID（字符串格式）
     * @return 任务列表，如果无任务则返回空列表
     */
    @Override
    public List<Task> getTasksByAssignee(String assignee) {
        return taskService.createTaskQuery().taskAssignee(assignee).list();
    }

    /**
     * 获取候选组包含指定角色代码的任务列表
     *
     * 查询所有候选人角色包含在指定角色列表中的任务。
     * 用户可以查看其所属角色能够处理的所有任务。
     *
     * @param groupIds 角色代码列表，如["DEAN", "MENTOR"]
     * @return 任务列表，如果无任务则返回空列表
     */
    @Override
    public List<Task> getTasksByCandidateGroups(List<String> groupIds) {
        return taskService.createTaskQuery().taskCandidateGroupIn(groupIds).list();
    }

    /**
     * 删除流程实例
     *
     * 删除指定的流程实例及其相关数据。
     * 通常用于撤销申请、作废流程等场景。
     *
     * @param processInstanceId 要删除的流程实例ID
     * @param deleteReason 删除原因，会记录在历史中
     */
    @Override
    public void deleteProcessInstance(String processInstanceId, String deleteReason) {
        runtimeService.deleteProcessInstance(processInstanceId, deleteReason);
    }

    /**
     * 根据流程实例ID获取流程定义ID
     *
     * 通过流程实例查询其所属的流程定义ID。
     *
     * @param processInstanceId 流程实例ID
     * @return 流程定义ID，如果未找到则返回null
     */
    @Override
    public String getProcessDefinitionIdByInstanceId(String processInstanceId) {
        ProcessInstance processInstance = runtimeService.createProcessInstanceQuery()
                .processInstanceId(processInstanceId)
                .singleResult();
        return processInstance != null ? processInstance.getProcessDefinitionId() : null;
    }

    /**
     * 根据流程定义ID获取流程定义名称
     *
     * @param processDefinitionId 流程定义ID
     * @return 流程定义名称，如果未找到则返回null
     */
    @Override
    public String getProcessDefinitionName(String processDefinitionId) {
        ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery()
                .processDefinitionId(processDefinitionId)
                .singleResult();
        return processDefinition != null ? processDefinition.getName() : null;
    }

    /**
     * 从任务列表中提取所有流程实例ID
     *
     * 将任务列表转换为去重的流程实例ID列表。
     * 常用于批量查询多个任务所属的流程实例。
     *
     * @param tasks 任务列表
     * @return 流程实例ID列表（去重后的）
     */
    @Override
    public List<String> getProcessInstanceIdsByTasks(List<Task> tasks) {
        return tasks.stream()
                .map(Task::getProcessInstanceId)
                .distinct()
                .collect(Collectors.toList());
    }

    /**
     * 获取运行中的流程实例
     *
     * 查询指定ID的流程实例是否还在运行中。
     * 如果流程已结束（通过、拒绝、撤销），则返回null。
     *
     * @param processInstanceId 流程实例ID
     * @return 流程实例对象，如果已结束则返回null
     */
    @Override
    public ProcessInstance getRuntimeProcessInstance(String processInstanceId) {
        return runtimeService.createProcessInstanceQuery()
                .processInstanceId(processInstanceId)
                .singleResult();
    }

    /**
     * 获取指定流程实例的所有任务
     *
     * 查询指定流程实例下所有当前待办的任务。
     * 通常一个流程实例只有一个待办任务，但并行网关等情况可能有多个。
     *
     * @param processInstanceId 流程实例ID
     * @return 任务列表，如果无任务则返回空列表
     */
    @Override
    public List<Task> getTasksByProcessInstanceId(String processInstanceId) {
        return taskService.createTaskQuery()
                .processInstanceId(processInstanceId)
                .list();
    }

    @Override
    public void suspendProcessDefinition(String processDefinitionId) {
        repositoryService.suspendProcessDefinitionById(processDefinitionId);
    }

    @Override
    public void activateProcessDefinition(String processDefinitionId) {
        repositoryService.activateProcessDefinitionById(processDefinitionId);
    }

    @Override
    public boolean isProcessDefinitionSuspended(String processDefinitionId) {
        if (StrUtil.isBlank(processDefinitionId)) {
            return false;
        }
        ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery()
                .processDefinitionId(processDefinitionId)
                .singleResult();
        return processDefinition != null && processDefinition.isSuspended();
    }

    @Override
    public void deleteProcessDefinition(String processDefinitionId) {
        ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery()
                .processDefinitionId(processDefinitionId)
                .singleResult();
        if (processDefinition != null) {
            repositoryService.deleteDeployment(processDefinition.getDeploymentId(), true);
        }
    }
}
