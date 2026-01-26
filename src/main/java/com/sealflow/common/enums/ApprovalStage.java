package com.sealflow.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum ApprovalStage {
    FIRST(1, "一级审批"),
    SECOND(2, "二级审批"),
    THIRD(3, "三级审批"),
    FOURTH(4, "四级审批");

    private final Integer code;
    private final String name;

    public static String getNameByCode(Integer code) {
        if (code == null) {
            return "";
        }
        for (ApprovalStage stage : values()) {
            if (stage.getCode().equals(code)) {
                return stage.getName();
            }
        }
        return "";
    }

    public static ApprovalStage getByCode(Integer code) {
        if (code == null) {
            return null;
        }
        for (ApprovalStage stage : values()) {
            if (stage.getCode().equals(code)) {
                return stage;
            }
        }
        return null;
    }
}
