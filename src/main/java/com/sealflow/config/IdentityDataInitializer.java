package com.sealflow.config;

import com.sealflow.service.IdentitySyncService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Component;

/**
 * 身份数据初始化器
 * 
 * 功能说明：
 * 在应用启动时自动执行以下操作：
 * 1. 初始化系统角色到Flowable（班主任、辅导员、学院院长、党委书记）
 * 2. 同步所有角色到Flowable
 * 3. 同步所有用户到Flowable
 * 
 * 实现说明：
 * 实现ApplicationRunner接口，在应用启动后自动执行run方法
 * 使用@Lazy注解延迟加载IdentitySyncService，避免循环依赖
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class IdentityDataInitializer implements ApplicationRunner {

    @Lazy
    private final IdentitySyncService identitySyncService;

    /**
     * 应用启动后执行的方法
     * 
     * 功能说明：
     * 1. 初始化系统角色
     * 2. 同步所有角色到Flowable
     * 3. 同步所有用户到Flowable
     * 
     * @param args 应用启动参数
     */
    @Override
    public void run(ApplicationArguments args) {
        try {
            log.info("开始初始化Flowable身份数据...");

            // 初始化系统角色
            identitySyncService.initSystemRoles();

            // 同步所有角色到Flowable
            identitySyncService.syncAllRoles();

            // 同步所有用户到Flowable
            identitySyncService.syncAllUsers();

            log.info("Flowable身份数据初始化完成");
        } catch (Exception e) {
            log.error("初始化Flowable身份数据失败", e);
        }
    }
}
