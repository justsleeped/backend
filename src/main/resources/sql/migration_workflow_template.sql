-- 工作流模板表迁移脚本
-- 将 allowed_initiators 字段改为 allowed_roles，并移除 type 字段

-- 1. 添加 allowed_roles 字段
ALTER TABLE workflow_template ADD COLUMN allowed_roles TEXT COMMENT '允许发起的角色ID列表（JSON数组）' AFTER process_definition_id;

-- 2. 将 allowed_initiators 的数据迁移到 allowed_roles（如果有数据的话）
UPDATE workflow_template SET allowed_roles = allowed_initiators WHERE allowed_initiators IS NOT NULL;

-- 3. 删除 allowed_initiators 字段
ALTER TABLE workflow_template DROP COLUMN allowed_initiators;

-- 4. 删除 type 字段
ALTER TABLE workflow_template DROP COLUMN type;
