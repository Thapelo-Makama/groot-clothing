<%-- 
    Document   : register
    Created on : 04 may 2026, 18:31:47
    Author     : thapelo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register — Groot Clothing</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="navbar">
        <a href="${pageContext.request.contextPath}/" class="logo">GROOT <span>CLOTHING</span></a>
        <ul>
            <li><a href="${pageContext.request.contextPath}/">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/ShopServlet">Shop</a></li>
            <li><a href="${pageContext.request.contextPath}/EventsServlet">Events</a></li>
            <li><a href="${pageContext.request.contextPath}/login.jsp" class="btn-nav">Login</a></li>
        </ul>
    </div>

    <div class="form-container">
        <h2>Join Groot Clothing</h2>
        <p style="text-align:center; color:#666; margin-bottom:20px; font-size:14px;">
            Your account will be reviewed by admin before activation.
        </p>

        <% String error = (String) request.getAttribute("error"); %>
        <% if (error != null) { %>
            <div class="alert alert-error"><%= error %></div>
        <% } %>
        <% String success = (String) request.getAttribute("success"); %>
        <% if (success != null) { %>
            <div class="alert alert-success"><%= success %></div>
        <% } %>

        <form method="POST" action="${pageContext.request.contextPath}/RegisterServlet">
            <div class="form-group">
                <label>Username *</label>
                <input type="text" name="username" required minlength="3">
            </div>
            <div class="form-group">
                <label>Email *</label>
                <input type="email" name="email" required>
            </div>
            <div class="form-group">
                <label>Full Name</label>
                <input type="text" name="fullName">
            </div>
            <div class="form-group">
                <label>Phone</label>
                <input type="tel" name="phone">
            </div>
            <div class="form-group">
                <label>City</label>
                <input type="text" name="city">
            </div>
            <div class="form-group">
                <label>Address</label>
                <textarea name="address" rows="2"></textarea>
            </div>
            <div class="form-group">
                <label>Password * (min 8 chars)</label>
                <input type="password" name="password" required minlength="8">
            </div>
            <div class="form-group">
                <label>Confirm Password *</label>
                <input type="password" name="confirmPassword" required minlength="8">
            </div>
            <button type="submit" class="btn btn-primary">Register</button>
        </form>

        <p style="text-align:center; margin-top:20px; color:#666;">
            Already have an account?
            <a href="${pageContext.request.contextPath}/login.jsp" style="color: #e63946;">Login here</a>
        </p>
    </div>
</body>
</html>
