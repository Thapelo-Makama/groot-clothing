<%-- 
    Document   : contact
    Created on :  06 may 2026, 21:00:43
    Author     : thapelo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Contact — Groot Clothing</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="navbar">
        <a href="${pageContext.request.contextPath}/" class="logo">GROOT <span>CLOTHING</span></a>
        <ul>
            <li><a href="${pageContext.request.contextPath}/">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/ShopServlet">Shop</a></li>
            <li><a href="${pageContext.request.contextPath}/EventsServlet">Events</a></li>
            <li><a href="${pageContext.request.contextPath}/ContactServlet">Contact</a></li>
            <% if (session.getAttribute("userId") != null) { %>
                <li><a href="${pageContext.request.contextPath}/LogoutServlet">Logout</a></li>
            <% } else { %>
                <li><a href="${pageContext.request.contextPath}/login.jsp" class="btn-nav">Login</a></li>
            <% } %>
        </ul>
    </div>

    <div class="container">
        <div class="section-title">
            <h2>Get In Touch</h2>
            <div class="divider"></div>
        </div>

        <div style="display:grid; grid-template-columns:1fr 1fr; gap:40px; max-width:1000px; margin:0 auto;">

            <!-- Contact Info -->
            <div>
                <h3 style="color:#1a1a1a; margin-bottom:25px;">Reach Out to Malokase</h3>

                <div style="background:#fff; padding:20px; border-radius:10px; margin-bottom:20px; box-shadow:0 2px 10px rgba(0,0,0,0.05);">
                    <p style="margin:0; color:#666; font-size:13px; text-transform:uppercase; letter-spacing:1px;">📍 Address</p>
                    <p style="margin:5px 0 0; font-size:16px; font-weight:600;">Line 5, Marble Hall, 0450</p>
                </div>

                <div style="background:#fff; padding:20px; border-radius:10px; margin-bottom:20px; box-shadow:0 2px 10px rgba(0,0,0,0.05);">
                    <p style="margin:0; color:#666; font-size:13px; text-transform:uppercase; letter-spacing:1px;">📞 Phone</p>
                    <p style="margin:5px 0 0; font-size:16px; font-weight:600;">
                        <a href="tel:0722027820" style="color:#e63946; text-decoration:none;">072 202 7820</a>
                    </p>
                </div>

                <div style="background:#fff; padding:20px; border-radius:10px; margin-bottom:20px; box-shadow:0 2px 10px rgba(0,0,0,0.05);">
                    <p style="margin:0; color:#666; font-size:13px; text-transform:uppercase; letter-spacing:1px;">💬 WhatsApp</p>
                    <p style="margin:5px 0 0; font-size:16px; font-weight:600;">
                        <a href="https://wa.me/27722027820" target="_blank" style="color:#25D366; text-decoration:none;">
                            Chat with us on WhatsApp
                        </a>
                    </p>
                </div>

                <div style="background:#fff; padding:20px; border-radius:10px; margin-bottom:20px; box-shadow:0 2px 10px rgba(0,0,0,0.05);">
                    <p style="margin:0; color:#666; font-size:13px; text-transform:uppercase; letter-spacing:1px;">✉️ Email</p>
                    <p style="margin:5px 0 0; font-size:16px; font-weight:600;">
                        <a href="mailto:kmalokase77@gmail.com" style="color:#e63946; text-decoration:none;">
                            kmalokase77@gmail.com
                        </a>
                    </p>
                </div>
            </div>

            <!-- Contact Form -->
            <div class="form-container" style="margin:0; max-width:100%;">
                <h3 style="text-align:center; margin-bottom:25px;">Send Us a Message</h3>

                <% String success = (String) request.getAttribute("success"); %>
                <% if (success != null) { %>
                    <div class="alert alert-success"><%= success %></div>
                <% } %>
                <% String error = (String) request.getAttribute("error"); %>
                <% if (error != null) { %>
                    <div class="alert alert-error"><%= error %></div>
                <% } %>

                <form method="POST" action="${pageContext.request.contextPath}/ContactServlet">
                    <div class="form-group">
                        <label>Your Name *</label>
                        <input type="text" name="name" required>
                    </div>
                    <div class="form-group">
                        <label>Email *</label>
                        <input type="email" name="email" required>
                    </div>
                    <div class="form-group">
                        <label>Phone</label>
                        <input type="tel" name="phone">
                    </div>
                    <div class="form-group">
                        <label>Subject</label>
                        <input type="text" name="subject">
                    </div>
                    <div class="form-group">
                        <label>Message *</label>
                        <textarea name="message" rows="5" required></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary">Send Message</button>
                </form>
            </div>
        </div>
    </div>

    <footer class="footer">
        <div class="footer-bottom">
            © 2026 Groot Clothing Brand. Owned by Malokase. Marble Hall, Limpopo.
        </div>
    </footer>
</body>
</html>