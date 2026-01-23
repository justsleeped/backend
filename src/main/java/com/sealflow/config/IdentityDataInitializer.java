package com.sealflow.config;

import com.sealflow.service.IdentitySyncService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Component;

@Slf4j
@Component
@RequiredArgsConstructor
public class IdentityDataInitializer implements ApplicationRunner {

    @Lazy
    private final IdentitySyncService identitySyncService;

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
