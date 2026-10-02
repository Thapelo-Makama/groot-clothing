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
 * Portable file upload utility. Detects the runtime environment and writes
 * uploads into the correct webapp folder so files can be served immediately.
 *
 * Local dev (NetBeans context):  /home/thapelo/NetBeansProjects/GrootClothing/build/web/uploads
 * Local Tomcat  (GrootClothing): /home/thapelo/tomcat10/webapps/GrootClothing/uploads
 * Render (Docker ROOT deploy):   /usr/local/tomcat/webapps/ROOT/uploads
 *
 * @author thapelo
 */
public class FileUploadUtil {

    public static String getUploadDir() {
        String catalinaBase = System.getProperty("catalina.base");

        // ---- Production (Render / Docker) ----
        if (catalinaBase != null) {
            // Render deploys as ROOT.war → webapps/ROOT/
            File rootWebapp = new File(catalinaBase, 
                "webapps" + File.separator + "ROOT");
            if (rootWebapp.exists() && rootWebapp.isDirectory()) {
                return rootWebapp.getAbsolutePath() + File.separator + "uploads";
            }

            // Local Tomcat with NetBeans context → webapps/GrootClothing/
            File gcWebapp = new File(catalinaBase, 
                "webapps" + File.separator + "GrootClothing");
            if (gcWebapp.exists() && gcWebapp.isDirectory()) {
                return gcWebapp.getAbsolutePath() + File.separator + "uploads";
            }
        }

        // ---- Local development fallback (NetBeans docBase points here) ----
        return "/home/thapelo/NetBeansProjects/GrootClothing/build/web/uploads";
    }

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

        // Relative path used in JSP: <img src="${pageContext.request.contextPath}/uploads/...">
        if (subFolder != null && !subFolder.isEmpty()) {
            return "/uploads/" + subFolder + "/" + uniqueName;
        }
        return "/uploads/" + uniqueName;
    }

    public static void deleteUploadedFile(String relativePath) {
        if (relativePath == null || relativePath.isEmpty()) return;

        String clean = relativePath.replaceFirst("^/uploads/", "");
        File file = new File(getUploadDir(), clean);
        if (file.exists()) {
            file.delete();
        }
    }
}
