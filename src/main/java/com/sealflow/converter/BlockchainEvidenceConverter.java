package com.sealflow.converter;

import com.sealflow.model.entity.BlockchainEvidence;
import com.sealflow.model.enums.BusinessType;
import com.sealflow.model.vo.BlockchainEvidenceVO;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Named;

import java.util.List;

@Mapper(componentModel = "spring")
public interface BlockchainEvidenceConverter {

    @Mapping(target = "businessTypeName", source = "businessType", qualifiedByName = "businessTypeToName")
    @Mapping(target = "statusName", source = "status", qualifiedByName = "statusToName")
    @Mapping(target = "verifyStatusName", source = "verifyStatus", qualifiedByName = "verifyStatusToName")
    BlockchainEvidenceVO toVO(BlockchainEvidence entity);

    List<BlockchainEvidenceVO> toVOList(List<BlockchainEvidence> entityList);

    @Named("businessTypeToName")
    default String businessTypeToName(String businessType) {
        BusinessType type = BusinessType.getByCode(businessType);
        return type != null ? type.getName() : businessType;
    }

    @Named("statusToName")
    default String statusToName(Integer status) {
        if (status == null) return "未知";
        return status == 1 ? "有效" : "失效";
    }

    @Named("verifyStatusToName")
    default String verifyStatusToName(Integer verifyStatus) {
        if (verifyStatus == null) return "未验证";
		return switch (verifyStatus) {
			case 1 -> "验证通过";
			case 2 -> "验证失败";
			default -> "未验证";
		};
    }
}
