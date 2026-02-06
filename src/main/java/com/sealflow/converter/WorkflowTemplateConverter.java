package com.sealflow.converter;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.sealflow.model.entity.WorkflowTemplate;
import com.sealflow.model.form.WorkflowTemplateForm;
import com.sealflow.model.vo.WorkflowTemplateVO;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import java.util.List;

/**
 * 工作流模板转换器
 */
@Mapper(componentModel = "spring")
public interface WorkflowTemplateConverter {

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "createBy", ignore = true)
    @Mapping(target = "createTime", ignore = true)
    @Mapping(target = "updateBy", ignore = true)
    @Mapping(target = "updateTime", ignore = true)
    @Mapping(target = "deleted", ignore = true)
    @Mapping(target = "deployed", ignore = true)
    @Mapping(target = "processDefinitionId", ignore = true)
    @Mapping(target = "status", ignore = true)
    @Mapping(target = "allowedRoles", ignore = true)
    @Mapping(target = "sealCategory", ignore = true)
    WorkflowTemplate formToEntity(WorkflowTemplateForm form);

    @Mapping(target = "statusName", ignore = true)
    @Mapping(target = "allowedRoles", ignore = true)
    @Mapping(target = "suspended", ignore = true)
    WorkflowTemplateVO entityToVo(WorkflowTemplate entity);

    List<WorkflowTemplateVO> entityToVo(List<WorkflowTemplate> entities);

    default IPage<WorkflowTemplateVO> entityToVOForPage(IPage<WorkflowTemplate> page) {
		return page.convert(this::entityToVo);
    }
}
