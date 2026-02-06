package com.sealflow.common.exception;

import com.sealflow.common.Result.Result;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

/**
 * 全局异常处理器
 */
@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler {
    /**
     * 处理业务逻辑异常
     */
    @ExceptionHandler(BusinessException.class)
    public Result<Void> handleBusinessException(BusinessException e) {
        log.error("业务逻辑异常: {}", e.getMessage());
        return Result.error(e.getCode(), e.getMessage());
    }

    /**
     * 处理运行时异常
     */
    @ExceptionHandler(RuntimeException.class)
    public Result<Void> handleRuntimeException(RuntimeException e) {
        log.error("运行时异常: ", e);
        return Result.serverError(e.getMessage());
    }

    /**
     * 处理非法参数异常（如 Assert 抛出的异常）
     */
    @ExceptionHandler(IllegalArgumentException.class)
    public Result<Void> handleIllegalArgumentException(IllegalArgumentException e) {
        log.error("参数验证异常: {}", e.getMessage());
        return Result.badRequest(e.getMessage());
    }

    /**
     * 处理非法状态异常（如 Assert.state 抛出的异常）
     */
    @ExceptionHandler(IllegalStateException.class)
    public Result<Void> handleIllegalStateException(IllegalStateException e) {
        log.error("状态验证异常: {}", e.getMessage());
        return Result.badRequest(e.getMessage());
    }

    /**
     * 处理权限不足异常
     */
    @ExceptionHandler(AccessDeniedException.class)
    public Result<Void> handleAccessDeniedException(AccessDeniedException e) {
        log.warn("权限不足: {}", e.getMessage());
        return Result.forbidden("权限不足，无法访问该资源");
    }
}
