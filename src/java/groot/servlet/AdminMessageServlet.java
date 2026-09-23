/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package groot.servlet;

import groot.dao.MessageDAO;
import groot.entity.Message;
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

@WebServlet("/AdminMessageServlet")
public class AdminMessageServlet extends HttpServlet {

    private final MessageDAO messageDAO = new MessageDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setAttribute("messages", messageDAO.findAll());
        req.getRequestDispatcher("/admin/messages.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        String messageIdStr = req.getParameter("messageId");

        if (messageIdStr == null || action == null) {
            res.sendRedirect(req.getContextPath() + "/AdminMessageServlet");
            return;
        }

        Integer messageId = Integer.parseInt(messageIdStr);

        try {
            if ("toggleRead".equals(action)) {
                Message m = messageDAO.findById(messageId);
                if (m != null) {
                    m.setIsRead(!Boolean.TRUE.equals(m.getIsRead()));
                    messageDAO.update(m);
                }
            } else if ("delete".equals(action)) {
                messageDAO.delete(messageId);
            }
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
        }

        res.sendRedirect(req.getContextPath() + "/AdminMessageServlet");
    }
}
