package com.sealflow.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.sealflow.model.entity.WorkflowTemplate;
import org.apache.ibatis.annotations.Mapper;

/**
 * 工作流模板Mapper
 */
@Mapper
public interface WorkflowTemplateMapper extends BaseMapper<WorkflowTemplate> {
}
