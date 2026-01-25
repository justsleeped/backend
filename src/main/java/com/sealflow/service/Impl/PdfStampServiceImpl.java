package com.sealflow.service.Impl;

import com.sealflow.model.form.SealStampForm;
import com.sealflow.service.IPdfStampService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.common.PDRectangle;
import org.apache.pdfbox.pdmodel.graphics.image.PDImageXObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

@Slf4j
@Service
@RequiredArgsConstructor
public class PdfStampServiceImpl implements IPdfStampService {

    @Value("${file.upload.path:uploads/seal-images}")
    private String uploadPath;

    @Value("${file.upload.url-prefix:/api/uploads}")
    private String urlPrefix;

    @Override
    public String uploadPdf(MultipartFile file) throws IOException {
        if (file.isEmpty()) {
            throw new IOException("请选择要上传的文件");
        }

        String originalFilename = file.getOriginalFilename();
        if (originalFilename == null || !originalFilename.toLowerCase().endsWith(".pdf")) {
            throw new IOException("只支持上传PDF格式的文件");
        }

        String datePath = new SimpleDateFormat("yyyy/MM/dd").format(new Date());
        String fileName = UUID.randomUUID().toString() + ".pdf";
        String relativePath = "pdf/" + datePath + "/" + fileName;

        Path uploadDir = Paths.get(uploadPath, "pdf", datePath);
        if (!Files.exists(uploadDir)) {
            Files.createDirectories(uploadDir);
        }

        Path filePath = uploadDir.resolve(fileName);
        Files.copy(file.getInputStream(), filePath);

        return urlPrefix + "/" + relativePath;
    }

    @Override
    public byte[] stampPdf(SealStampForm formData) throws IOException {
        Assert.notNull(formData.getPdfUrl(), "PDF文件URL不能为空");
        Assert.notNull(formData.getSealImageUrl(), "印章图片URL不能为空");

        String pdfPath = convertUrlToPath(formData.getPdfUrl());
        String sealImagePath = convertUrlToPath(formData.getSealImageUrl());

        PDDocument document = PDDocument.load(new File(pdfPath));
        PDPage page = document.getPage(0);
        PDRectangle pageSize = page.getMediaBox();

        float pageWidth = pageSize.getWidth();
        float pageHeight = pageSize.getHeight();

        BufferedImage sealImage;
        if (sealImagePath.startsWith("http://") || sealImagePath.startsWith("https://")) {
            sealImage = ImageIO.read(new URL(sealImagePath));
        } else {
            sealImage = ImageIO.read(new File(sealImagePath));
        }

        float imageAspectRatio = (float) sealImage.getWidth() / sealImage.getHeight();

        PDImageXObject pdImage = PDImageXObject.createFromByteArray(document,
            toByteArray(sealImage), "seal");

        try (PDPageContentStream contentStream = new PDPageContentStream(document, page,
                PDPageContentStream.AppendMode.APPEND, true, true)) {

            if (formData.getStamps() != null && !formData.getStamps().isEmpty()) {
                for (SealStampForm.StampInfo stampInfo : formData.getStamps()) {
                    float width = (stampInfo.getWidth() != null ? stampInfo.getWidth() : 15) / 100 * pageWidth;
                    float pdfHeight = width / imageAspectRatio;
                    float x = (stampInfo.getX() != null ? stampInfo.getX() : 80) / 100 * pageWidth;
                    float y = (stampInfo.getY() != null ? stampInfo.getY() : 80) / 100 * pageHeight;
					float pdfY = pageHeight - y - pdfHeight;
                    contentStream.drawImage(pdImage, x, pdfY, width, pdfHeight);
                }
            } else {
                float width = (formData.getWidth() != null ? formData.getWidth() : 15) / 100 * pageWidth;
                float pdfHeight = width / imageAspectRatio;
                float x = (formData.getX() != null ? formData.getX() : 80) / 100 * pageWidth;
                float y = (formData.getY() != null ? formData.getY() : 80) / 100 * pageHeight;
				float pdfY = pageHeight - y - pdfHeight;
                contentStream.drawImage(pdImage, x, pdfY, width, pdfHeight);
            }
        }

        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        document.save(outputStream);
        document.close();

        return outputStream.toByteArray();
    }

    private String convertUrlToPath(String url) {
        if (url.startsWith("http://") || url.startsWith("https://")) {
            return url;
        }
        if (url.startsWith("/api/uploads/")) {
            String relativePath = url.substring("/api/uploads/".length());
            return Paths.get(uploadPath, relativePath).toString();
        }
        if (url.startsWith("uploads/") || url.startsWith("uploads\\")) {
            String relativePath = url.startsWith("uploads/") ? url.substring("uploads/".length()) : url.substring("uploads\\".length());
            return Paths.get(uploadPath, relativePath).toString();
        }
        return Paths.get(uploadPath, url).toString();
    }

    private byte[] toByteArray(BufferedImage image) throws IOException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        javax.imageio.ImageIO.write(image, "PNG", baos);
        return baos.toByteArray();
    }
}
