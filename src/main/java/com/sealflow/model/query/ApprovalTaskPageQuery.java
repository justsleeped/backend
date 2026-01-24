package com.sealflow.model.query;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

/**
 * 审批任务查询参数
 */
@Data
@Schema(description = "审批任务查询参数")
public class ApprovalTaskPageQuery {

    @Schema(description = "页码", example = "1")
    private Integer pageNum = 1;

    @Schema(description = "每页大小", example = "10")
    private Integer pageSize = 10;

    @Schema(description = "任务名称（模糊查询）")
    private String taskName;

    @Schema(description = "流程名称（模糊查询）")
    private String processName;

    @Schema(description = "申请人ID")
    private Long applicantId;

    @Schema(description = "申请人姓名（模糊查询）")
    private String applicantName;

    @Schema(description = "申请编号（模糊查询）")
    private String applyNo;

    @Schema(description = "印章类别（1-院章，2-党章）")
    private Integer sealCategory;

    @Schema(description = "申请状态（0-待审批，1-审批中，2-已通过，3-已拒绝，4-已撤销）")
    private Integer status;

    @Schema(description = "任务定义Key")
    private String taskDefinitionKey;

    @Schema(description = "开始时间（格式：yyyy-MM-dd HH:mm:ss）")
    private String startTime;

    @Schema(description = "结束时间（格式：yyyy-MM-dd HH:mm:ss）")
    private String endTime;
}
