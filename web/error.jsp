<%-- 
    Document   : error
    Created on : 02 jun 2026, 12:14:29
    Author     : thapelo
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Oops — Error</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="navbar">
        <a href="${pageContext.request.contextPath}/" class="logo">GROOT <span>CLOTHING</span></a>
    </div>

    <div class="container" style="text-align:center; padding:100px 20px;">
        <h1 style="font-size:80px; color:#e63946; margin-bottom:20px;">Oops!</h1>
        <h2 style="color:#1a1a1a; margin-bottom:20px;">Something went wrong</h2>
        <p style="color:#666; margin-bottom:30px;">
            <%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "The page you're looking for doesn't exist or an error occurred." %>
        </p>
        <a href="${pageContext.request.contextPath}/" class="btn btn-primary">Go Home</a>
    </div>
</body>
</html>
