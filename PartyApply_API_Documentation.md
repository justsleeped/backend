# 党章申请系统后端接口文档

## 接口基础信息
- 基础路径：`/api/v1/partyApply`
- 请求方式：RESTful风格
- 内容类型：`application/json`
- 字符编码：UTF-8
- 认证方式：JWT Token

## 通用返回格式

### 成功响应格式
```json
{
  "status": 200,
  "statusText": "OK",
  "data": {}
}
```

### 分页响应格式
```json
{
  "status": 200,
  "statusText": "OK",
  "data": {
    "list": [],
    "total": 0
  }
}
```

### 错误响应格式
```json
{
  "status": 400,
  "statusText": "Bad Request",
  "data": null
}
```

## 数据字典

### 申请类型
- 1: 入党申请
- 2: 转正申请  
- 3: 其他

### 紧急程度
- 1: 普通
- 2: 紧急
- 3: 特急

### 状态
- 0: 待审批
- 1: 审批中
- 2: 已通过
- 3: 已拒绝
- 4: 已撤销

### 审批结果
- 1: 同意
- 2: 拒绝

### 审批阶段
- 1: 班主任
- 2: 辅导员
- 3: 学院院长
- 4: 党委书记

---

## 1. 新增党章申请

### 接口描述
提交一个新的党章申请

