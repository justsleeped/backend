-- base 数据库建表脚本（系统表，sys_前缀）
-- 用户表
CREATE TABLE IF NOT EXISTS sys_user
(
    id           BIGINT PRIMARY KEY COMMENT '主键ID',
    username     VARCHAR(64)  NOT NULL UNIQUE COMMENT '学号',
    password     VARCHAR(255) NOT NULL COMMENT '密码哈希',
    real_name    VARCHAR(64) COMMENT '真实姓名',
    email        VARCHAR(128) COMMENT '邮箱',
    phone        VARCHAR(32) COMMENT '手机号',
    avatar       VARCHAR(255) COMMENT '头像URL',
    gender       TINYINT  DEFAULT 0 COMMENT '性别（0-未知，1-男，2-女）',
    birthday     DATE COMMENT '生日',
    introduction TEXT COMMENT '个人简介',
    status       TINYINT  DEFAULT 1 COMMENT '状态（0禁用，1启用）',
    create_by    BIGINT   DEFAULT 0,
    create_time  DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_by    BIGINT   DEFAULT 0,
    update_time  DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted      TINYINT  DEFAULT 0 COMMENT '逻辑删除（0未删除，1已删除）'
) COMMENT ='系统用户表';

-- 角色表
CREATE TABLE IF NOT EXISTS sys_role
(
    id          BIGINT PRIMARY KEY COMMENT '主键ID',
    code        VARCHAR(64) NOT NULL UNIQUE COMMENT '角色编码',
    name        VARCHAR(64) NOT NULL COMMENT '角色名称',
    sort        INT      DEFAULT 0 COMMENT '显示顺序',
    remark      VARCHAR(255) COMMENT '备注',
    status      INT      DEFAULT 1 COMMENT '状态（0禁用，1启用）',
    create_by   BIGINT   DEFAULT 0,
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_by   BIGINT   DEFAULT 0,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted     TINYINT  DEFAULT 0 COMMENT '逻辑删除（0未删除，1已删除）'
) COMMENT ='角色表';

-- 权限表
CREATE TABLE IF NOT EXISTS sys_permission
(
    id          BIGINT PRIMARY KEY COMMENT '主键ID',
    code        VARCHAR(64) NOT NULL UNIQUE COMMENT '权限编码',
    name        VARCHAR(64) NOT NULL COMMENT '权限名称',
    resource    VARCHAR(255) COMMENT '资源标识',
    action      VARCHAR(32) COMMENT '操作',
    type        VARCHAR(32) COMMENT '类型（API/MENU/BUTTON）',
    remark      VARCHAR(255) COMMENT '备注',
    status      INT      DEFAULT 1 COMMENT '状态（0禁用，1启用）',
    create_by   BIGINT   DEFAULT 0,
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_by   BIGINT   DEFAULT 0,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted     TINYINT  DEFAULT 0 COMMENT '逻辑删除（0未删除，1已删除）'
) COMMENT ='权限表';

-- 用户角色关联表
CREATE TABLE IF NOT EXISTS sys_user_role
(
    id          BIGINT PRIMARY KEY COMMENT '主键ID',
    user_id     BIGINT NOT NULL COMMENT '用户ID',
    role_id     BIGINT NOT NULL COMMENT '角色ID',
    create_by   BIGINT   DEFAULT 0,
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_by   BIGINT   DEFAULT 0,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted     TINYINT  DEFAULT 0 COMMENT '逻辑删除（0未删除，1已删除）'
) COMMENT ='用户角色关联表';

-- 角色权限关联表
CREATE TABLE IF NOT EXISTS sys_role_permission
(
    id            BIGINT PRIMARY KEY COMMENT '主键ID',
    role_id       BIGINT NOT NULL COMMENT '角色ID',
    permission_id BIGINT NOT NULL COMMENT '权限ID',
    create_by     BIGINT   DEFAULT 0,
    create_time   DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_by     BIGINT   DEFAULT 0,
    update_time   DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted       TINYINT  DEFAULT 0 COMMENT '逻辑删除（0未删除，1已删除）'
) COMMENT ='角色权限关联表';

