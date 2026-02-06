package com.sealflow.model.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.List;
import java.util.Map;

@Data
@Schema(description = "监控统计数据")
public class MonitorStatisticsVO {

    @Schema(description = "申请概况")
    private ApplyOverview applyOverview;

    @Schema(description = "印章使用分析")
    private SealUsageAnalysis sealUsageAnalysis;

    @Schema(description = "审批效率分析")
    private ApprovalEfficiency approvalEfficiency;

    @Schema(description = "审批人工作负载")
    private List<ApproverWorkload> approverWorkloads;

    @Schema(description = "紧急程度分析")
    private UrgencyAnalysis urgencyAnalysis;

    @Schema(description = "时间趋势分析")
    private TimeTrendAnalysis timeTrendAnalysis;

    @Data
    @Schema(description = "申请概况")
    public static class ApplyOverview {
        @Schema(description = "总申请数")
        private Long totalCount;

        @Schema(description = "待审批数")
        private Long pendingCount;

        @Schema(description = "审批中数")
        private Long inProgressCount;

        @Schema(description = "已通过数")
        private Long approvedCount;

        @Schema(description = "已拒绝数")
        private Long rejectedCount;

        @Schema(description = "已撤销数")
        private Long revokedCount;

        @Schema(description = "今日申请数")
        private Long todayCount;

        @Schema(description = "本周申请数")
        private Long weekCount;

        @Schema(description = "本月申请数")
        private Long monthCount;
    }

    @Data
    @Schema(description = "印章使用分析")
    public static class SealUsageAnalysis {
        @Schema(description = "院章使用数")
        private Long collegeSealCount;

        @Schema(description = "党章使用数")
        private Long partySealCount;

        @Schema(description = "物理章使用数")
        private Long physicalSealCount;

        @Schema(description = "电子章使用数")
        private Long electronicSealCount;

        @Schema(description = "各印章使用排行（印章名称 -> 使用次数）")
        private List<Map<String, Object>> sealUsageRanking;
    }

    @Data
    @Schema(description = "审批效率分析")
    public static class ApprovalEfficiency {
        @Schema(description = "平均审批时长（小时）")
        private Double avgApprovalDuration;

        @Schema(description = "1小时内完成数")
        private Long withinOneHourCount;

        @Schema(description = "1-4小时完成数")
        private Long oneToFourHoursCount;

        @Schema(description = "超过4小时完成数")
        private Long overFourHoursCount;

        @Schema(description = "各节点平均审批时长（节点名称 -> 平均时长）")
        private List<Map<String, Object>> nodeAvgDuration;

        @Schema(description = "超时申请数")
        private Long timeoutCount;
    }

    @Data
    @Schema(description = "审批人工作负载")
    public static class ApproverWorkload {
        @Schema(description = "审批人ID")
        private Long approverId;

        @Schema(description = "审批人姓名")
        private String approverName;

        @Schema(description = "待办数量")
        private Long todoCount;

        @Schema(description = "已办数量")
        private Long doneCount;

        @Schema(description = "平均审批时长（小时）")
        private Double avgApprovalDuration;

        @Schema(description = "超时数量")
        private Long timeoutCount;

        @Schema(description = "通过率")
        private Double approvalRate;
    }

    @Data
    @Schema(description = "紧急程度分析")
    public static class UrgencyAnalysis {
        @Schema(description = "普通申请数")
        private Long normalCount;

        @Schema(description = "紧急申请数")
        private Long urgentCount;

        @Schema(description = "特急申请数")
        private Long veryUrgentCount;

        @Schema(description = "各紧急程度平均审批时长（紧急程度 -> 平均时长）")
        private List<Map<String, Object>> urgencyAvgDuration;
    }

    @Data
    @Schema(description = "时间趋势分析")
    public static class TimeTrendAnalysis {
        @Schema(description = "最近7天申请量趋势")
        private List<Map<String, Object>> last7DaysApplyTrend;

        @Schema(description = "最近7天通过率趋势")
        private List<Map<String, Object>> last7DaysApprovalRateTrend;

        @Schema(description = "最近7天平均审批时长趋势")
        private List<Map<String, Object>> last7DaysAvgDurationTrend;
    }
}
