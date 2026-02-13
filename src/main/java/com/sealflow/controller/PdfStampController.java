package com.sealflow.controller;

import com.sealflow.common.Result.Result;
import com.sealflow.common.enums.HttpStatusCode;
import com.sealflow.model.form.SealStampForm;
import com.sealflow.service.IPdfStampService;
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

@RestController
@RequiredArgsConstructor
@Tag(name = "PDF盖章接口")
@RequestMapping("/v1/pdfStamp")
public class PdfStampController {

    private final IPdfStampService pdfStampService;

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
            byte[] pdfBytes = pdfStampService.stampPdfWithEvidence(formData);

            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=stamped.pdf")
                    .contentType(MediaType.APPLICATION_PDF)
                    .body(pdfBytes);
        } catch (IOException e) {
            return ResponseEntity.internalServerError().build();
        }
    }
}
