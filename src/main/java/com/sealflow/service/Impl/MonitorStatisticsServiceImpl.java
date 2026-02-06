package com.sealflow.service.Impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.sealflow.model.entity.SealApply;
import com.sealflow.model.entity.SealApplyRecord;
import com.sealflow.model.vo.MonitorStatisticsVO;
import com.sealflow.service.IMonitorStatisticsService;
import com.sealflow.service.ISealApplyRecordService;
import com.sealflow.service.ISealApplyService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class MonitorStatisticsServiceImpl implements IMonitorStatisticsService {

    private final ISealApplyService sealApplyService;
    private final ISealApplyRecordService approvalRecordService;

    @Override
    public MonitorStatisticsVO getMonitorStatistics() {
        MonitorStatisticsVO vo = new MonitorStatisticsVO();
        vo.setApplyOverview(getApplyOverview());
        vo.setSealUsageAnalysis(getSealUsageAnalysis());
        vo.setApprovalEfficiency(getApprovalEfficiency());
        vo.setApproverWorkloads(getApproverWorkloads());
        vo.setUrgencyAnalysis(getUrgencyAnalysis());
        vo.setTimeTrendAnalysis(getTimeTrendAnalysis());
        return vo;
    }

    private MonitorStatisticsVO.ApplyOverview getApplyOverview() {
        MonitorStatisticsVO.ApplyOverview overview = new MonitorStatisticsVO.ApplyOverview();

        List<SealApply> allApplies = sealApplyService.list(
                new LambdaQueryWrapper<SealApply>().eq(SealApply::getDeleted, 0));

        overview.setTotalCount((long) allApplies.size());
        overview.setPendingCount(allApplies.stream().filter(a -> a.getStatus() == 0).count());
        overview.setInProgressCount(allApplies.stream().filter(a -> a.getStatus() == 1).count());
        overview.setApprovedCount(allApplies.stream().filter(a -> a.getStatus() == 2).count());
        overview.setRejectedCount(allApplies.stream().filter(a -> a.getStatus() == 3).count());
        overview.setRevokedCount(allApplies.stream().filter(a -> a.getStatus() == 4).count());

        LocalDateTime todayStart = LocalDate.now().atStartOfDay();
        LocalDateTime weekStart = LocalDate.now().minusDays(7).atStartOfDay();
        LocalDateTime monthStart = LocalDate.now().withDayOfMonth(1).atStartOfDay();

        overview.setTodayCount(allApplies.stream()
                .filter(a -> a.getApplyTime() != null && a.getApplyTime().isAfter(todayStart))
                .count());
        overview.setWeekCount(allApplies.stream()
                .filter(a -> a.getApplyTime() != null && a.getApplyTime().isAfter(weekStart))
                .count());
        overview.setMonthCount(allApplies.stream()
                .filter(a -> a.getApplyTime() != null && a.getApplyTime().isAfter(monthStart))
                .count());

        return overview;
    }

    private MonitorStatisticsVO.SealUsageAnalysis getSealUsageAnalysis() {
        MonitorStatisticsVO.SealUsageAnalysis analysis = new MonitorStatisticsVO.SealUsageAnalysis();

        List<SealApply> allApplies = sealApplyService.list(
                new LambdaQueryWrapper<SealApply>().eq(SealApply::getDeleted, 0));

        analysis.setCollegeSealCount(allApplies.stream().filter(a -> a.getSealCategory() != null && a.getSealCategory() == 1).count());
        analysis.setPartySealCount(allApplies.stream().filter(a -> a.getSealCategory() != null && a.getSealCategory() == 2).count());
        analysis.setPhysicalSealCount(allApplies.stream().filter(a -> a.getSealType() != null && a.getSealType() == 1).count());
        analysis.setElectronicSealCount(allApplies.stream().filter(a -> a.getSealType() != null && a.getSealType() == 2).count());

        Map<String, Long> sealUsageMap = allApplies.stream()
                .filter(a -> a.getSealName() != null)
                .collect(Collectors.groupingBy(SealApply::getSealName, Collectors.counting()));

        List<Map<String, Object>> sealUsageRanking = sealUsageMap.entrySet().stream()
                .sorted((e1, e2) -> e2.getValue().compareTo(e1.getValue()))
                .limit(10)
                .map(entry -> {
                    Map<String, Object> map = new HashMap<>();
                    map.put("sealName", entry.getKey());
                    map.put("count", entry.getValue());
                    return map;
                })
                .collect(Collectors.toList());

        analysis.setSealUsageRanking(sealUsageRanking);

        return analysis;
    }

    private MonitorStatisticsVO.ApprovalEfficiency getApprovalEfficiency() {
        MonitorStatisticsVO.ApprovalEfficiency efficiency = new MonitorStatisticsVO.ApprovalEfficiency();

        List<SealApplyRecord> allRecords = approvalRecordService.list(
                new LambdaQueryWrapper<SealApplyRecord>()
                        .isNotNull(SealApplyRecord::getApproveTime)
                        .isNotNull(SealApplyRecord::getTaskStartTime));

        if (!allRecords.isEmpty()) {
            List<Double> durations = allRecords.stream()
                    .map(record -> {
                        if (record.getTaskStartTime() != null && record.getApproveTime() != null) {
                            long hours = ChronoUnit.HOURS.between(record.getTaskStartTime(), record.getApproveTime());
                            return (double) hours;
                        }
                        return null;
                    })
                    .filter(Objects::nonNull)
                    .collect(Collectors.toList());

            if (!durations.isEmpty()) {
                double avgDuration = durations.stream().mapToDouble(d -> d).average().orElse(0);
                efficiency.setAvgApprovalDuration(avgDuration);

                efficiency.setWithinOneHourCount(durations.stream().filter(d -> d <= 1).count());
                efficiency.setOneToFourHoursCount(durations.stream().filter(d -> d > 1 && d <= 4).count());
                efficiency.setOverFourHoursCount(durations.stream().filter(d -> d > 4).count());
            }

            Map<String, List<Double>> nodeDurations = allRecords.stream()
                    .filter(r -> r.getTaskName() != null && r.getTaskStartTime() != null && r.getApproveTime() != null)
                    .collect(Collectors.groupingBy(
                            SealApplyRecord::getTaskName,
                            Collectors.mapping(r -> (double) ChronoUnit.HOURS.between(r.getTaskStartTime(), r.getApproveTime()),
                                    Collectors.toList())
                    ));

            List<Map<String, Object>> nodeAvgDuration = nodeDurations.entrySet().stream()
                    .map(entry -> {
                        Map<String, Object> map = new HashMap<>();
                        map.put("nodeName", entry.getKey());
                        double avg = entry.getValue().stream().mapToDouble(d -> d).average().orElse(0);
                        map.put("avgDuration", avg);
                        map.put("count", entry.getValue().size());
                        return map;
                    })
                    .collect(Collectors.toList());

            efficiency.setNodeAvgDuration(nodeAvgDuration);
        }

        efficiency.setTimeoutCount(allRecords.stream()
                .filter(r -> r.getTaskStartTime() != null && r.getApproveTime() != null)
                .filter(r -> ChronoUnit.HOURS.between(r.getTaskStartTime(), r.getApproveTime()) > 4)
                .count());

        return efficiency;
    }

    private List<MonitorStatisticsVO.ApproverWorkload> getApproverWorkloads() {
        List<SealApplyRecord> allRecords = approvalRecordService.list();

        Map<Long, List<SealApplyRecord>> approverRecords = allRecords.stream()
                .collect(Collectors.groupingBy(SealApplyRecord::getApproverId));

        List<MonitorStatisticsVO.ApproverWorkload> workloads = approverRecords.entrySet().stream()
                .map(entry -> {
                    MonitorStatisticsVO.ApproverWorkload workload = new MonitorStatisticsVO.ApproverWorkload();
                    workload.setApproverId(entry.getKey());

                    List<SealApplyRecord> records = entry.getValue();
                    if (!records.isEmpty()) {
                        SealApplyRecord firstRecord = records.get(0);
                        workload.setApproverName(firstRecord.getApproverName());

                        List<SealApply> allApplies = sealApplyService.list(
                                new LambdaQueryWrapper<SealApply>()
                                        .in(SealApply::getStatus, Arrays.asList(0, 1))
                                        .eq(SealApply::getDeleted, 0));

                        workload.setTodoCount(allApplies.stream()
                                .filter(a -> a.getCurrentApproverId() != null && a.getCurrentApproverId().equals(entry.getKey()))
                                .count());

                        workload.setDoneCount((long) records.size());

                        List<Double> durations = records.stream()
                                .filter(r -> r.getTaskStartTime() != null && r.getApproveTime() != null)
                                .map(r -> (double) ChronoUnit.HOURS.between(r.getTaskStartTime(), r.getApproveTime()))
                                .collect(Collectors.toList());

                        if (!durations.isEmpty()) {
                            workload.setAvgApprovalDuration(durations.stream().mapToDouble(d -> d).average().orElse(0));
                        }

                        long timeoutCount = records.stream()
                                .filter(r -> r.getTaskStartTime() != null && r.getApproveTime() != null)
                                .filter(r -> ChronoUnit.HOURS.between(r.getTaskStartTime(), r.getApproveTime()) > 4)
                                .count();
                        workload.setTimeoutCount(timeoutCount);

                        long approvedCount = records.stream().filter(r -> r.getApproveResult() != null && r.getApproveResult() == 1).count();
                        workload.setApprovalRate(records.isEmpty() ? 0 : (double) approvedCount / records.size() * 100);
                    }

                    return workload;
                })
                .sorted((w1, w2) -> Long.compare(w2.getDoneCount(), w1.getDoneCount()))
                .limit(10)
                .collect(Collectors.toList());

        return workloads;
    }

    private MonitorStatisticsVO.UrgencyAnalysis getUrgencyAnalysis() {
        MonitorStatisticsVO.UrgencyAnalysis analysis = new MonitorStatisticsVO.UrgencyAnalysis();

        List<SealApply> allApplies = sealApplyService.list(
                new LambdaQueryWrapper<SealApply>().eq(SealApply::getDeleted, 0));

        analysis.setNormalCount(allApplies.stream().filter(a -> a.getUrgencyLevel() != null && a.getUrgencyLevel() == 1).count());
        analysis.setUrgentCount(allApplies.stream().filter(a -> a.getUrgencyLevel() != null && a.getUrgencyLevel() == 2).count());
        analysis.setVeryUrgentCount(allApplies.stream().filter(a -> a.getUrgencyLevel() != null && a.getUrgencyLevel() == 3).count());

        Map<Integer, List<SealApplyRecord>> urgencyRecordsMap = new HashMap<>();
        urgencyRecordsMap.put(1, new ArrayList<>());
        urgencyRecordsMap.put(2, new ArrayList<>());
        urgencyRecordsMap.put(3, new ArrayList<>());

        List<SealApplyRecord> allRecords = approvalRecordService.list(
                new LambdaQueryWrapper<SealApplyRecord>()
                        .isNotNull(SealApplyRecord::getApproveTime)
                        .isNotNull(SealApplyRecord::getTaskStartTime));

        for (SealApplyRecord record : allRecords) {
            SealApply apply = sealApplyService.getOne(
                    new LambdaQueryWrapper<SealApply>()
                            .eq(SealApply::getId, record.getApplyId())
                            .eq(SealApply::getDeleted, 0));
            if (apply != null && apply.getUrgencyLevel() != null) {
                urgencyRecordsMap.get(apply.getUrgencyLevel()).add(record);
            }
        }

        List<Map<String, Object>> urgencyAvgDuration = Arrays.asList(1, 2, 3).stream()
                .map(urgency -> {
                    Map<String, Object> map = new HashMap<>();
                    String urgencyName = "";
                    if (urgency == 1) urgencyName = "普通";
                    else if (urgency == 2) urgencyName = "紧急";
                    else if (urgency == 3) urgencyName = "特急";

                    map.put("urgencyLevel", urgency);
                    map.put("urgencyName", urgencyName);

                    List<SealApplyRecord> records = urgencyRecordsMap.get(urgency);
                    if (!records.isEmpty()) {
                        double avg = records.stream()
                                .filter(r -> r.getTaskStartTime() != null && r.getApproveTime() != null)
                                .mapToDouble(r -> ChronoUnit.HOURS.between(r.getTaskStartTime(), r.getApproveTime()))
                                .average().orElse(0);
                        map.put("avgDuration", avg);
                        map.put("count", records.size());
                    } else {
                        map.put("avgDuration", 0);
                        map.put("count", 0);
                    }

                    return map;
                })
                .collect(Collectors.toList());

        analysis.setUrgencyAvgDuration(urgencyAvgDuration);

        return analysis;
    }

    private MonitorStatisticsVO.TimeTrendAnalysis getTimeTrendAnalysis() {
        MonitorStatisticsVO.TimeTrendAnalysis analysis = new MonitorStatisticsVO.TimeTrendAnalysis();

        List<SealApply> allApplies = sealApplyService.list(
                new LambdaQueryWrapper<SealApply>().eq(SealApply::getDeleted, 0));

        List<SealApplyRecord> allRecords = approvalRecordService.list();

        LocalDate today = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM-dd");

        List<Map<String, Object>> last7DaysApplyTrend = new ArrayList<>();
        List<Map<String, Object>> last7DaysApprovalRateTrend = new ArrayList<>();
        List<Map<String, Object>> last7DaysAvgDurationTrend = new ArrayList<>();

        for (int i = 6; i >= 0; i--) {
            LocalDate date = today.minusDays(i);
            LocalDateTime dayStart = date.atStartOfDay();
            LocalDateTime dayEnd = date.plusDays(1).atStartOfDay();

            String dateStr = date.format(formatter);

            long applyCount = allApplies.stream()
                    .filter(a -> a.getApplyTime() != null)
                    .filter(a -> !a.getApplyTime().isBefore(dayStart) && a.getApplyTime().isBefore(dayEnd))
                    .count();

            Map<String, Object> applyTrend = new HashMap<>();
            applyTrend.put("date", dateStr);
            applyTrend.put("count", applyCount);
            last7DaysApplyTrend.add(applyTrend);

            long approvedCount = allApplies.stream()
                    .filter(a -> a.getFinishTime() != null)
                    .filter(a -> !a.getFinishTime().isBefore(dayStart) && a.getFinishTime().isBefore(dayEnd))
                    .filter(a -> a.getStatus() != null && a.getStatus() == 2)
                    .count();

            long finishedCount = allApplies.stream()
                    .filter(a -> a.getFinishTime() != null)
                    .filter(a -> !a.getFinishTime().isBefore(dayStart) && a.getFinishTime().isBefore(dayEnd))
                    .filter(a -> a.getStatus() != null && (a.getStatus() == 2 || a.getStatus() == 3))
                    .count();

            double approvalRate = finishedCount > 0 ? (double) approvedCount / finishedCount * 100 : 0;

            Map<String, Object> approvalRateTrend = new HashMap<>();
            approvalRateTrend.put("date", dateStr);
            approvalRateTrend.put("approvalRate", approvalRate);
            last7DaysApprovalRateTrend.add(approvalRateTrend);

            List<Double> dayDurations = allRecords.stream()
                    .filter(r -> r.getApproveTime() != null && r.getTaskStartTime() != null)
                    .filter(r -> !r.getApproveTime().isBefore(dayStart) && r.getApproveTime().isBefore(dayEnd))
                    .map(r -> (double) ChronoUnit.HOURS.between(r.getTaskStartTime(), r.getApproveTime()))
                    .collect(Collectors.toList());

            double avgDuration = dayDurations.isEmpty() ? 0 : dayDurations.stream().mapToDouble(d -> d).average().orElse(0);

            Map<String, Object> avgDurationTrend = new HashMap<>();
            avgDurationTrend.put("date", dateStr);
            avgDurationTrend.put("avgDuration", avgDuration);
            last7DaysAvgDurationTrend.add(avgDurationTrend);
        }

        analysis.setLast7DaysApplyTrend(last7DaysApplyTrend);
        analysis.setLast7DaysApprovalRateTrend(last7DaysApprovalRateTrend);
        analysis.setLast7DaysAvgDurationTrend(last7DaysAvgDurationTrend);

        return analysis;
    }
}
