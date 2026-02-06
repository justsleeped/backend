package com.sealflow.service.Impl;

import cn.hutool.core.lang.Assert;
import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.sealflow.converter.WorkflowTemplateConverter;
import com.sealflow.mapper.WorkflowTemplateMapper;
import com.sealflow.model.entity.WorkflowTemplate;
import com.sealflow.model.form.WorkflowTemplateForm;
import com.sealflow.model.query.WorkflowTemplatePageQuery;
import com.sealflow.model.vo.WorkflowTemplateVO;
import com.sealflow.service.IFlowableService;
import com.sealflow.service.ISysUserRoleService;
import com.sealflow.service.IWorkflowTemplateService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.flowable.engine.repository.Deployment;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 工作流模板服务实现类
 *
 * 该类负责管理工作流模板的完整生命周期，包括：
 * - 模板的增删改查操作
 * - 模板的部署与取消部署
 * - 模板与节点配置的管理
 * - 根据条件匹配适用的模板
 *
 * 核心流程：
 * 1. 设计阶段：创建/编辑模板，设置BPMN XML和节点配置
 * 2. 部署阶段：调用IFlowableService将模板部署到Flowable引擎
 * 3. 运行阶段：根据业务类型匹配模板，启动审批流程
 */
@Service
@Slf4j
@RequiredArgsConstructor
public class WorkflowTemplateServiceImpl extends ServiceImpl<WorkflowTemplateMapper, WorkflowTemplate>
        implements IWorkflowTemplateService {

    /**
     * 实体与表单/VO之间的转换器
     */
    private final WorkflowTemplateConverter converter;

    /**
     * Flowable工作流服务
     * 用于将模板部署到Flowable引擎
     */
    private final IFlowableService flowableService;

    /**
     * 用户角色服务
     * 用于查询用户的角色信息
     */
    private final ISysUserRoleService userRoleService;

    /**
     * 保存工作流模板
     *
     * 新建一个工作流模板，保存基本信息、BPMN XML和节点配置。
     * 新建的模板默认处于未部署状态(deployed=0)。
     *
     * @param formData 模板表单数据
     * @return 新创建的模板ID
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Long saveWorkflowTemplate(WorkflowTemplateForm formData) {
        WorkflowTemplate entity = converter.formToEntity(formData);

        entity.setDeployed(0);
        entity.setStatus(1);

        if (formData.getAllowedRoles() != null && !formData.getAllowedRoles().isEmpty()) {
            entity.setAllowedRoles(JSONUtil.toJsonStr(formData.getAllowedRoles()));
        }

        if (formData.getSealCategory() != null) {
            entity.setSealCategory(formData.getSealCategory());
        }

        Assert.isTrue(this.save(entity), "保存模板失败");

        return entity.getId();
    }

    /**
     * 更新工作流模板
     *
     * 更新模板的基本信息、BPMN XML和节点配置。
     * 注意：只有未部署的模板才能修改，已部署的模板需要先取消部署。
     *
     * @param id 模板ID
     * @param formData 更新后的模板数据
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updateWorkflowTemplate(Long id, WorkflowTemplateForm formData) {
        WorkflowTemplate existing = getEntity(id);
        Assert.isTrue(existing.getDeployed() == 0, "已部署的模板不能修改，请先取消部署");

        WorkflowTemplate entity = converter.formToEntity(formData);
        entity.setId(id);

        if (formData.getAllowedRoles() != null && !formData.getAllowedRoles().isEmpty()) {
            entity.setAllowedRoles(JSONUtil.toJsonStr(formData.getAllowedRoles()));
        } else {
            entity.setAllowedRoles(null);
        }

        if (formData.getSealCategory() != null) {
            entity.setSealCategory(formData.getSealCategory());
        }

        Assert.isTrue(this.updateById(entity), "更新模板失败");
    }

    /**
     * 删除工作流模板
     *
     * 批量删除模板，标记为删除状态而非物理删除。
     * 限制：已部署的模板不能删除，必须先取消部署。
     *
     * @param idStr 模板ID字符串，多个用逗号分隔
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deleteWorkflowTemplate(String idStr) {
        Assert.isFalse(StrUtil.isEmpty(idStr), "ID不能为空");
        List<Long> ids = Arrays.stream(idStr.split(","))
                .map(Long::parseLong)
                .collect(Collectors.toList());

        long deployedCount = this.count(new LambdaQueryWrapper<WorkflowTemplate>()
                .in(WorkflowTemplate::getId, ids)
                .eq(WorkflowTemplate::getDeployed, 1));
        Assert.isTrue(deployedCount == 0, "存在已部署的模板，不能删除");

        LambdaUpdateWrapper<WorkflowTemplate> wrapper = new LambdaUpdateWrapper<>();
        wrapper.set(WorkflowTemplate::getDeleted, 1)
                .in(WorkflowTemplate::getId, ids);
        Assert.isTrue(this.update(wrapper), "删除失败");
    }

    /**
     * 获取工作流模板详情
     *
     * @param id 模板ID
     * @return 模板详情VO，包含节点配置信息
     */
    @Override
    public WorkflowTemplateVO getWorkflowTemplateVo(Long id) {
        WorkflowTemplate entity = getEntity(id);
        WorkflowTemplateVO vo = converter.entityToVo(entity);
        enrichVO(vo);
        return vo;
    }

    /**
     * 分页查询工作流模板
     *
     * @param queryParams 分页查询参数
     * @return 分页结果
     */
    @Override
    public IPage<WorkflowTemplateVO> pageWorkflowTemplate(WorkflowTemplatePageQuery queryParams) {
        Page<WorkflowTemplate> page = new Page<>(queryParams.getPageNum(), queryParams.getPageSize());
        Page<WorkflowTemplate> templatePage = this.baseMapper.selectPage(page, getQueryWrapper(queryParams));
        IPage<WorkflowTemplateVO> resultPage = converter.entityToVOForPage(templatePage);
        resultPage.getRecords().forEach(this::enrichVO);
        return resultPage;
    }

    /**
     * 部署工作流模板
     *
     * 将模板的BPMN XML部署到Flowable引擎中。
     * 部署成功后，模板状态变为已部署(deployed=1)，
     * 此时可以根据此模板启动审批流程。
     *
     * 部署流程：
     * 1. 调用IFlowableService.deployProcess()将BPMN XML部署到Flowable
     * 2. 获取流程定义ID
     * 3. 更新模板的部署状态和流程定义ID
     *
     * @param id 模板ID
     * @throws RuntimeException 部署失败时抛出异常
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deployTemplate(Long id) {
        WorkflowTemplate template = getEntity(id);
        log.info("开始部署模板: {}", template.getName());
        Assert.isFalse(StrUtil.isBlank(template.getBpmnXml()), "BPMN XML不能为空");

        try {
            Deployment deployment = flowableService.deployProcess(
                    template.getName(),
                    template.getProcessKey(),
                    template.getBpmnXml()
            );

            String processDefinitionId = flowableService.getProcessDefinitionId(deployment.getId());

            template.setDeployed(1);
            template.setProcessDefinitionId(processDefinitionId);
            Assert.isTrue(this.updateById(template), "更新部署状态失败");

        } catch (Exception e) {
            throw new RuntimeException("部署模板失败: " + e.getMessage(), e);
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void undeployTemplate(Long id) {
        WorkflowTemplate template = getEntity(id);
        Assert.isTrue(template.getDeployed() == 1, "模板未部署");

        try {
            if (StrUtil.isNotBlank(template.getProcessDefinitionId())) {
                flowableService.deleteProcessDefinition(template.getProcessDefinitionId());
            }

            template.setDeployed(0);
            template.setProcessDefinitionId(null);
            Assert.isTrue(this.updateById(template), "更新部署状态失败");

        } catch (Exception e) {
            throw new RuntimeException("取消部署失败: " + e.getMessage(), e);
        }
    }

    /**
     * 根据用户ID查找匹配的已部署模板
     *
     * 查找流程：
     * 1. 查找所有已部署且启用的模板
     * 2. 如果模板未设置角色限制，返回该模板
     * 3. 如果模板设置了角色限制，检查用户角色是否在允许列表中
     * 4. 返回第一个匹配的模板
     *
     * @param userId 用户ID
     * @return 匹配的模板，如果未找到返回null
     */
    @Override
    public WorkflowTemplate findMatchedTemplate(Long userId) {
        List<WorkflowTemplate> templates = this.list(new LambdaQueryWrapper<WorkflowTemplate>()
                .eq(WorkflowTemplate::getDeployed, 1)
                .eq(WorkflowTemplate::getStatus, 1)
                .eq(WorkflowTemplate::getDeleted, 0));

        List<Long> userRoleIds = userRoleService.getRoleIdsByUserId(userId);

        for (WorkflowTemplate template : templates) {
            if (StrUtil.isBlank(template.getAllowedRoles())) {
                return template;
            }

            List<Long> allowedRoles = JSONUtil.toList(template.getAllowedRoles(), Long.class);
            if (allowedRoles.stream().anyMatch(userRoleIds::contains)) {
                return template;
            }
        }

        return null;
    }

    /**
     * 根据ID获取模板实体
     *
     * @param id 模板ID
     * @return 模板实体
     */
    private WorkflowTemplate getEntity(Long id) {
        WorkflowTemplate entity = this.getOne(new LambdaQueryWrapper<WorkflowTemplate>()
                .eq(WorkflowTemplate::getId, id)
                .eq(WorkflowTemplate::getDeleted, 0));
        Assert.notNull(entity, "模板不存在");
        return entity;
    }

    /**
     * 构建查询条件
     *
     * @param queryParams 查询参数
     * @return 查询条件包装器
     */
    private LambdaQueryWrapper<WorkflowTemplate> getQueryWrapper(WorkflowTemplatePageQuery queryParams) {
        LambdaQueryWrapper<WorkflowTemplate> qw = new LambdaQueryWrapper<>();
        qw.eq(WorkflowTemplate::getDeleted, 0);
        qw.like(StrUtil.isNotBlank(queryParams.getName()), WorkflowTemplate::getName, queryParams.getName());
        qw.eq(queryParams.getDeployed() != null, WorkflowTemplate::getDeployed, queryParams.getDeployed());
        qw.eq(queryParams.getStatus() != null, WorkflowTemplate::getStatus, queryParams.getStatus());
        qw.orderByDesc(WorkflowTemplate::getCreateTime);
        return qw;
    }

    /**
     * 补充模板VO的关联信息
     *
     * @param vo 模板VO对象
     */
    private void enrichVO(WorkflowTemplateVO vo) {
        vo.setStatusName(vo.getStatus() == 1 ? "启用" : "禁用");

        if (vo.getDeployed() == 1 && StrUtil.isNotBlank(vo.getProcessDefinitionId())) {
            boolean suspended = flowableService.isProcessDefinitionSuspended(vo.getProcessDefinitionId());
            vo.setSuspended(suspended);
        } else {
            vo.setSuspended(false);
        }

        if (vo.getAllowedRoles() != null && StrUtil.isNotBlank(vo.getAllowedRoles().toString())) {
            try {
                List<Long> roles = JSONUtil.toList(vo.getAllowedRoles().toString(), Long.class);
                vo.setAllowedRoles(roles);
            } catch (Exception ignored) {
            }
        }
    }

    /**
     * 挂起工作流模板
     *
     * 挂起后，不允许创建新的流程实例，但不影响已启动的实例。
     *
     * @param id 模板ID
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void suspendTemplate(Long id) {
        WorkflowTemplate template = getEntity(id);
        Assert.isTrue(template.getDeployed() == 1, "未部署的模板不能挂起");

        if (StrUtil.isNotBlank(template.getProcessDefinitionId())) {
            boolean isSuspended = flowableService.isProcessDefinitionSuspended(template.getProcessDefinitionId());
            if (isSuspended) {
                throw new RuntimeException("流程已经挂起");
            }
            flowableService.suspendProcessDefinition(template.getProcessDefinitionId());
        }
    }

    /**
     * 激活工作流模板
     *
     * 激活后，可以创建新的流程实例。
     *
     * @param id 模板ID
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void activateTemplate(Long id) {
        WorkflowTemplate template = getEntity(id);
        Assert.isTrue(template.getDeployed() == 1, "未部署的模板不能激活");

        if (StrUtil.isNotBlank(template.getProcessDefinitionId())) {
            boolean isSuspended = flowableService.isProcessDefinitionSuspended(template.getProcessDefinitionId());
            if (!isSuspended) {
                throw new RuntimeException("流程已经激活");
            }
            flowableService.activateProcessDefinition(template.getProcessDefinitionId());
        }
    }

    /**
     * 检查工作流模板是否已挂起
     *
     * @param id 模板ID
     * @return 是否已挂起
     */
    @Override
    public boolean isTemplateSuspended(Long id) {
        WorkflowTemplate template = getEntity(id);
        if (template.getDeployed() != 1) {
            return false;
        }

        return flowableService.isProcessDefinitionSuspended(template.getProcessDefinitionId());
    }

    /**
     * 验证用户是否有权限发起该工作流
     *
     * @param templateId 模板ID
     * @param userId 用户ID
     * @return 是否有权限
     */
    @Override
    public boolean hasInitiatePermission(Long templateId, Long userId) {
        WorkflowTemplate template = getEntity(templateId);

        if (StrUtil.isBlank(template.getAllowedRoles())) {
            return true;
        }

        List<Long> userRoleIds = userRoleService.getRoleIdsByUserId(userId);
        List<Long> allowedRoles = JSONUtil.toList(template.getAllowedRoles(), Long.class);
        return allowedRoles.stream().anyMatch(userRoleIds::contains);
    }

    /**
     * 验证用户是否有权限发起指定类型的工作流
     *
     * @param type 模板类型
     * @param userId 用户ID
     * @return 是否有权限
     */
    @Override
    public boolean hasInitiatePermissionByType(Integer type, Long userId) {
        List<WorkflowTemplate> templates = this.list(new LambdaQueryWrapper<WorkflowTemplate>()
                .eq(WorkflowTemplate::getDeployed, 1)
                .eq(WorkflowTemplate::getStatus, 1)
                .eq(WorkflowTemplate::getDeleted, 0));

        for (WorkflowTemplate template : templates) {
            if (hasInitiatePermission(template.getId(), userId)) {
                return true;
            }
        }

        return false;
    }
}
