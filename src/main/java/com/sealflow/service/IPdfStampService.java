package com.sealflow.service;

import com.sealflow.model.form.SealStampForm;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

public interface IPdfStampService {

    String uploadPdf(MultipartFile file) throws IOException;

    byte[] stampPdfWithEvidence(SealStampForm formData) throws IOException;
}
