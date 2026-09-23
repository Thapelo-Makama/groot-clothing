/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package groot.servlet;

import groot.dao.UserDAO;
import groot.entity.User;
import java.io.IOException;
import java.util.Date;
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


@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        res.sendRedirect(req.getContextPath() + "/login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        if (username == null || password == null || username.trim().isEmpty()) {
            req.setAttribute("error", "Please enter username and password");
            req.getRequestDispatcher("/login.jsp").forward(req, res);
            return;
        }

        try {
            User user = userDAO.authenticate(username.trim(), password);

            if (user == null) {
                req.setAttribute("error", "Invalid username or password");
                req.getRequestDispatcher("/login.jsp").forward(req, res);
                return;
            }

            // Update last login
            user.setLastLogin(new Date());
            userDAO.update(user);

            // Create session
            HttpSession session = req.getSession(true);
            session.setAttribute("userId", user.getId());
            session.setAttribute("username", user.getUsername());
            session.setAttribute("fullName", user.getFullName());
            session.setAttribute("isAdmin", user.getIsAdmin());
            session.setAttribute("isApproved", user.getIsApproved());
            session.setMaxInactiveInterval(30 * 60); // 30 minutes

            // Redirect
            if (Boolean.TRUE.equals(user.getIsAdmin())) {
                res.sendRedirect(req.getContextPath() + "/AdminDashboardServlet");
            } else {
                res.sendRedirect(req.getContextPath() + "/HomeServlet");
            }

        } catch (Exception e) {
            req.setAttribute("error", "Login error: " + e.getMessage());
            req.getRequestDispatcher("/login.jsp").forward(req, res);
        }
    }
}