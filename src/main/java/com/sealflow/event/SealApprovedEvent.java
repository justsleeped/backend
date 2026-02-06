package com.sealflow.event;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SealApprovedEvent {
    private Long applyId;
    private Long sealId;
    private String sealName;
    private Integer sealType;
    private String processInstanceId;
    private LocalDateTime approvedTime;
}
