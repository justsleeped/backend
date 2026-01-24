package com.sealflow.service;

import org.flowable.engine.repository.Deployment;
import org.flowable.engine.runtime.ProcessInstance;
import org.flowable.task.api.Task;

import java.util.List;
import java.util.Map;

public interface IFlowableService {

    /**
     * 部署流程定义
     * @param processName 流程名称
     * @param processKey 流程标识
     * @param bpmnXml BPMN XML内容
     * @return 部署信息
     */
    Deployment deployProcess(String processName, String processKey, String bpmnXml);

    /**
     * 根据部署ID获取流程定义ID
     * @param deploymentId 部署ID
     * @return 流程定义ID
     */
    String getProcessDefinitionId(String deploymentId);

    /**
     * 根据流程Key启动流程实例
     * @param processKey 流程Key
     * @param businessKey 业务Key（用于关联业务数据）
     * @param variables 流程变量
     * @return 流程实例
     */
    ProcessInstance startProcessInstanceByKey(String processKey, String businessKey, Map<String, Object> variables);

    /**
     * 完成任务
     * @param taskId 任务ID
     * @param variables 流程变量（如审批结果、审批意见等）
     */
    void completeTask(String taskId, Map<String, Object> variables);

    /**
     * 根据任务ID获取任务
     * @param taskId 任务ID
     * @return 任务信息
     */
    Task getTaskById(String taskId);

    /**
     * 获取分配给指定用户的任务列表
     * @param assignee 用户ID
     * @return 任务列表
     */
    List<Task> getTasksByAssignee(String assignee);

    /**
     * 获取候选组包含指定角色代码的任务列表
     * @param groupIds 角色代码列表
     * @return 任务列表
     */
    List<Task> getTasksByCandidateGroups(List<String> groupIds);

    /**
     * 删除流程实例（用于撤销流程）
     * @param processInstanceId 流程实例ID
     * @param deleteReason 删除原因
     */
    void deleteProcessInstance(String processInstanceId, String deleteReason);

    /**
     * 根据流程实例ID获取流程定义ID
     * @param processInstanceId 流程实例ID
     * @return 流程定义ID
     */
    String getProcessDefinitionIdByInstanceId(String processInstanceId);

    /**
     * 根据流程定义ID获取流程定义名称
     * @param processDefinitionId 流程定义ID
     * @return 流程定义名称
     */
    String getProcessDefinitionName(String processDefinitionId);

    /**
     * 从任务列表中提取所有流程实例ID
     * @param tasks 任务列表
     * @return 流程实例ID列表（去重）
     */
    List<String> getProcessInstanceIdsByTasks(List<Task> tasks);

    /**
     * 获取运行中的流程实例
     * @param processInstanceId 流程实例ID
     * @return 流程实例
     */
    ProcessInstance getRuntimeProcessInstance(String processInstanceId);

    /**
     * 获取指定流程实例的所有任务
     * 
     * @param processInstanceId 流程实例ID
     * @return 任务列表
     */
    List<Task> getTasksByProcessInstanceId(String processInstanceId);

    /**
     * 挂起流程定义
     * 
     * 挂起后，不允许创建新的流程实例，但不影响已启动的实例。
     * 
     * @param processDefinitionId 流程定义ID
     */
    void suspendProcessDefinition(String processDefinitionId);

    /**
     * 激活流程定义
     * 
     * 激活后，可以创建新的流程实例。
     * 
     * @param processDefinitionId 流程定义ID
     */
    void activateProcessDefinition(String processDefinitionId);

    /**
     * 检查流程定义是否已挂起
     * 
     * @param processDefinitionId 流程定义ID
     * @return 是否已挂起
     */
    boolean isProcessDefinitionSuspended(String processDefinitionId);

    /**
     * 删除流程定义（用于取消部署）
     * 
     * @param processDefinitionId 流程定义ID
     */
    void deleteProcessDefinition(String processDefinitionId);
}
