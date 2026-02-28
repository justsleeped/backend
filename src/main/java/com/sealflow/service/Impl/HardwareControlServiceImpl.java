package com.sealflow.service.Impl;

import com.sealflow.common.handler.LockWebSocketHandler;
import com.sealflow.service.IHardwareControlService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Slf4j
@Service
public class HardwareControlServiceImpl implements IHardwareControlService {

    @Override
    public Boolean sendUnlockSignal(Long sealId, String sealName, Long applyId) {
        try {
            log.info("========== 物理章开锁信号 ==========");
            log.info("印章ID: {}", sealId);
            log.info("印章名称: {}", sealName);
            log.info("申请ID: {}", applyId);
            log.info("操作时间: {}", LocalDateTime.now());
            log.info("================================");

            LockWebSocketHandler.sendToDevice("open");
            log.info("发送物理章开锁信号成功，sealId={}, sealName={}, applyId={}",
                     sealId, sealName, applyId);

            return true;
        } catch (Exception e) {
            log.error("发送物理章开锁信号失败，sealId={}, sealName={}, applyId={}",
                     sealId, sealName, applyId, e);
            return false;
        }
    }
}
