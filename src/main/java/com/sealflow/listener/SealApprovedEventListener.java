package com.sealflow.listener;

import com.sealflow.event.SealApprovedEvent;
import com.sealflow.service.IHardwareControlService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.event.EventListener;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

@Slf4j
@Component
@RequiredArgsConstructor
public class SealApprovedEventListener {

    private final IHardwareControlService hardwareControlService;

    @Async
    @EventListener
    public void handleSealApproved(SealApprovedEvent event) {
        log.info("收到印章审批通过事件，applyId={}, sealId={}, sealType={}", 
                 event.getApplyId(), event.getSealId(), event.getSealType());

        try {
            if (event.getSealType() == 1) {
                log.info("检测到物理章审批通过，准备发送开锁信号，sealId={}, sealName={}", 
                         event.getSealId(), event.getSealName());

                Boolean success = hardwareControlService.sendUnlockSignal(
                    event.getSealId(),
                    event.getSealName(),
                    event.getApplyId()
                );

                if (success) {
                    log.info("物理章开锁信号发送成功，sealId={}", event.getSealId());
                } else {
                    log.error("物理章开锁信号发送失败，sealId={}", event.getSealId());
                }
            }
        } catch (Exception e) {
            log.error("处理物理章开锁失败", e);
        }
    }
}
