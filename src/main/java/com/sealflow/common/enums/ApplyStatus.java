package com.sealflow.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum ApplyStatus {
    PENDING(0, "待审批"),
    IN_PROGRESS(1, "审批中"),
    APPROVED(2, "已通过"),
    REJECTED(3, "已拒绝"),
    REVOKED(4, "已撤销");

    private final Integer code;
    private final String name;

    public static String getNameByCode(Integer code) {
        if (code == null) {
            return "";
        }
        for (ApplyStatus status : values()) {
            if (status.getCode().equals(code)) {
                return status.getName();
            }
        }
        return "";
    }

    public static ApplyStatus getByCode(Integer code) {
        if (code == null) {
            return null;
        }
        for (ApplyStatus status : values()) {
            if (status.getCode().equals(code)) {
                return status;
            }
        }
        return null;
    }
}
