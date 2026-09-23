<%-- 
    Document   : index
    Created on : 04 may 2026, 10:31:47
    Author     : thapelo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Groot Clothing — Style Meets Culture</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="navbar">
        <a href="${pageContext.request.contextPath}/" class="logo">GROOT <span>CLOTHING</span></a>
        <ul>
            <li><a href="${pageContext.request.contextPath}/">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/ShopServlet">Shop</a></li>
            <li><a href="${pageContext.request.contextPath}/EventsServlet">Events</a></li>
            <li><a href="${pageContext.request.contextPath}/about.jsp">About</a></li>
            <li><a href="${pageContext.request.contextPath}/ContactServlet">Contact</a></li>
            <% if (session.getAttribute("userId") != null) { %>
                <% if (Boolean.TRUE.equals(session.getAttribute("isAdmin"))) { %>
                    <li><a href="${pageContext.request.contextPath}/AdminDashboardServlet">Admin</a></li>
                <% } %>
                <li><a href="${pageContext.request.contextPath}/LogoutServlet">Logout</a></li>
            <% } else { %>
                <li><a href="${pageContext.request.contextPath}/login.jsp" class="btn-nav">Login</a></li>
            <% } %>
        </ul>
    </div>

    <section class="hero">
        <h1>GROOT <span class="accent">CLOTHING</span></h1>
        <p>Style meets culture. Proudly South African.</p>
        <p style="font-size:15px; opacity:0.8; margin-top:-15px;">
            Home of <strong>Groot Annually</strong> — Youth Talent Showcase at Moutse West
        </p>
        <div class="btn-group">
            <a href="${pageContext.request.contextPath}/ShopServlet" class="btn btn-primary">Shop Now</a>
            <a href="${pageContext.request.contextPath}/EventsServlet" class="btn btn-outline">View Events</a>
        </div>
    </section>

    <div class="container">
        <div class="section-title">
            <h2>Welcome</h2>
            <div class="divider"></div>
        </div>
        <p style="text-align:center; max-width:700px; margin:0 auto; font-size:17px; color:#555;">
            Groot Clothing is a South African fashion brand based in Marble Hall. We design bold, 
            culturally inspired clothing and host the annual <strong>Groot Annually</strong> youth 
            talent showcase at Moutse West — empowering young dancers, models, and fashion designers.
        </p>
    </div>

    <footer class="footer">
        <div class="footer-content">
            <div>
                <h4>GROOT CLOTHING</h4>
                <p>Bold African fashion. Made with pride in Marble Hall, Limpopo.</p>
            </div>
            <div>
                <h4>Contact</h4>
                <p>📍 Line 5, Marble Hall, 0450</p>
                <p>📞 072 202 7820</p>
                <p>✉️ kmalokase77@gmail.com</p>
            </div>
            <div>
                <h4>Quick Links</h4>
                <p><a href="${pageContext.request.contextPath}/ShopServlet">Shop</a></p>
                <p><a href="${pageContext.request.contextPath}/EventsServlet">Events</a></p>
                <p><a href="${pageContext.request.contextPath}/about.jsp">About</a></p>
                <p><a href="${pageContext.request.contextPath}/ContactServlet">Contact</a></p>
            </div>
        </div>
        <div class="footer-bottom">
            © 2026 Groot Clothing Brand. All rights reserved. Owned by Malokase.
        </div>
    </footer>
</body>
</html>