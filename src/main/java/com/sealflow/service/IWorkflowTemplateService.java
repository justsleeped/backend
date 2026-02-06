package com.sealflow.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.sealflow.model.entity.WorkflowTemplate;
import com.sealflow.model.form.WorkflowTemplateForm;
import com.sealflow.model.query.WorkflowTemplatePageQuery;
import com.sealflow.model.vo.WorkflowTemplateVO;

/**
 * 工作流模板服务接口
 */
public interface IWorkflowTemplateService extends IService<WorkflowTemplate> {

    /**
     * 保存工作流模板
     *
     * @param formData 表单数据
     * @return 模板ID
     */
    Long saveWorkflowTemplate(WorkflowTemplateForm formData);

    /**
     * 更新工作流模板
     *
     * @param id       模板ID
     * @param formData 表单数据
     */
    void updateWorkflowTemplate(Long id, WorkflowTemplateForm formData);

    /**
     * 删除工作流模板
     *
     * @param idStr ID字符串（支持多个ID，逗号分隔）
     */
    void deleteWorkflowTemplate(String idStr);

    /**
     * 根据ID获取模板详情
     *
     * @param id 模板ID
     * @return 模板视图对象
     */
    WorkflowTemplateVO getWorkflowTemplateVo(Long id);

    /**
     * 分页查询模板列表
     *
     * @param queryParams 查询参数
     * @return 分页结果
     */
    IPage<WorkflowTemplateVO> pageWorkflowTemplate(WorkflowTemplatePageQuery queryParams);

    /**
     * 部署模板到Flowable引擎
     *
     * @param id 模板ID
     */
    void deployTemplate(Long id);

    /**
     * 取消部署模板
     *
     * @param id 模板ID
     */
    void undeployTemplate(Long id);

    /**
     * 根据用户ID查找匹配的已部署模板
     *
     * @param userId 用户ID
     * @return 模板对象，如果没有找到返回null
     */
    WorkflowTemplate findMatchedTemplate(Long userId);

    /**
     * 挂起工作流模板
     *
     * 挂起后，不允许创建新的流程实例，但不影响已启动的实例。
     *
     * @param id 模板ID
     */
    void suspendTemplate(Long id);

    /**
     * 激活工作流模板
     *
     * 激活后，可以创建新的流程实例。
     *
     * @param id 模板ID
     */
    void activateTemplate(Long id);

    /**
     * 检查工作流模板是否已挂起
     *
     * @param id 模板ID
     * @return 是否已挂起
     */
    boolean isTemplateSuspended(Long id);

    /**
     * 验证用户是否有权限发起该工作流
     *
     * @param templateId 模板ID
     * @param userId 用户ID
     * @return 是否有权限
     */
    boolean hasInitiatePermission(Long templateId, Long userId);
}
