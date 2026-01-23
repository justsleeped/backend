package com.sealflow.config;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.flowable.engine.RepositoryService;
import org.flowable.engine.repository.Deployment;
import org.springframework.stereotype.Component;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;

@Component
@Slf4j
@RequiredArgsConstructor
public class ActivitiProcessDeployer implements ApplicationRunner {

    private final RepositoryService repositoryService;

    @Override
    public void run(ApplicationArguments args) {
        try {
            String processKey = "sealApplyProcess";
            
            long count = repositoryService.createProcessDefinitionQuery()
                    .processDefinitionKey(processKey)
                    .count();
            
            if (count == 0) {
                Deployment deployment = repositoryService.createDeployment()
                        .addClasspathResource("processes/seal-apply-process.bpmn20.xml")
                        .name("印章使用申请流程")
                        .deploy();
                
                log.info("印章使用申请流程部署成功，部署ID: {}", deployment.getId());
            } else {
                log.info("印章使用申请流程已存在，跳过部署");
            }
        } catch (Exception e) {
            log.error("部署印章使用申请流程失败", e);
        }
    }
}