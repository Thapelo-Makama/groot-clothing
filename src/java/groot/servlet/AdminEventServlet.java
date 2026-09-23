/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package groot.servlet;

import groot.dao.EventDAO;
import groot.dao.EventPhotoDAO;
import groot.entity.Event;
import groot.entity.EventPhoto;
import groot.util.FileUploadUtil;
import groot.util.SlugUtil;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

/**
 *
 * @author thapelo
 */


@WebServlet("/AdminEventServlet")
@MultipartConfig(maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 50)
public class AdminEventServlet extends HttpServlet {

    private final EventDAO eventDAO = new EventDAO();
    private final EventPhotoDAO photoDAO = new EventPhotoDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setAttribute("events", eventDAO.findAll());
        req.getRequestDispatcher("/admin/events.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        try {
            if ("create".equals(action)) {
                handleCreate(req, res);
            } else if ("addPhoto".equals(action)) {
                handleAddPhoto(req, res);
            } else if ("deletePhoto".equals(action)) {
                handleDeletePhoto(req, res);
            } else if ("delete".equals(action)) {
                handleDelete(req, res);
            }
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.setAttribute("events", eventDAO.findAll());
            req.getRequestDispatcher("/admin/events.jsp").forward(req, res);
        }
    }

    private void handleCreate(HttpServletRequest req, HttpServletResponse res) throws Exception {
        Event event = new Event();
        event.setTitle(req.getParameter("title"));
        event.setSlug(SlugUtil.toSlug(req.getParameter("title")) + "-" + System.currentTimeMillis());
        event.setDescription(req.getParameter("description"));
        event.setVenue(req.getParameter("venue"));
        event.setCity(req.getParameter("city"));

        String dateStr = req.getParameter("eventDate");
        if (dateStr != null && !dateStr.isEmpty()) {
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                event.setEventDate(sdf.parse(dateStr));
            } catch (Exception ignored) {}
        }

        event.setIsPublished(true);
        eventDAO.save(event);

        // Save photos
        for (Part photoPart : req.getParts()) {
            if (photoPart.getName().equals("photos") && photoPart.getSize() > 0) {
                String path = FileUploadUtil.saveUploadedFile(photoPart, "events");
                if (path != null) {
                    EventPhoto photo = new EventPhoto();
                    photo.setEvent(event);
                    photo.setImagePath(path);
                    photoDAO.save(photo);
                }
            }
        }

        res.sendRedirect(req.getContextPath() + "/AdminEventServlet?success=created");
    }

    private void handleAddPhoto(HttpServletRequest req, HttpServletResponse res) throws Exception {
        Integer eventId = Integer.parseInt(req.getParameter("eventId"));
        Event event = eventDAO.findById(eventId);

        if (event != null) {
            Part photoPart = req.getPart("photo");
            if (photoPart != null && photoPart.getSize() > 0) {
                String path = FileUploadUtil.saveUploadedFile(photoPart, "events");
                if (path != null) {
                    EventPhoto photo = new EventPhoto();
                    photo.setEvent(event);
                    photo.setImagePath(path);
                    photo.setCaption(req.getParameter("caption"));
                    photoDAO.save(photo);
                }
            }
        }

        res.sendRedirect(req.getContextPath() + "/AdminEventServlet?success=photoAdded");
    }

    private void handleDeletePhoto(HttpServletRequest req, HttpServletResponse res) throws Exception {
        Integer photoId = Integer.parseInt(req.getParameter("photoId"));
        EventPhoto photo = photoDAO.findById(photoId);

        if (photo != null) {
            FileUploadUtil.deleteUploadedFile(photo.getImagePath());
            photoDAO.delete(photoId);
        }

        res.sendRedirect(req.getContextPath() + "/AdminEventServlet?success=photoDeleted");
    }

    private void handleDelete(HttpServletRequest req, HttpServletResponse res) throws Exception {
        Integer eventId = Integer.parseInt(req.getParameter("eventId"));
        eventDAO.delete(eventId);
        res.sendRedirect(req.getContextPath() + "/AdminEventServlet?success=deleted");
    }
}