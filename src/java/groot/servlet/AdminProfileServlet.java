/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package groot.servlet;

import groot.dao.UserDAO;
import groot.entity.User;
import groot.util.PasswordUtil;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


/**
 *
 * @author thapelo
 */

@WebServlet("/AdminProfileServlet")
public class AdminProfileServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        Integer adminId = (Integer) session.getAttribute("userId");

        User admin = userDAO.findById(adminId);
        if (admin != null) {
            req.setAttribute("adminFullName", admin.getFullName());
            req.setAttribute("adminEmail", admin.getEmail());
            req.setAttribute("adminPhone", admin.getPhone());
            req.setAttribute("adminCity", admin.getCity());
        }

        req.getRequestDispatcher("/admin/profile.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        HttpSession session = req.getSession(false);
        Integer adminId = (Integer) session.getAttribute("userId");

        User admin = userDAO.findById(adminId);
        if (admin == null) {
            res.sendRedirect(req.getContextPath() + "/LoginServlet");
            return;
        }

        try {
            if ("updateProfile".equals(action)) {
                admin.setFullName(req.getParameter("fullName"));
                admin.setEmail(req.getParameter("email"));
                admin.setPhone(req.getParameter("phone"));
                admin.setCity(req.getParameter("city"));
                userDAO.update(admin);

                session.setAttribute("fullName", admin.getFullName());
                req.setAttribute("success", "Profile updated successfully!");

            } else if ("changePassword".equals(action)) {
                String currentPw = req.getParameter("currentPassword");
                String newPw = req.getParameter("newPassword");
                String confirmPw = req.getParameter("confirmPassword");

                if (!PasswordUtil.verifyPassword(currentPw, admin.getPasswordHash())) {
                    req.setAttribute("error", "Current password is incorrect");
                } else if (!newPw.equals(confirmPw)) {
                    req.setAttribute("error", "New passwords do not match");
                } else if (newPw.length() < 8) {
                    req.setAttribute("error", "Password must be at least 8 characters");
                } else {
                    admin.setPasswordHash(PasswordUtil.hashPassword(newPw));
                    userDAO.update(admin);
                    req.setAttribute("success", "Password changed successfully!");
                }
            }
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
        }

        // Reload fresh data for display
        admin = userDAO.findById(adminId);
        req.setAttribute("adminFullName", admin.getFullName());
        req.setAttribute("adminEmail", admin.getEmail());
        req.setAttribute("adminPhone", admin.getPhone());
        req.setAttribute("adminCity", admin.getCity());

        req.getRequestDispatcher("/admin/profile.jsp").forward(req, res);
    }
}
