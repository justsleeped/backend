package com.sealflow.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum SealCategory {
    COLLEGE_SEAL(1, "院章"),
    PARTY_SEAL(2, "党章");

    private final Integer code;
    private final String name;

    public static String getNameByCode(Integer code) {
        if (code == null) {
            return "";
        }
        for (SealCategory category : values()) {
            if (category.getCode().equals(code)) {
                return category.getName();
            }
        }
        return "";
    }

    public static SealCategory getByCode(Integer code) {
        if (code == null) {
            return null;
        }
        for (SealCategory category : values()) {
            if (category.getCode().equals(code)) {
                return category;
            }
        }
        return null;
    }
}
