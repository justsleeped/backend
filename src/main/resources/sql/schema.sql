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
    category         VARCHAR(100)       NOT NULL COMMENT '所属分类',
    description      TEXT COMMENT '印章描述',
    image_url        VARCHAR(500) COMMENT '印章图片URL',
    storage_location VARCHAR(200) COMMENT '存放位置',
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
    id                BIGINT PRIMARY KEY COMMENT '主键ID',
    apply_no          VARCHAR(64) NOT NULL UNIQUE COMMENT '申请单号',
    applicant_id      BIGINT      NOT NULL COMMENT '申请人ID',
    seal_id           BIGINT      NOT NULL COMMENT '申请印章ID',
    apply_reason      TEXT        NOT NULL COMMENT '申请事由',
    usage_type        VARCHAR(32) NOT NULL COMMENT '用途类型（合同专用章、公章、财务章等）',
    usage_details     TEXT COMMENT '具体用途说明',
    apply_date        DATE        NOT NULL COMMENT '申请日期',
    expected_use_date DATETIME COMMENT '预计使用时间',
    urgency_level     TINYINT  DEFAULT 1 COMMENT '紧急程度（1普通，2紧急，3特急）',
    status            TINYINT  DEFAULT 0 COMMENT '状态（0待审批，1审批中，2已批准，3已拒绝，4已完成，5已取消）',
    approve_remark    TEXT COMMENT '审批意见',
    create_by         BIGINT   DEFAULT 0,
    create_time       DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_by         BIGINT   DEFAULT 0,
    update_time       DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted           TINYINT  DEFAULT 0 COMMENT '逻辑删除（0未删除，1已删除）'
) COMMENT ='印章使用申请表';

-- 印章审批流程表
CREATE TABLE IF NOT EXISTS seal_approval_process
(
    id             BIGINT PRIMARY KEY COMMENT '主键ID',
    apply_id       BIGINT NOT NULL COMMENT '申请单ID',
    approval_stage INT    NOT NULL COMMENT '审批阶段（1、2、3...）',
    approver_id    BIGINT NOT NULL COMMENT '审批人ID',
    approve_status TINYINT  DEFAULT 0 COMMENT '审批状态（0待审批，1已通过，2已拒绝）',
    approve_time   DATETIME COMMENT '审批时间',
    approve_remark TEXT COMMENT '审批意见',
    create_by      BIGINT   DEFAULT 0,
    create_time    DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_by      BIGINT   DEFAULT 0,
    update_time    DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted        TINYINT  DEFAULT 0 COMMENT '逻辑删除（0未删除，1已删除）'
) COMMENT ='印章审批流程表';

-- 印章使用记录表
CREATE TABLE IF NOT EXISTS seal_usage_record
(
    id               BIGINT PRIMARY KEY COMMENT '主键ID',
    apply_id         BIGINT   NOT NULL COMMENT '申请单ID',
    seal_id          BIGINT   NOT NULL COMMENT '印章ID',
    usage_user_id    BIGINT   NOT NULL COMMENT '使用人ID',
    usage_date       DATETIME NOT NULL COMMENT '使用时间',
    usage_purpose    TEXT COMMENT '使用目的',
    document_count   INT      DEFAULT 1 COMMENT '用印文件数量',
    actual_seal_area TEXT COMMENT '实际盖印区域',
    operator_id      BIGINT   NOT NULL COMMENT '操作员ID',
    attachments      TEXT COMMENT '附件（用印前后照片、文件扫描件等）',
    create_by        BIGINT   DEFAULT 0,
    create_time      DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_by        BIGINT   DEFAULT 0,
    update_time      DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted          TINYINT  DEFAULT 0 COMMENT '逻辑删除（0未删除，1已删除）'
) COMMENT ='印章使用记录表';

-- 印章借用归还表
CREATE TABLE IF NOT EXISTS seal_borrow_return
(
    id                   BIGINT PRIMARY KEY COMMENT '主键ID',
    apply_id             BIGINT   NOT NULL COMMENT '申请单ID',
    seal_id              BIGINT   NOT NULL COMMENT '印章ID',
    borrower_id          BIGINT   NOT NULL COMMENT '借用人ID',
    borrow_date          DATETIME NOT NULL COMMENT '借用时间',
    expected_return_date DATETIME NOT NULL COMMENT '预计归还时间',
    actual_return_date   DATETIME COMMENT '实际归还时间',
    borrow_reason        TEXT COMMENT '借用原因',
    custodian_remark     TEXT COMMENT '保管人备注',
    status               TINYINT  DEFAULT 0 COMMENT '状态（0借用中，1已归还，2逾期）',
    create_by            BIGINT   DEFAULT 0,
    create_time          DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_by            BIGINT   DEFAULT 0,
    update_time          DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted              TINYINT  DEFAULT 0 COMMENT '逻辑删除（0未删除，1已删除）'
) COMMENT ='印章借用归还表';