### 请求信息
- **请求路径**: `POST /api/v1/partyApply/add`
- **认证要求**: 是
- **请求体**: [PartyApplyForm](#partyapplyform)

### 请求参数
#### PartyApplyForm
| 参数名 | 类型 | 必填 | 示例值 | 描述 |
|--------|------|------|--------|------|
| title | String | 是 | "入党申请书" | 申请标题 |
| content | String | 是 | "我志愿加入中国共产党..." | 申请内容 |
| applyType | Integer | 是 | 1 | 申请类型：1-入党申请，2-转正申请，3-其他 |
| urgencyLevel | Integer | 是 | 1 | 紧急程度：1-普通，2-紧急，3-特急 |
| attachmentUrl | String | 否 | "https://example.com/file.pdf" | 附件URL |

### 请求示例
```json
{
  "title": "入党申请书",
  "content": "我志愿加入中国共产党...",
  "applyType": 1,
  "urgencyLevel": 1,
  "attachmentUrl": "https://example.com/file.pdf"
}
```

### 响应参数
| 参数名 | 类型 | 描述 |
|--------|------|------|
| status | Integer | 状态码 |
| statusText | String | 状态文本 |
| data | Long | 新增申请的ID |

### 响应示例
```json
{
  "status": 200,
  "statusText": "OK",
  "data": 1
}
```

---

## 2. 修改党章申请

### 接口描述
修改已存在的党章申请信息

### 请求信息
- **请求路径**: `PUT /api/v1/partyApply/{id}/update`
- **认证要求**: 是
- **路径参数**: id (申请单ID)
- **请求体**: [PartyApplyForm](#partyapplyform)

### 请求参数
#### 路径参数
| 参数名 | 类型 | 必填 | 示例值 | 描述 |
|--------|------|------|--------|------|
| id | Long | 是 | 1 | 申请单ID |

#### 请求体
同[新增党章申请](#请求参数-1)

### 请求示例
```json
{
  "title": "更新后的入党申请书",
  "content": "我志愿加入中国共产党，拥护党的纲领...",
  "applyType": 1,
  "urgencyLevel": 2,
  "attachmentUrl": "https://example.com/updated-file.pdf"
}
```

### 响应参数
| 参数名 | 类型 | 描述 |
|--------|------|------|
| status | Integer | 状态码 |
| statusText | String | 状态文本 |
| data | Boolean | 是否修改成功 |

### 响应示例
```json
{
  "status": 200,
  "statusText": "OK",
  "data": true
}
```

---

## 3. 删除党章申请

### 接口描述
删除指定的党章申请（支持批量删除）

### 请求信息
- **请求路径**: `DELETE /api/v1/partyApply/{ids}/delete`
- **认证要求**: 是
- **路径参数**: ids (需要删除的ID列表，逗号分隔)

### 请求参数
#### 路径参数
| 参数名 | 类型 | 必填 | 示例值 | 描述 |
|--------|------|------|--------|------|
| ids | String | 是 | "1,2,3" | 需要删除的ID列表，多个ID以逗号分隔 |

### 响应参数
| 参数名 | 类型 | 描述 |
|--------|------|------|
| status | Integer | 状态码 |
| statusText | String | 状态文本 |
| data | Boolean | 是否删除成功 |

### 响应示例
```json
{
  "status": 200,
  "statusText": "OK",
  "data": true
}
```

---

## 4. 获取党章申请详情

### 接口描述
根据ID获取党章申请的详细信息

### 请求信息
- **请求路径**: `GET /api/v1/partyApply/{id}/form`
- **认证要求**: 是
- **路径参数**: id (申请单ID)

### 请求参数
#### 路径参数
| 参数名 | 类型 | 必填 | 示例值 | 描述 |
|--------|------|------|--------|------|
| id | Long | 是 | 1 | 申请单ID |

### 响应参数
| 参数名 | 类型 | 描述 |
|--------|------|------|
| status | Integer | 状态码 |
| statusText | String | 状态文本 |
| data | [PartyApplyVO](#partyapplyvo) | 申请详情 |

#### PartyApplyVO
| 参数名 | 类型 | 描述 |
|--------|------|------|
| id | Long | 申请单ID |
| applyNo | String | 申请单号 |
| applicantId | Long | 申请人ID |
| applicantName | String | 申请人姓名 |
| applicantNo | String | 申请人学号 |
| title | String | 申请标题 |
| content | String | 申请内容 |
| applyType | Integer | 申请类型 |
| applyTypeName | String | 申请类型名称 |
| urgencyLevel | Integer | 紧急程度 |
| urgencyLevelName | String | 紧急程度名称 |
| processInstanceId | String | 流程实例ID |
| processName | String | 流程名称 |
| currentNodeName | String | 当前节点名称 |
| currentNodeKey | String | 当前节点Key |
| status | Integer | 状态 |
| statusName | String | 状态名称 |
| rejectReason | String | 拒绝原因 |
| applyTime | String | 申请时间，格式：yyyy-MM-dd HH:mm:ss |
| finishTime | String | 完成时间，格式：yyyy-MM-dd HH:mm:ss |
| attachmentUrl | String | 附件URL |
| approvalRecords | [PartyApprovalRecordVO](#partyapprovalrecordvo)[] | 审批记录列表 |
| currentTaskId | String | 当前任务ID |
| canApprove | Boolean | 是否可以审批 |

#### PartyApprovalRecordVO
| 参数名 | 类型 | 描述 |
|--------|------|------|
| id | Long | 审批记录ID |
| applyId | Long | 申请单ID |
| taskId | String | 任务ID |
| taskName | String | 任务名称 |
| taskKey | String | 任务Key |
| approvalStage | Integer | 审批阶段 |
| approvalStageName | String | 审批阶段名称 |
| approverId | Long | 审批人ID |
| approverName | String | 审批人姓名 |
| approverRoleCode | String | 审批人角色编码 |
| approverRoleName | String | 审批人角色名称 |
| approveResult | Integer | 审批结果 |
| approveResultName | String | 审批结果名称 |
| approveComment | String | 审批意见 |
| approveTime | String | 审批时间，格式：yyyy-MM-dd HH:mm:ss |
| taskStartTime | String | 任务开始时间，格式：yyyy-MM-dd HH:mm:ss |
| taskEndTime | String | 任务结束时间，格式：yyyy-MM-dd HH:mm:ss |

### 响应示例
```json
{
  "status": 200,
  "statusText": "OK",
  "data": {
    "id": 1,
    "applyNo": "PA202401010001",
    "applicantId": 1001,
    "applicantName": "张三",
    "applicantNo": "20210001",
    "title": "入党申请书",
    "content": "我志愿加入中国共产党...",
    "applyType": 1,
    "applyTypeName": "入党申请",
    "urgencyLevel": 1,
    "urgencyLevelName": "普通",
    "processInstanceId": "proc_12345",
    "processName": "党章申请流程",
    "currentNodeName": "班主任审批",
    "currentNodeKey": "headTeacherApproval",
    "status": 1,
    "statusName": "审批中",
    "rejectReason": null,
    "applyTime": "2024-01-01 10:00:00",
    "finishTime": null,
    "attachmentUrl": "https://example.com/file.pdf",
    "approvalRecords": [
      {
        "id": 1,
        "applyId": 1,
        "taskId": "task_123",
        "taskName": "提交申请",
        "taskKey": "applyTask",
        "approvalStage": 0,
        "approvalStageName": "申请人提交",
        "approverId": 1001,
        "approverName": "张三",
        "approverRoleCode": "APPLICANT",
        "approverRoleName": "申请人",
        "approveResult": 1,
        "approveResultName": "同意",
        "approveComment": "提交申请",
        "approveTime": "2024-01-01 10:00:00",
        "taskStartTime": "2024-01-01 10:00:00",
        "taskEndTime": "2024-01-01 10:00:00"
      }
    ],
    "currentTaskId": "task_456",
    "canApprove": true
  }
}
```

---

## 5. 分页查询党章申请

### 接口描述
分页查询党章申请列表

### 请求信息
- **请求路径**: `POST /api/v1/partyApply/page`
- **认证要求**: 是
- **请求体**: [PartyApplyPageQuery](#partyapplypagequery)

### 请求参数
#### PartyApplyPageQuery
| 参数名 | 类型 | 必填 | 示例值 | 描述 |
|--------|------|------|--------|------|
| pageNum | Integer | 否 | 1 | 页码，默认为1 |
| pageSize | Integer | 否 | 10 | 每页记录数，默认为10 |
| applyNo | String | 否 | "PA202401010001" | 申请单号 |
| applicantId | Long | 否 | 1001 | 申请人ID |
| applicantName | String | 否 | "张三" | 申请人姓名 |
| applicantNo | String | 否 | "20210001" | 申请人学号 |
| title | String | 否 | "入党申请书" | 申请标题 |
| applyType | Integer | 否 | 1 | 申请类型 |
| urgencyLevel | Integer | 否 | 1 | 紧急程度 |
| status | Integer | 否 | 1 | 状态 |
| queryType | Integer | 否 | 3 | 查询类型：1-我发起的，2-我审批的，3-全部 |
| processInstanceId | String | 否 | "proc_12345" | 流程实例ID |

### 请求示例
```json
{
  "pageNum": 1,
  "pageSize": 10,
  "title": "入党申请",
  "status": 1,
  "applyType": 1
}
```

### 响应参数
| 参数名 | 类型 | 描述 |
|--------|------|------|
| status | Integer | 状态码 |
| statusText | String | 状态文本 |
| data | Object | 分页数据对象 |
| data.list | [PartyApplyVO](#partyapplyvo)[] | 申请列表 |
| data.total | Long | 总记录数 |

### 响应示例
```json
{
  "status": 200,
  "statusText": "OK",
  "data": {
    "list": [
      {
        "id": 1,
        "applyNo": "PA202401010001",
        "applicantId": 1001,
        "applicantName": "张三",
        "applicantNo": "20210001",
        "title": "入党申请书",
        "content": "我志愿加入中国共产党...",
        "applyType": 1,
        "applyTypeName": "入党申请",
        "urgencyLevel": 1,
        "urgencyLevelName": "普通",
        "processInstanceId": "proc_12345",
        "processName": "党章申请流程",
        "currentNodeName": "班主任审批",
        "currentNodeKey": "headTeacherApproval",
        "status": 1,
        "statusName": "审批中",
        "rejectReason": null,
        "applyTime": "2024-01-01 10:00:00",
        "finishTime": null,
        "attachmentUrl": "https://example.com/file.pdf",
        "approvalRecords": [
          {
            "id": 1,
            "applyId": 1,
            "taskId": "task_123",
            "taskName": "提交申请",
            "taskKey": "applyTask",
            "approvalStage": 0,
            "approvalStageName": "申请人提交",
            "approverId": 1001,
            "approverName": "张三",
            "approverRoleCode": "APPLICANT",
            "approverRoleName": "申请人",
            "approveResult": 1,
            "approveResultName": "同意",
            "approveComment": "提交申请",
            "approveTime": "2024-01-01 10:00:00",
            "taskStartTime": "2024-01-01 10:00:00",
            "taskEndTime": "2024-01-01 10:00:00"
          }
        ],
        "currentTaskId": "task_456",
        "canApprove": true
      }
    ],
    "total": 1
  }
}
```

---

## 6. 发起流程

### 接口描述
为指定的党章申请发起审批流程

### 请求信息
- **请求路径**: `POST /api/v1/partyApply/{id}/startProcess`
- **认证要求**: 是
- **路径参数**: id (申请单ID)

### 请求参数
#### 路径参数
| 参数名 | 类型 | 必填 | 示例值 | 描述 |
|--------|------|------|--------|------|
| id | Long | 是 | 1 | 申请单ID |

### 响应参数
| 参数名 | 类型 | 描述 |
|--------|------|------|
| status | Integer | 状态码 |
| statusText | String | 状态文本 |
| data | Boolean | 是否发起成功 |

### 响应示例
```json
{
  "status": 200,
  "statusText": "OK",
  "data": true
}
```

---

## 7. 审批任务

### 接口描述
对指定的任务进行审批操作

### 请求信息
- **请求路径**: `POST /api/v1/partyApply/approve`
- **认证要求**: 是
- **请求体**: [PartyApprovalForm](#partyapprovalform)

### 请求参数
#### PartyApprovalForm
| 参数名 | 类型 | 必填 | 示例值 | 描述 |
|--------|------|------|--------|------|
| taskId | String | 是 | "task_123" | 任务ID |
| applyId | Long | 是 | 1 | 申请单ID |
| approveResult | Integer | 是 | 1 | 审批结果：1-同意，2-拒绝 |
| approveComment | String | 否 | "同意申请" | 审批意见 |

### 请求示例
```json
{
  "taskId": "task_123",
  "applyId": 1,
  "approveResult": 1,
  "approveComment": "同意申请"
}
```

### 响应参数
| 参数名 | 类型 | 描述 |
|--------|------|------|
| status | Integer | 状态码 |
| statusText | String | 状态文本 |
| data | Boolean | 是否审批成功 |

### 响应示例
```json
{
  "status": 200,
  "statusText": "OK",
  "data": true
}
```

---

## 8. 撤销流程

### 接口描述
撤销指定的党章申请流程

### 请求信息
- **请求路径**: `POST /api/v1/partyApply/{id}/revoke`
- **认证要求**: 是
- **路径参数**: id (申请单ID)

### 请求参数
#### 路径参数
| 参数名 | 类型 | 必填 | 示例值 | 描述 |
|--------|------|------|--------|------|
| id | Long | 是 | 1 | 申请单ID |

### 响应参数
| 参数名 | 类型 | 描述 |
|--------|------|------|
| status | Integer | 状态码 |
| statusText | String | 状态文本 |
| data | Boolean | 是否撤销成功 |

### 响应示例
```json
{
  "status": 200,
  "statusText": "OK",
  "data": true
}
```

---

## 9. 我发起的申请

### 接口描述
分页查询当前用户发起的党章申请

### 请求信息
- **请求路径**: `POST /api/v1/partyApply/myStarted`
- **认证要求**: 是
- **请求体**: [PartyApplyPageQuery](#partyapplypagequery)

### 请求参数
同[分页查询党章申请](#请求参数-4)的参数，但查询范围限定为当前用户发起的申请

### 响应参数
| 参数名 | 类型 | 描述 |
|--------|------|------|
| status | Integer | 状态码 |
| statusText | String | 状态文本 |
| data | Object | 分页数据对象 |
| data.list | [PartyApplyVO](#partyapplyvo)[] | 申请列表 |
| data.total | Long | 总记录数 |

### 响应示例
```json
{
  "status": 200,
  "statusText": "OK",
  "data": {
    "list": [...],
    "total": 1
  }
}
```

---

## 10. 我审批的申请

### 接口描述
分页查询当前用户审批过的党章申请

### 请求信息
- **请求路径**: `POST /api/v1/partyApply/myApproved`
- **认证要求**: 是
- **请求体**: [PartyApplyPageQuery](#partyapplypagequery)

### 请求参数
同[分页查询党章申请](#请求参数-4)的参数，但查询范围限定为当前用户审批过的申请

### 响应参数
| 参数名 | 类型 | 描述 |
|--------|------|------|
| status | Integer | 状态码 |
| statusText | String | 状态文本 |
| data | Object | 分页数据对象 |
| data.list | [PartyApplyVO](#partyapplyvo)[] | 申请列表 |
| data.total | Long | 总记录数 |

### 响应示例
```json
{
  "status": 200,
  "statusText": "OK",
  "data": {
    "list": [...],
    "total": 1
  }
}
```

---

## 11. 我的待办任务

### 接口描述
分页查询当前用户的待办审批任务

### 请求信息
- **请求路径**: `POST /api/v1/partyApply/todoTasks`
- **认证要求**: 是
- **请求体**: [PartyApplyPageQuery](#partyapplypagequery)

### 请求参数
同[分页查询党章申请](#请求参数-4)的参数，但查询范围限定为当前用户的待办任务

### 响应参数
| 参数名 | 类型 | 描述 |
|--------|------|------|
| status | Integer | 状态码 |
| statusText | String | 状态文本 |
| data | Object | 分页数据对象 |
| data.list | [PartyApplyVO](#partyapplyvo)[] | 申请列表 |
| data.total | Long | 总记录数 |

### 响应示例
```json
{
  "status": 200,
  "statusText": "OK",
  "data": {
    "list": [...],
    "total": 1
  }
}
```

---

## 12. 流程详情

### 接口描述
根据流程实例ID获取流程详情

### 请求信息
- **请求路径**: `GET /api/v1/partyApply/processDetail/{processInstanceId}`
- **认证要求**: 是
- **路径参数**: processInstanceId (流程实例ID)

### 请求参数
#### 路径参数
| 参数名 | 类型 | 必填 | 示例值 | 描述 |
|--------|------|------|--------|------|
| processInstanceId | String | 是 | "proc_12345" | 流程实例ID |

### 响应参数
| 参数名 | 类型 | 描述 |
|--------|------|------|
| status | Integer | 状态码 |
| statusText | String | 状态文本 |
| data | [PartyApplyVO](#partyapplyvo) | 流程详情 |

### 响应示例
```json
{
  "status": 200,
  "statusText": "OK",
  "data": {
    "id": 1,
    "applyNo": "PA202401010001",
    "applicantId": 1001,
    "applicantName": "张三",
    "applicantNo": "20210001",
    "title": "入党申请书",
    "content": "我志愿加入中国共产党...",
    "applyType": 1,
    "applyTypeName": "入党申请",
    "urgencyLevel": 1,
    "urgencyLevelName": "普通",
    "processInstanceId": "proc_12345",
    "processName": "党章申请流程",
    "currentNodeName": "班主任审批",
    "currentNodeKey": "headTeacherApproval",
    "status": 1,
    "statusName": "审批中",
    "rejectReason": null,
    "applyTime": "2024-01-01 10:00:00",
    "finishTime": null,
    "attachmentUrl": "https://example.com/file.pdf",
    "approvalRecords": [...],
    "currentTaskId": "task_456",
    "canApprove": true
  }
}
```