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

/**
 *
 * @author thapelo
 */


@WebFilter(urlPatterns = {"/*"})
public class SetupRedirectFilter implements Filter {

    private final UserDAO userDAO = new UserDAO();

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        String ctx = req.getContextPath();
        String path = req.getRequestURI().substring(ctx.length());

        // Paths that should NEVER be redirected
        if (path.startsWith("/setup")
                || path.startsWith("/css")
                || path.startsWith("/js")
                || path.startsWith("/images")
                || path.startsWith("/uploads")
                || path.startsWith("/favicon")) {
            chain.doFilter(request, response);
            return;
        }

        // Check if admin exists
        try {
            if (!userDAO.adminExists()) {
                res.sendRedirect(ctx + "/setup");
                return;
            }
        } catch (Exception e) {
            // If DB error, allow through (avoid redirect loop)
            chain.doFilter(request, response);
            return;
        }

        chain.doFilter(request, response);
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("✅ SetupRedirectFilter initialized");
    }

    @Override
    public void destroy() {
        System.out.println("❌ SetupRedirectFilter destroyed");
    }
}
