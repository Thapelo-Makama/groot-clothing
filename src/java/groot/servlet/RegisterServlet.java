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


@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        res.sendRedirect(req.getContextPath() + "/register.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String fullName = req.getParameter("fullName");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");
        String city = req.getParameter("city");
        String password = req.getParameter("password");
        String confirm = req.getParameter("confirmPassword");

        // Validate
        if (username == null || username.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            password == null || password.isEmpty()) {
            req.setAttribute("error", "All required fields must be filled");
            req.getRequestDispatcher("/register.jsp").forward(req, res);
            return;
        }

        if (!password.equals(confirm)) {
            req.setAttribute("error", "Passwords do not match");
            req.getRequestDispatcher("/register.jsp").forward(req, res);
            return;
        }

        if (password.length() < 8) {
            req.setAttribute("error", "Password must be at least 8 characters");
            req.getRequestDispatcher("/register.jsp").forward(req, res);
            return;
        }

        // Check if username or email already exists
        if (userDAO.findByUsername(username.trim()) != null) {
            req.setAttribute("error", "Username already taken");
            req.getRequestDispatcher("/register.jsp").forward(req, res);
            return;
        }

        if (userDAO.findByEmail(email.trim()) != null) {
            req.setAttribute("error", "Email already registered");
            req.getRequestDispatcher("/register.jsp").forward(req, res);
            return;
        }

        try {
            User user = new User();
            user.setUsername(username.trim());
            user.setEmail(email.trim());
            user.setFullName(fullName);
            user.setPhone(phone);
            user.setAddress(address);
            user.setCity(city);
            user.setPasswordHash(PasswordUtil.hashPassword(password));
            user.setIsAdmin(false);
            user.setIsApproved(false);   // ← Needs admin approval
            user.setIsBanned(false);

            userDAO.save(user);

            req.setAttribute("success", 
                "Registration successful! Please wait for admin approval before logging in.");
            req.getRequestDispatcher("/register.jsp").forward(req, res);

        } catch (Exception e) {
            req.setAttribute("error", "Registration failed: " + e.getMessage());
            req.getRequestDispatcher("/register.jsp").forward(req, res);
        }
    }
}