package com.sealflow.listener;

import com.sealflow.service.IPartyApplyService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.flowable.engine.delegate.TaskListener;
import org.flowable.task.service.delegate.DelegateTask;
import org.springframework.stereotype.Component;

@Slf4j
@Component
@RequiredArgsConstructor
public class ApplyTaskListener implements TaskListener {

    private final IPartyApplyService partyApplyService;

    @Override
    public void notify(DelegateTask delegateTask) {
        String eventName = delegateTask.getEventName();
        if ("create".equals(eventName)) {
            log.info("申请任务创建: taskId={}, taskName={}", delegateTask.getId(), delegateTask.getName());
            // 不再在这里调用 startProcess，因为该方法会启动一个新的流程实例
            // 而当前正在执行的任务已经是流程的一部分，不需要重复启动
            // 如果需要在任务创建时执行某些操作，可以在这里添加
        }
    }
}
