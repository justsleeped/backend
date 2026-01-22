package com.sealflow.common.Result;

import com.sealflow.common.enums.HttpStatusCode;
import com.baomidou.mybatisplus.core.metadata.IPage;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PageResult<T> implements Serializable {
    private int status;
    private String statusText;
    private Data<T> data;

    public static <T> PageResult<T> success(IPage<T> page) {
        PageResult<T> result = new PageResult<>();
        result.setStatus(HttpStatusCode.OK.getStatus());
        Data<T> data = new Data<>();
        data.setList(page.getRecords());
        data.setTotal(page.getTotal());

        result.setData(data);
        result.setStatusText(HttpStatusCode.OK.getStatusText());
        return result;
    }

    public static boolean isSuccess(PageResult<?> result) {
        return result != null && HttpStatusCode.OK.getStatus() == result.getStatus();
    }

    @lombok.Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class Data<T> implements Serializable {
        private List<T> list;
        private long total;
    }
}
