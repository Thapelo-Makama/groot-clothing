/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package groot.filter;

import groot.dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author thapelo
 */


@WebFilter(urlPatterns = {"/admin/*"})
public class AuthFilter implements Filter {

    private final UserDAO userDAO = new UserDAO();

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        String ctx = req.getContextPath();
        String path = req.getRequestURI().substring(ctx.length());

        // Allow setup, login, register pages through
        if (path.startsWith("/setup") 
                || path.startsWith("/login") 
                || path.startsWith("/register")
                || path.startsWith("/css")
                || path.startsWith("/js")
                || path.startsWith("/images")
                || path.startsWith("/uploads")) {
            chain.doFilter(request, response);
            return;
        }

        // If no admin exists, force setup
        try {
            if (!userDAO.adminExists()) {
                res.sendRedirect(ctx + "/setup");
                return;
            }
        } catch (Exception e) {
            // DB not ready — allow through
            chain.doFilter(request, response);
            return;
        }

        // Check if user is logged in AND is admin
        HttpSession session = req.getSession(false);
        boolean isAdmin = (session != null 
                && Boolean.TRUE.equals(session.getAttribute("isAdmin"))
                && session.getAttribute("userId") != null);

        if (!isAdmin) {
            res.sendRedirect(ctx + "/login.jsp?error=admin_required");
            return;
        }

        chain.doFilter(request, response);
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("✅ AuthFilter initialized");
    }

    @Override
    public void destroy() {
        System.out.println("❌ AuthFilter destroyed");
    }
}