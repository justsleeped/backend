package com.sealflow.service;

public interface IHardwareControlService {
    Boolean sendUnlockSignal(Long sealId, String sealName, Long applyId);
}
