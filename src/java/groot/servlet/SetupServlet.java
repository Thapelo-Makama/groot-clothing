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

/**
 *
 * @author thapelo
 */




@WebServlet("/setup")
public class SetupServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        if (userDAO.adminExists()) {
            res.sendRedirect(req.getContextPath() + "/login.jsp?error=setup_locked");
            return;
        }
        req.getRequestDispatcher("/setup.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        if (userDAO.adminExists()) {
            res.sendRedirect(req.getContextPath() + "/login.jsp?error=setup_locked");
            return;
        }

        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String fullName = req.getParameter("fullName");
        String phone = req.getParameter("phone");
        String city = req.getParameter("city");
        String password = req.getParameter("password");
        String confirm = req.getParameter("confirmPassword");

        if (username == null || username.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            password == null || password.isEmpty()) {
            req.setAttribute("error", "All required fields must be filled");
            req.getRequestDispatcher("/setup.jsp").forward(req, res);
            return;
        }

        if (!password.equals(confirm)) {
            req.setAttribute("error", "Passwords do not match");
            req.getRequestDispatcher("/setup.jsp").forward(req, res);
            return;
        }

        if (password.length() < 8) {
            req.setAttribute("error", "Password must be at least 8 characters");
            req.getRequestDispatcher("/setup.jsp").forward(req, res);
            return;
        }

        try {
            User admin = new User();
            admin.setUsername(username.trim());
            admin.setEmail(email.trim());
            admin.setFullName(fullName);
            admin.setPhone(phone);
            admin.setCity(city);
            admin.setPasswordHash(PasswordUtil.hashPassword(password));
            admin.setIsAdmin(true);
            admin.setIsApproved(true);
            admin.setIsBanned(false);

            userDAO.save(admin);
            res.sendRedirect(req.getContextPath() + "/login.jsp?setup=success");

        } catch (Exception e) {
            req.setAttribute("error", "Setup failed: " + e.getMessage());
            req.getRequestDispatcher("/setup.jsp").forward(req, res);
        }
    }
}