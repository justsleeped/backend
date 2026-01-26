package com.sealflow.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum UrgencyLevel {
    NORMAL(1, "普通"),
    URGENT(2, "紧急"),
    VERY_URGENT(3, "特急");

    private final Integer code;
    private final String name;

    public static String getNameByCode(Integer code) {
        if (code == null) {
            return "";
        }
        for (UrgencyLevel level : values()) {
            if (level.getCode().equals(code)) {
                return level.getName();
            }
        }
        return "";
    }

    public static UrgencyLevel getByCode(Integer code) {
        if (code == null) {
            return null;
        }
        for (UrgencyLevel level : values()) {
            if (level.getCode().equals(code)) {
                return level;
            }
        }
        return null;
    }
}
