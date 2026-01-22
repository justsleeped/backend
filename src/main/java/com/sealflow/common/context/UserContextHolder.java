/**
 * @author Chen Qin
 * @license Apache-2.0
 */
package com.sealflow.common.context;

import lombok.extern.slf4j.Slf4j;

/**
 * 用户上下文工具类
 */
@Slf4j
public class UserContextHolder {

    private static final ThreadLocal<UserInfo> USER_CONTEXT = new ThreadLocal<>();

    /**
     * 设置当前用户信息
     */
    public static void setCurrentUser(UserInfo userInfo) {
        USER_CONTEXT.set(userInfo);
    }

    /**
     * 获取当前用户信息
     */
    public static UserInfo getCurrentUser() {
        return USER_CONTEXT.get();
    }

    /**
     * 获取当前用户ID
     */
    public static Long getCurrentUserId() {
        UserInfo userInfo = getCurrentUser();
        return userInfo != null ? userInfo.getUserId() : null;
    }

    /**
     * 获取当前用户名
     */
    public static String getCurrentUsername() {
        UserInfo userInfo = getCurrentUser();
        return userInfo != null ? userInfo.getUsername() : null;
    }

    /**
     * 检查当前用户是否有指定角色
     */
    public static boolean hasRole(String role) {
        UserInfo userInfo = getCurrentUser();
        return userInfo != null && userInfo.getRoles() != null && userInfo.getRoles().contains(role);
    }

    /**
     * 检查当前用户是否有指定权限
     */
    public static boolean hasPermission(String permission) {
        UserInfo userInfo = getCurrentUser();
        return userInfo != null && userInfo.getPermissions() != null && userInfo.getPermissions().contains(permission);
    }

    /**
     * 清除当前用户信息
     */
    public static void clear() {
        USER_CONTEXT.remove();
    }

    /**
     * 检查是否已登录
     */
    public static boolean isAuthenticated() {
        return getCurrentUser() != null;
    }
}
