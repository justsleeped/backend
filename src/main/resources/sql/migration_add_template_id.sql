-- 添加流程模板ID字段到印章申请表
ALTER TABLE seal_apply ADD COLUMN template_id BIGINT COMMENT '流程模板ID' AFTER urgency_level;
