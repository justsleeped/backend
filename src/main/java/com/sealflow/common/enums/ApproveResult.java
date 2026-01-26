package com.sealflow.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum ApproveResult {
    APPROVE(1, "同意"),
    REJECT(2, "拒绝");

    private final Integer code;
    private final String name;

    public static String getNameByCode(Integer code) {
        if (code == null) {
            return "";
        }
        for (ApproveResult result : values()) {
            if (result.getCode().equals(code)) {
                return result.getName();
            }
        }
        return "";
    }

    public static ApproveResult getByCode(Integer code) {
        if (code == null) {
            return null;
        }
        for (ApproveResult result : values()) {
            if (result.getCode().equals(code)) {
                return result;
            }
        }
        return null;
    }
}
