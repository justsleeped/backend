package com.sealflow.controller;

import com.sealflow.common.Result.Result;
import com.sealflow.model.vo.MonitorStatisticsVO;
import com.sealflow.service.IMonitorStatisticsService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@Tag(name = "监控统计接口")
@RequestMapping("/v1/monitor")
public class MonitorStatisticsController {

    private final IMonitorStatisticsService monitorStatisticsService;

    @Operation(summary = "获取监控统计数据")
    @GetMapping("/statistics")
    public Result<MonitorStatisticsVO> getStatistics() {
        MonitorStatisticsVO statistics = monitorStatisticsService.getMonitorStatistics();
        return Result.success(statistics);
    }
}
