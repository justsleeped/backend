package com.sealflow.listener;

import com.sealflow.service.ISealApplyService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.flowable.engine.delegate.TaskListener;
import org.flowable.task.service.delegate.DelegateTask;
import org.springframework.stereotype.Component;

@Slf4j
@Component
@RequiredArgsConstructor
public class ApplyTaskListener implements TaskListener {

    private final ISealApplyService sealApplyService;

    @Override
    public void notify(DelegateTask delegateTask) {
        String eventName = delegateTask.getEventName();
        if ("create".equals(eventName)) {
            log.info("申请任务创建: taskId={}, taskName={}", delegateTask.getId(), delegateTask.getName());
        }
    }
}
