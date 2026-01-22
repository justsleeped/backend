//package com.sealflow.common.exception;
//
//import com.sealflow.common.Result.Result;
//import lombok.extern.slf4j.Slf4j;
//import org.springframework.web.bind.annotation.ExceptionHandler;
//import org.springframework.web.bind.annotation.RestControllerAdvice;
//
///**
// * 全局异常处理器
// */
//@Slf4j
//@RestControllerAdvice
//public class GlobalExceptionHandler {
//    /**
//     * 处理业务逻辑异常
//     */
//    @ExceptionHandler(BusinessException.class)
//    public Result<Void> handleBusinessException(BusinessException e) {
//        log.error("业务逻辑异常: {}", e.getMessage());
//        return Result.error(e.getCode(), e.getMessage());
//    }
//
//    /**
//     * 处理运行时异常
//     */
//    @ExceptionHandler(RuntimeException.class)
//    public Result<Void> handleRuntimeException(RuntimeException e) {
//        log.error("运行时异常: ", e);
//        return Result.serverError(e.getMessage());
//    }
//}
