<%-- 
    Document   : setup
    Created on : 04 may 2026, 11:31:47
    Author     : thapelo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Setup Admin Account — Groot Clothing</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="navbar">
        <a href="${pageContext.request.contextPath}/" class="logo">GROOT <span>CLOTHING</span></a>
    </div>

    <div class="form-container">
        <h2>🎉 Welcome to Groot Clothing</h2>
        <p style="text-align:center; color:#666; margin-bottom:30px;">
            Create the admin account for <strong>Malokase</strong>. This form only appears once.
        </p>

        <% String error = (String) request.getAttribute("error"); %>
        <% if (error != null) { %>
            <div class="alert alert-error"><%= error %></div>
        <% } %>

        <form method="POST" action="${pageContext.request.contextPath}/setup">
            <div class="form-group">
                <label>Username *</label>
                <input type="text" name="username" required placeholder="malokase">
            </div>
            <div class="form-group">
                <label>Email *</label>
                <input type="email" name="email" required placeholder="kmalokase77@gmail.com">
            </div>
            <div class="form-group">
                <label>Full Name *</label>
                <input type="text" name="fullName" required placeholder="Malokase">
            </div>
            <div class="form-group">
                <label>Phone</label>
                <input type="tel" name="phone" placeholder="0722027820">
            </div>
            <div class="form-group">
                <label>City</label>
                <input type="text" name="city" placeholder="Marble Hall">
            </div>
            <div class="form-group">
                <label>Password * (min 8 chars)</label>
                <input type="password" name="password" required minlength="8">
            </div>
            <div class="form-group">
                <label>Confirm Password *</label>
                <input type="password" name="confirmPassword" required minlength="8">
            </div>
            <button type="submit" class="btn btn-primary">Create Admin Account</button>
        </form>
    </div>
</body>
</html>
