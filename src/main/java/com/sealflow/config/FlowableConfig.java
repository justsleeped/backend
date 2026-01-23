package com.sealflow.config;

import org.flowable.engine.*;
import org.flowable.spring.SpringProcessEngineConfiguration;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.transaction.PlatformTransactionManager;

import javax.sql.DataSource;

/**
 * Flowable工作流引擎配置类
 * 
 * 主要功能：
 * 1. 配置Flowable流程引擎
 * 2. 暴露Flowable核心服务Bean
 * 3. 设置数据源和事务管理器
 * 
 * 暴露的服务：
 * - RepositoryService：流程仓库服务，管理流程定义
 * - RuntimeService：流程运行时服务，管理流程实例
 * - TaskService：任务服务，管理用户任务
 * - HistoryService：历史服务，查询历史数据
 * - IdentityService：身份服务，管理用户和组
 */
@Configuration
public class FlowableConfig {

    /**
     * 配置Flowable流程引擎
     * 
     * 功能说明：
     * 1. 设置数据源
     * 2. 设置事务管理器
     * 3. 启用数据库schema自动更新
     * 4. 禁用异步执行器
     * 5. 设置Spring应用上下文
     * 
     * @param dataSource 数据源
     * @param transactionManager 事务管理器
     * @param applicationContext Spring应用上下文
     * @return 流程引擎实例
     */
    @Bean
    @Primary
    public ProcessEngine processEngine(DataSource dataSource, PlatformTransactionManager transactionManager, ApplicationContext applicationContext) {
        SpringProcessEngineConfiguration configuration = new SpringProcessEngineConfiguration();
        configuration.setDataSource(dataSource);
        configuration.setTransactionManager(transactionManager);
        configuration.setDatabaseSchemaUpdate("true");
        configuration.setAsyncExecutorActivate(false);
        configuration.setApplicationContext(applicationContext);
        return configuration.buildProcessEngine();
    }

    /**
     * 暴露流程仓库服务
     * 
     * 功能说明：
     * 用于管理流程定义、部署流程定义等操作
     * 
     * @param processEngine 流程引擎
     * @return 流程仓库服务
     */
    @Bean
    public RepositoryService repositoryService(ProcessEngine processEngine) {
        return processEngine.getRepositoryService();
    }

    /**
     * 暴露流程运行时服务
     * 
     * 功能说明：
     * 用于启动流程实例、查询流程实例、操作流程变量等
     * 
     * @param processEngine 流程引擎
     * @return 流程运行时服务
     */
    @Bean
    public RuntimeService runtimeService(ProcessEngine processEngine) {
        return processEngine.getRuntimeService();
    }

    /**
     * 暴露任务服务
     * 
     * 功能说明：
     * 用于查询用户任务、完成任务、分配任务等操作
     * 
     * @param processEngine 流程引擎
     * @return 任务服务
     */
    @Bean
    public TaskService taskService(ProcessEngine processEngine) {
        return processEngine.getTaskService();
    }

    /**
     * 暴露历史服务
     * 
     * 功能说明：
     * 用于查询历史流程实例、历史任务、历史变量等
     * 
     * @param processEngine 流程引擎
     * @return 历史服务
     */
    @Bean
    public HistoryService historyService(ProcessEngine processEngine) {
        return processEngine.getHistoryService();
    }

    /**
     * 暴露身份服务
     * 
     * 功能说明：
     * 用于管理用户、组、用户与组的关系等
     * 
     * @param processEngine 流程引擎
     * @return 身份服务
     */
    @Bean
    public IdentityService identityService(ProcessEngine processEngine) {
        return processEngine.getIdentityService();
    }
}