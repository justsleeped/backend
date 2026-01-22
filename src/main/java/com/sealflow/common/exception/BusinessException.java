package com.sealflow.common.exception;

import lombok.Getter;
import lombok.Setter;

/**
 * 业务异常类
 */
@Setter
@Getter
public class BusinessException extends RuntimeException {

    private Integer code;

    public BusinessException(String message) {
        super(message);
        this.code = 400; // 默认为400错误
    }

    public BusinessException(Integer code, String message) {
        super(message);
        this.code = code;
    }

}
