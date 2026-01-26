package com.sealflow.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum ApproverRole {
    CLASS_GUIDE("CLASSGUIDE", "班主任"),
    MENTOR("MENTOR", "辅导员"),
    DEAN("DEAN", "学院院长"),
    PARTY_SECRETARY("PARTYSECRETARY", "党委书记");

    private final String code;
    private final String name;

    public static String getNameByCode(String code) {
        if (code == null) {
            return "";
        }
        for (ApproverRole role : values()) {
            if (role.getCode().equals(code)) {
                return role.getName();
            }
        }
        return "";
    }

    public static ApproverRole getByCode(String code) {
        if (code == null) {
            return null;
        }
        for (ApproverRole role : values()) {
            if (role.getCode().equals(code)) {
                return role;
            }
        }
        return null;
    }
}
