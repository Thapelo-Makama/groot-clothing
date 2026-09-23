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


@WebServlet("/ContactServlet")
public class ContactServlet extends HttpServlet {

    private final MessageDAO messageDAO = new MessageDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.getRequestDispatcher("/contact.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String subject = req.getParameter("subject");
        String messageText = req.getParameter("message");

        if (name == null || name.trim().isEmpty()
                || email == null || email.trim().isEmpty()
                || messageText == null || messageText.trim().isEmpty()) {
            req.setAttribute("error", "Please fill in all required fields");
            req.getRequestDispatcher("/contact.jsp").forward(req, res);
            return;
        }

        try {
            Message msg = new Message();
            msg.setName(name.trim());
            msg.setEmail(email.trim());
            msg.setPhone(phone);
            msg.setSubject(subject);
            msg.setMessage(messageText.trim());
            msg.setIsRead(false);
            msg.setIsReplied(false);

            messageDAO.save(msg);

            req.setAttribute("success", "Thank you! Your message has been sent. We'll get back to you soon.");
            req.getRequestDispatcher("/contact.jsp").forward(req, res);

        } catch (Exception e) {
            req.setAttribute("error", "Failed to send message: " + e.getMessage());
            req.getRequestDispatcher("/contact.jsp").forward(req, res);
        }
    }
}