/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package groot.servlet;

import groot.dao.NotificationDAO;
import groot.dao.UserDAO;
import groot.entity.Notification;
import groot.entity.User;
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


@WebServlet("/AdminUserServlet")
public class AdminUserServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();
    private final NotificationDAO notifDAO = new NotificationDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        req.setAttribute("users", userDAO.findAll());
        req.setAttribute("pendingUsers", userDAO.findPending());
        req.getRequestDispatcher("/admin/users.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        String userIdStr = req.getParameter("userId");

        if (userIdStr == null || action == null) {
            res.sendRedirect(req.getContextPath() + "/AdminUserServlet");
            return;
        }

        Integer userId = Integer.parseInt(userIdStr);
        HttpSession session = req.getSession(false);
        Integer currentAdminId = (Integer) session.getAttribute("userId");

        try {
            User user = userDAO.findById(userId);
            if (user == null) {
                res.sendRedirect(req.getContextPath() + "/AdminUserServlet");
                return;
            }

            switch (action) {
                case "approve":
                    user.setIsApproved(true);
                    userDAO.update(user);

                    Notification notif = new Notification();
                    notif.setUser(user);
                    notif.setTitle("Account Approved");
                    notif.setMessage("Your account has been approved. You can now login and shop!");
                    notif.setType("success");
                    notifDAO.save(notif);
                    break;

                case "reject":
                case "delete":
                    if (user.getId().equals(currentAdminId)) break;
                    userDAO.delete(userId);
                    break;

                case "toggleBan":
                    if (user.getId().equals(currentAdminId)) break;
                    user.setIsBanned(!Boolean.TRUE.equals(user.getIsBanned()));
                    userDAO.update(user);
                    break;
            }
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
        }

        res.sendRedirect(req.getContextPath() + "/AdminUserServlet");
    }
}