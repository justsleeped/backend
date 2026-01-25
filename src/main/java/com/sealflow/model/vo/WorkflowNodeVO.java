package com.sealflow.model.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "工作流节点视图对象")
public class WorkflowNodeVO {

    @Schema(description = "节点ID")
    private String id;

    @Schema(description = "节点类型（start-开始节点，approve-审批节点，end-结束节点）")
    private String type;

    @Schema(description = "节点名称")
    private String nodeName;

    @Schema(description = "节点状态（0-未执行，1-进行中，2-已完成，3-拒绝/中止）")
    private Integer status;

    @Schema(description = "审批人姓名")
    private String approverName;

    @Schema(description = "审批意见")
    private String comment;

    @Schema(description = "审批时间")
    private LocalDateTime finishTime;

    @Schema(description = "审批角色")
    private String roleName;

    @Schema(description = "审批结果（1-通过，0-拒绝）")
    private Integer approveResult;
}
