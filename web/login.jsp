<%-- 
    Document   : login
    Created on : 04 may 2026, 14:31:47
    Author     : thapelo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login — Groot Clothing</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="navbar">
        <a href="${pageContext.request.contextPath}/" class="logo">GROOT <span>CLOTHING</span></a>
        <ul>
            <li><a href="${pageContext.request.contextPath}/">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/ShopServlet">Shop</a></li>
            <li><a href="${pageContext.request.contextPath}/EventsServlet">Events</a></li>
            <li><a href="${pageContext.request.contextPath}/register.jsp" class="btn-nav">Register</a></li>
        </ul>
    </div>

    <div class="form-container">
        <h2>Login to Groot Clothing</h2>

        <% if (request.getParameter("setup") != null) { %>
            <div class="alert alert-success">✅ Setup complete! Please login with your admin credentials.</div>
        <% } %>
        <% if (request.getParameter("logout") != null) { %>
            <div class="alert alert-info">You have been logged out.</div>
        <% } %>
        <% if (request.getParameter("error") != null) { %>
            <div class="alert alert-error">
                <% 
                    String err = request.getParameter("error");
                    if ("admin_required".equals(err)) out.print("Please login as admin.");
                    else if ("setup_locked".equals(err)) out.print("Setup already completed.");
                    else out.print("An error occurred.");
                %>
            </div>
        <% } %>
        <% String error = (String) request.getAttribute("error"); %>
        <% if (error != null) { %>
            <div class="alert alert-error"><%= error %></div>
        <% } %>

        <form method="POST" action="${pageContext.request.contextPath}/LoginServlet">
            <div class="form-group">
                <label>Username</label>
                <input type="text" name="username" required placeholder="Enter your username">
            </div>
            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" required placeholder="Enter your password">
            </div>
            <button type="submit" class="btn btn-primary">Login</button>
        </form>

        <p style="text-align:center; margin-top:20px; color:#666;">
            Don't have an account?
            <a href="${pageContext.request.contextPath}/register.jsp" style="color: #e63946;">Register here</a>
        </p>
    </div>
</body>
</html>