package com.sealflow.model.query;

import com.sealflow.model.base.BasePageQuery;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = true)
@Data
@Schema(description = "查询印章使用申请对象")
public class SealApplyPageQuery extends BasePageQuery {

    @Schema(description = "申请单号")
    private String applyNo;

    @Schema(description = "申请人ID")
    private Long applicantId;

    @Schema(description = "申请人姓名")
    private String applicantName;

    @Schema(description = "申请人学号")
    private String applicantNo;

    @Schema(description = "印章ID")
    private Long sealId;

    @Schema(description = "印章名称")
    private String sealName;

    @Schema(description = "印章分类（1-院章，2-党章）")
    private Integer sealCategory;

    @Schema(description = "印章类型（1-物理章，2-电子章）")
    private Integer sealType;

    @Schema(description = "紧急程度（1-普通，2-紧急，3-特急）")
    private Integer urgencyLevel;

    @Schema(description = "状态（0-待审批，1-审批中，2-已通过，3-已拒绝，4-已撤销）")
    private Integer status;

    @Schema(description = "查询类型（1-我发起的，2-我审批的，3-全部）")
    private Integer queryType;

    @Schema(description = "流程实例ID")
    private String processInstanceId;
}