-- 印章信息表
CREATE TABLE IF NOT EXISTS seal_info
(
    id               BIGINT PRIMARY KEY COMMENT '主键ID',
    code             VARCHAR(64)  NOT NULL UNIQUE COMMENT '印章编码',
    name             VARCHAR(100) NOT NULL COMMENT '印章名称',
    category         TINYINT  DEFAULT 1 COMMENT '印章分类（1-院章，2-党章）',
    description      TEXT COMMENT '印章描述',
    image_url        VARCHAR(500) COMMENT '印章图片URL',
    storage_location VARCHAR(200) COMMENT '存放位置',
    seal_type        TINYINT  DEFAULT 1 COMMENT '印章类型（1-物理章，2-电子章）',
    status           TINYINT  DEFAULT 1 COMMENT '状态（0-停用，1-启用）',
    create_by        BIGINT   DEFAULT 0,
    create_time      DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_by        BIGINT   DEFAULT 0,
    update_time      DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted          TINYINT  DEFAULT 0 COMMENT '逻辑删除（0未删除，1已删除）'
) COMMENT ='印章信息表';

-- 印章使用申请表
CREATE TABLE IF NOT EXISTS seal_apply
(
    id                     BIGINT PRIMARY KEY COMMENT '主键ID',
    apply_no               VARCHAR(64)  NOT NULL UNIQUE COMMENT '申请单号',
    applicant_id           BIGINT       NOT NULL COMMENT '申请人ID',
    applicant_name         VARCHAR(64)  COMMENT '申请人姓名',
    applicant_no           VARCHAR(64)  COMMENT '申请人学号',
    seal_id                BIGINT       NOT NULL COMMENT '申请印章ID',
    seal_name              VARCHAR(100) COMMENT '印章名称（冗余）',
    seal_category          TINYINT      COMMENT '印章分类（1-院章，2-党章）',
    seal_type              TINYINT      COMMENT '印章类型（1-物理章，2-电子章）',
    apply_reason           TEXT         NOT NULL COMMENT '申请事由',
    usage_details          TEXT         COMMENT '具体用途说明',
    apply_date             DATE         NOT NULL COMMENT '申请日期',
    expected_use_date      DATETIME     COMMENT '预计使用时间',
    urgency_level          TINYINT      DEFAULT 1 COMMENT '紧急程度（1-普通，2-紧急，3-特急）',
    process_instance_id    VARCHAR(64)  COMMENT '流程实例ID',
    process_definition_key VARCHAR(64)  COMMENT '流程定义Key',
    process_name           VARCHAR(128) COMMENT '流程名称',
    current_node_name      VARCHAR(128) COMMENT '当前节点名称',
    current_node_key       VARCHAR(64)  COMMENT '当前节点Key',
    current_approver_id    BIGINT       COMMENT '当前审批人ID',
    current_approver_name  VARCHAR(64)  COMMENT '当前审批人姓名',
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
) COMMENT = '印章使用申请表';

-- 印章审批记录表
CREATE TABLE IF NOT EXISTS seal_apply_record
(
    id                  BIGINT       PRIMARY KEY COMMENT '主键ID',
    apply_id            BIGINT       NOT NULL COMMENT '申请单ID',
    process_instance_id VARCHAR(64)  NOT NULL COMMENT '流程实例ID',
    task_id             VARCHAR(64)  NOT NULL COMMENT '任务ID',
    task_name           VARCHAR(128) NOT NULL COMMENT '任务名称',
    task_key            VARCHAR(64)  NOT NULL COMMENT '任务Key',
    approval_stage      INT          NOT NULL COMMENT '审批阶段（1-班主任，2-辅导员，3-学院院长，4-党委书记等）',
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
) COMMENT = '印章审批记录表';
