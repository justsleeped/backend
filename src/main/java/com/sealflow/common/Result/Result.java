package com.sealflow.common.Result;

import com.sealflow.common.enums.HttpStatusCode;
import lombok.Builder;
import lombok.Data;

import java.io.Serializable;

/**
 * 统一返回结果
 */
@Data
@Builder
public class Result<T> implements Serializable {
    private final Integer status;
    private final String statusText;
    private final T data;

    /**
     * 成功返回带状态码、成功信息、 数据
     * @param data  数据
     * @param message  信息
     * @return  200正确的Result
     */
    public static <T> Result<T> success(Integer statusCode, String message, T data) {
        return Result.<T>builder()
                .status(statusCode)
                .statusText(message)
                .data(data)
                .build();
    }
    /**
     * 成功返回带数据
     * @param data  数据
     * @return  200正确的Result
     */
    public static <T> Result<T> success(T data) {
        return success(HttpStatusCode.OK.getStatus(), HttpStatusCode.OK.getStatusText(), data);
    }

    /**
     * 成功返回不带数据
     * @return  200正确的Result
     */
    public static <T> Result<T> success() {
        return success(null);
    }



    /**
     * 创建一个错误的返回结果对象
     * @param statusCode 错误状态
     * @param message 错误信息
     * @return 错误的Result对象
     */
    public static <T> Result<T> error(Integer statusCode, String message) {
        return Result.<T>builder()
                .status(statusCode)
                .statusText(message)
                .build();
    }

    /**
     * 创建一个400错误的返回结果对象
     * @param message 错误信息
     * @param <T> 数据类型
     * @return 400错误的Result对象
     */
    public static <T> Result<T> badRequest(String message) {
        return error(HttpStatusCode.BAD_REQUEST.getStatus(), message);
    }

    /**
     * 创建一个400错误的返回结果对象，使用默认错误信息
     * @param <T> 数据类型
     * @return 400错误的Result对象
     */
    public static <T> Result<T> badRequest() {
        return badRequest(HttpStatusCode.BAD_REQUEST.getStatusText());
    }

    /**
     * 创建一个404错误的返回结果对象
     * @param message 错误信息
     * @param <T> 数据类型
     * @return 404错误的Result对象
     */
    public static <T> Result<T> notFound(String message) {
        return error(HttpStatusCode.NOT_FOUND.getStatus(), message);
    }

    /**
     * 创建一个404错误的返回结果对象，使用默认错误信息
     * @param <T> 数据类型
     * @return 404错误的Result对象
     */
    public static <T> Result<T> notFound() {
        return notFound(HttpStatusCode.NOT_FOUND.getStatusText());
    }

    /**
     * 创建一个405错误的返回结果对象
     * @param message 错误信息
     * @param <T> 数据类型
     * @return 405错误的Result对象
     */
    public static <T> Result<T> methodNotAllowed(String message) {
        return error(HttpStatusCode.METHOD_NOT_ALLOWED.getStatus(), message);
    }

    /**
     * 创建一个405错误的返回结果对象，使用默认错误信息
     * @param <T> 数据类型
     * @return 405错误的Result对象
     */
    public static <T> Result<T> methodNotAllowed() {
        return methodNotAllowed(HttpStatusCode.METHOD_NOT_ALLOWED.getStatusText());
    }

    /**
     * 创建一个500错误的返回结果对象
     * @param message 错误信息
     * @param <T> 数据类型
     * @return 500错误的Result对象
     */
    public static <T> Result<T> serverError(String message) {
        return error(HttpStatusCode.INTERNAL_SERVER_ERROR.getStatus(), message);
    }

    /**
     * 创建一个500错误的返回结果对象，使用默认错误信息
     * @param <T> 数据类型
     * @return 500错误的Result对象
     */
    public static <T> Result<T> serverError() {
        return serverError(HttpStatusCode.INTERNAL_SERVER_ERROR.getStatusText());
    }

    /**
     * 创建一个401错误的返回结果对象
     * @param message 错误信息
     * @param <T> 数据类型
     * @return 401错误的Result对象
     */
    public static <T> Result<T> unauthorized(String message) {
        return error(HttpStatusCode.UNAUTHORIZED.getStatus(), message);
    }

    /**
     * 创建一个401错误的返回结果对象，使用默认错误信息
     * @param <T> 数据类型
     * @return 401错误的Result对象
     */
    public static <T> Result<T> unauthorized() {
        return unauthorized(HttpStatusCode.UNAUTHORIZED.getStatusText());
    }

    /**
     * 创建一个403错误的返回结果对象
     * @param message 错误信息
     * @param <T> 数据类型
     * @return 403错误的Result对象
     */
    public static <T> Result<T> forbidden(String message) {
        return error(HttpStatusCode.FORBIDDEN.getStatus(), message);
    }

    /**
     * 创建一个403错误的返回结果对象，使用默认错误信息
     * @param <T> 数据类型
     * @return 403错误的Result对象
     */
    public static <T> Result<T> forbidden() {
        return forbidden(HttpStatusCode.FORBIDDEN.getStatusText());
    }
}
