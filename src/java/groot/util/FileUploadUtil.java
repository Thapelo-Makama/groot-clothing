/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package groot.util;

import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

/**
 *
 * @author thapelo
 */
public class FileUploadUtil {

    /**
     * Resolves the /uploads folder inside the deployed web application.
     * Since Tomcat's context points docBase at build/web, we write directly
     * into build/web/uploads so images are served at:
     *   http://localhost:8080/GrootClothing/uploads/products/xyz.jpg
     */
    public static String getUploadDir() {
        // Primary: write into the app's build folder (Tomcat's docBase)
        String buildWebPath = "/home/thapelo/NetBeansProjects/GrootClothing/build/web/uploads";

        // Fallback: write into catalina.base/webapps/GrootClothing/uploads
        String catalinaBase = System.getProperty("catalina.base");
        if (catalinaBase != null) {
            File buildDir = new File(buildWebPath);
            if (buildDir.getParentFile() != null && buildDir.getParentFile().exists()) {
                return buildWebPath;
            }
            return catalinaBase + File.separator + "webapps"
                 + File.separator + "GrootClothing"
                 + File.separator + "uploads";
        }

        // Final fallback: current working directory
        return System.getProperty("user.dir") + File.separator + "uploads";
    }

    /**
     * Saves an uploaded file into the app's /uploads/<subFolder>/ directory.
     * Returns a relative path like "/uploads/products/abc123.jpg"
     * which can be used directly in JSP as:
     *   src="${pageContext.request.contextPath}/uploads/products/abc123.jpg"
     */
    public static String saveUploadedFile(Part filePart, String subFolder) throws IOException {
        if (filePart == null || filePart.getSize() == 0) return null;

        String originalName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String extension = "";
        int dot = originalName.lastIndexOf('.');
        if (dot > 0) extension = originalName.substring(dot);

        String uniqueName = UUID.randomUUID().toString() + extension;

        String targetDir = getUploadDir();
        if (subFolder != null && !subFolder.isEmpty()) {
            targetDir += File.separator + subFolder;
        }

        File dir = new File(targetDir);
        if (!dir.exists()) {
            boolean created = dir.mkdirs();
            if (!created) {
                throw new IOException("Could not create upload directory: " + targetDir);
            }
        }

        File targetFile = new File(dir, uniqueName);

        try (InputStream input = filePart.getInputStream()) {
            Files.copy(input, targetFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
        }

        // Return the relative path used in JSP: <img src="${pageContext.request.contextPath}/uploads/...">
        if (subFolder != null && !subFolder.isEmpty()) {
            return "/uploads/" + subFolder + "/" + uniqueName;
        }
        return "/uploads/" + uniqueName;
    }

    /**
     * Deletes an uploaded file by its stored relative path.
     */
    public static void deleteUploadedFile(String relativePath) {
        if (relativePath == null || relativePath.isEmpty()) return;

        String clean = relativePath.replaceFirst("^/uploads/", "");
        File file = new File(getUploadDir(), clean);
        if (file.exists()) {
            file.delete();
        }
    }
}