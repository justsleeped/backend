package com.sealflow.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum SealType {
    PHYSICAL(1, "物理章"),
    ELECTRONIC(2, "电子章");

    private final Integer code;
    private final String name;

    public static String getNameByCode(Integer code) {
        if (code == null) {
            return "";
        }
        for (SealType type : values()) {
            if (type.getCode().equals(code)) {
                return type.getName();
            }
        }
        return "";
    }

    public static SealType getByCode(Integer code) {
        if (code == null) {
            return null;
        }
        for (SealType type : values()) {
            if (type.getCode().equals(code)) {
                return type;
            }
        }
        return null;
    }
}
