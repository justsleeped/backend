-- 党章申请表
CREATE TABLE IF NOT EXISTS party_apply
(
    id                     BIGINT PRIMARY KEY COMMENT '主键ID',
    apply_no               VARCHAR(64)  NOT NULL UNIQUE COMMENT '申请单号',
    applicant_id           BIGINT       NOT NULL COMMENT '申请人ID',
    applicant_name         VARCHAR(64)  COMMENT '申请人姓名',
    applicant_no           VARCHAR(64)  COMMENT '申请人学号',
    title                  VARCHAR(256) NOT NULL COMMENT '申请标题',
    content                TEXT         COMMENT '申请内容',
    apply_type             TINYINT      DEFAULT 1 COMMENT '申请类型（1-入党申请，2-转正申请，3-其他）',
    urgency_level          TINYINT      DEFAULT 1 COMMENT '紧急程度（1-普通，2-紧急，3-特急）',
    process_instance_id    VARCHAR(64)  COMMENT '流程实例ID',
    process_definition_key VARCHAR(64)  COMMENT '流程定义Key',
    process_name           VARCHAR(128) COMMENT '流程名称',
    current_node_name      VARCHAR(128) COMMENT '当前节点名称',
    current_node_key       VARCHAR(64)  COMMENT '当前节点Key',
    status                 TINYINT      DEFAULT 0 COMMENT '状态（0-待审批，1-审批中，2-已通过，3-已拒绝，4-已撤销）',
    reject_reason          TEXT         COMMENT '拒绝原因',
    apply_time             DATETIME     DEFAULT CURRENT_TIMESTAMP COMMENT '申请时间',
    finish_time            DATETIME     COMMENT '完成时间',
    attachment_url         VARCHAR(500) COMMENT '附件URL',
    create_by              BIGINT       DEFAULT 0,
    create_time            DATETIME     DEFAULT CURRENT_TIMESTAMP,
    update_by              BIGINT       DEFAULT 0,
    update_time            DATETIME     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted                TINYINT      DEFAULT 0 COMMENT '逻辑删除（0未删除，1已删除）'
) COMMENT = '党章申请表';

-- 党章审批记录表
CREATE TABLE IF NOT EXISTS party_approval_record
(
    id                  BIGINT PRIMARY KEY COMMENT '主键ID',
    apply_id            BIGINT       NOT NULL COMMENT '申请单ID',
    process_instance_id VARCHAR(64)  NOT NULL COMMENT '流程实例ID',
    task_id             VARCHAR(64)  NOT NULL COMMENT '任务ID',
    task_name           VARCHAR(128) NOT NULL COMMENT '任务名称',
    task_key            VARCHAR(64)  NOT NULL COMMENT '任务Key',
    approval_stage      INT          NOT NULL COMMENT '审批阶段（1-班主任，2-辅导员，3-学院院长，4-党委书记）',
    approver_id         BIGINT       NOT NULL COMMENT '审批人ID',
    approver_name       VARCHAR(64)  COMMENT '审批人姓名',
    approver_role_code  VARCHAR(64)  COMMENT '审批人角色编码',
    approver_role_name  VARCHAR(64)  COMMENT '审批人角色名称',
    approve_result      TINYINT      COMMENT '审批结果（1-同意，2-拒绝）',
    approve_comment     TEXT         COMMENT '审批意见',
    approve_time        DATETIME     COMMENT '审批时间',
    task_start_time     DATETIME     COMMENT '任务开始时间',
    task_end_time       DATETIME     COMMENT '任务结束时间',
    create_by           BIGINT       DEFAULT 0,
    create_time         DATETIME     DEFAULT CURRENT_TIMESTAMP,
    update_by           BIGINT       DEFAULT 0,
    update_time         DATETIME     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted             TINYINT      DEFAULT 0 COMMENT '逻辑删除（0未删除，1已删除）'
) COMMENT = '党章审批记录表';

-- 创建索引
CREATE INDEX idx_party_apply_applicant_id ON party_apply(applicant_id);
CREATE INDEX idx_party_apply_process_instance_id ON party_apply(process_instance_id);
CREATE INDEX idx_party_apply_status ON party_apply(status);
CREATE INDEX idx_party_apply_apply_time ON party_apply(apply_time);

CREATE INDEX idx_party_approval_record_apply_id ON party_approval_record(apply_id);
CREATE INDEX idx_party_approval_record_process_instance_id ON party_approval_record(process_instance_id);
CREATE INDEX idx_party_approval_record_task_id ON party_approval_record(task_id);
CREATE INDEX idx_party_approval_record_approver_id ON party_approval_record(approver_id);
CREATE INDEX idx_party_approval_record_approval_stage ON party_approval_record(approval_stage);
