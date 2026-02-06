package com.sealflow.model.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.sealflow.model.base.BaseEntity;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.time.LocalDateTime;

@EqualsAndHashCode(callSuper = true)
@Data
@TableName("blockchain_evidence")
@Schema(description = "区块链存证表")
public class BlockchainEvidence extends BaseEntity<Long> {

    @Schema(description = "存证编号")
    private String evidenceNo;

    @Schema(description = "业务类型（APPLY-申请，APPROVE-审批，STAMP-盖章）")
    private String businessType;

    @Schema(description = "业务ID（申请ID、审批记录ID等）")
    private Long businessId;

    @Schema(description = "业务数据JSON")
    private String businessData;

    @Schema(description = "数据哈希值（SHA-256）")
    private String dataHash;

    @Schema(description = "区块高度")
    private Long blockHeight;

    @Schema(description = "区块哈希值")
    private String blockHash;

    @Schema(description = "交易哈希值")
    private String transactionHash;

    @Schema(description = "上一区块哈希值")
    private String previousHash;

    @Schema(description = "存证时间戳")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime timestamp;

    @Schema(description = "操作人ID")
    private Long operatorId;

    @Schema(description = "操作人姓名")
    private String operatorName;

    @Schema(description = "状态（0-失效，1-有效）")
    private Integer status;

    @Schema(description = "验证状态（0-未验证，1-验证通过，2-验证失败）")
    private Integer verifyStatus;

    @Schema(description = "验证时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime verifyTime;
}
