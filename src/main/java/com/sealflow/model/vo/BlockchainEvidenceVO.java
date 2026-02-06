package com.sealflow.model.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Schema(description = "区块链存证视图对象")
public class BlockchainEvidenceVO {

    @Schema(description = "存证ID")
    private Long id;

    @Schema(description = "存证编号")
    private String evidenceNo;

    @Schema(description = "业务类型")
    private String businessType;

    @Schema(description = "业务类型名称")
    private String businessTypeName;

    @Schema(description = "业务ID")
    private Long businessId;

    @Schema(description = "数据哈希值")
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

    @Schema(description = "操作人姓名")
    private String operatorName;

    @Schema(description = "状态")
    private Integer status;

    @Schema(description = "状态名称")
    private String statusName;

    @Schema(description = "验证状态")
    private Integer verifyStatus;

    @Schema(description = "验证状态名称")
    private String verifyStatusName;

    @Schema(description = "验证时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime verifyTime;

    @Schema(description = "创建时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createTime;
}
