package com.sealflow.model.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Data
@Schema(description = "区块链存证验证结果")
public class BlockchainVerifyResultVO {

    @Schema(description = "存证ID")
    private Long evidenceId;

    @Schema(description = "存证编号")
    private String evidenceNo;

    @Schema(description = "存证完整性是否有效")
    private Boolean isValid;

    @Schema(description = "数据是否一致")
    private Boolean isDataConsistent;

    @Schema(description = "验证状态")
    private String verifyStatus;

    @Schema(description = "验证消息")
    private String message;
}
