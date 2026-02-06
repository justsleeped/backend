package com.sealflow.model.enums;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;

@Getter
@Schema(description = "区块链存证业务类型枚举")
public enum BusinessType {

    @Schema(description = "申请")
    APPLY("APPLY", "申请"),

    @Schema(description = "审批")
    APPROVE("APPROVE", "审批"),

    @Schema(description = "盖章")
    STAMP("STAMP", "盖章");

    private final String code;
    private final String name;

    BusinessType(String code, String name) {
        this.code = code;
        this.name = name;
    }

    public static BusinessType getByCode(String code) {
        for (BusinessType type : values()) {
            if (type.getCode().equals(code)) {
                return type;
            }
        }
        return null;
    }
}
