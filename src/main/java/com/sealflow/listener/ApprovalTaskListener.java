package com.sealflow.listener;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.flowable.engine.delegate.TaskListener;
import org.flowable.task.service.delegate.DelegateTask;
import org.springframework.stereotype.Component;

@Slf4j
@Component
@RequiredArgsConstructor
public class ApprovalTaskListener implements TaskListener {

    @Override
    public void notify(DelegateTask delegateTask) {
        String eventName = delegateTask.getEventName();
        if ("complete".equals(eventName)) {
            log.info("审批任务完成: taskId={}, taskName={}, assignee={}", 
                    delegateTask.getId(), delegateTask.getName(), delegateTask.getAssignee());
        }
    }
}
