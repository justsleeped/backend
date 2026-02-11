package com.sealflow.controller;

import com.sealflow.common.Result.Result;
import com.sealflow.common.enums.HttpStatusCode;
import com.sealflow.model.form.SealStampForm;
import com.sealflow.model.entity.SealStampRecord;
import com.sealflow.service.IPdfStampService;
import com.sealflow.service.IBlockchainEvidenceService;
import com.sealflow.service.ISealApplyService;
import com.sealflow.service.ISealStampRecordService;
import com.sealflow.model.vo.SealApplyVO;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.LinkedHashMap;

@RestController
@RequiredArgsConstructor
@Tag(name = "PDF盖章接口")
@RequestMapping("/v1/pdfStamp")
public class PdfStampController {

    private final IPdfStampService pdfStampService;
    private final IBlockchainEvidenceService blockchainEvidenceService;
    private final ISealApplyService sealApplyService;
    private final ISealStampRecordService sealStampRecordService;

    @Operation(summary = "上传PDF文件")
    @PostMapping("/upload")
    @PreAuthorize("hasAuthority('system:upload')")
    public Result<String> uploadPdf(@RequestParam("file") MultipartFile file) {
        try {
            String fileUrl = pdfStampService.uploadPdf(file);
            return Result.success(fileUrl);
        } catch (IOException e) {
            return Result.error(HttpStatusCode.BAD_REQUEST.getStatus(), e.getMessage());
        }
    }

    @Operation(summary = "盖章并下载PDF")
    @PostMapping("/download")
    @PreAuthorize("hasAuthority('system:stamp')")
    public ResponseEntity<byte[]> downloadStampedPdf(@Valid @RequestBody SealStampForm formData) {
        try {
            byte[] pdfBytes = pdfStampService.stampPdf(formData);

            if (formData.getApplyId() != null) {
                SealApplyVO applyVO = sealApplyService.getSealApplyVo(formData.getApplyId());

                LinkedHashMap<String, Object> stampData = new LinkedHashMap<>();
                stampData.put("applyId", formData.getApplyId());
                stampData.put("pdfUrl", formData.getPdfUrl());
                stampData.put("sealImageUrl", formData.getSealImageUrl());
                stampData.put("stamps", formData.getStamps());

                // 创建盖章记录
                SealStampRecord stampRecord = null;
                if (applyVO != null) {
                    stampRecord = sealStampRecordService.createStampRecord(
                            formData.getApplyId(),
                            applyVO.getSealId(),
                            applyVO.getSealName(),
                            applyVO.getApplicantId(),
                            applyVO.getApplicantName(),
                            formData.getPdfUrl(),
                            formData.getSealImageUrl(),
                            1, // 状态：1-成功
                            "PDF文件盖章"
                    );
                }

                // 使用盖章记录的ID作为businessId创建存证
                blockchainEvidenceService.createEvidence(
                        "STAMP",
                        stampRecord != null ? stampRecord.getId() : formData.getApplyId(),
                        stampData,
                        applyVO != null ? applyVO.getApplicantId() : null,
                        applyVO != null ? applyVO.getApplicantName() : null
                );
            }

            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=stamped.pdf")
                    .contentType(MediaType.APPLICATION_PDF)
                    .body(pdfBytes);
        } catch (IOException e) {
            return ResponseEntity.internalServerError().build();
        }
    }
}
