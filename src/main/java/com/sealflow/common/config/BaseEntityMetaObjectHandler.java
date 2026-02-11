package com.sealflow.common.config;

import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import com.sealflow.common.context.UserContextHolder;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.reflection.MetaObject;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;

@Slf4j
@Component
public class BaseEntityMetaObjectHandler implements MetaObjectHandler {

    private static final String CREATE_BY = "createBy";
    private static final String CREATE_TIME = "createTime";
    private static final String UPDATE_BY = "updateBy";
    private static final String UPDATE_TIME = "updateTime";

    @Override
    public void insertFill(MetaObject metaObject) {
        Long currentUserId = UserContextHolder.getCurrentUserId();
        LocalDateTime now = LocalDateTime.now();

        this.strictInsertFill(metaObject, CREATE_TIME, LocalDateTime.class, now);
        this.strictInsertFill(metaObject, CREATE_BY, Long.class, currentUserId);

        this.strictInsertFill(metaObject, UPDATE_TIME, LocalDateTime.class, now);
        this.strictInsertFill(metaObject, UPDATE_BY, Long.class, currentUserId);
    }

    @Override
    public void updateFill(MetaObject metaObject) {
        Long currentUserId = UserContextHolder.getCurrentUserId();
        LocalDateTime now = LocalDateTime.now();

        this.strictUpdateFill(metaObject, UPDATE_TIME, LocalDateTime.class, now);
        this.strictUpdateFill(metaObject, UPDATE_BY, Long.class, currentUserId);
    }
}
