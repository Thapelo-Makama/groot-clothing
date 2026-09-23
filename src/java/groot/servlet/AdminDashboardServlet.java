/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package groot.servlet;

import groot.dao.*;
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


@WebServlet("/AdminDashboardServlet")
public class AdminDashboardServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();
    private final ProductDAO productDAO = new ProductDAO();
    private final EventDAO eventDAO = new EventDAO();
    private final OrderDAO orderDAO = new OrderDAO();
    private final MessageDAO messageDAO = new MessageDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        try {
            req.setAttribute("totalUsers", userDAO.countAll());
            req.setAttribute("totalProducts", productDAO.countAll());
            req.setAttribute("pendingUsers", (long) userDAO.findPending().size());
            req.setAttribute("totalEvents", (long) eventDAO.findAll().size());
            req.setAttribute("totalOrders", orderDAO.countAll());
            req.setAttribute("unreadMessages", messageDAO.countUnread());
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
        }

        req.getRequestDispatcher("/admin/dashboard.jsp").forward(req, res);
    }
}