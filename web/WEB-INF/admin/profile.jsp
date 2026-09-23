<%-- 
    Document   : profile
    Created on : 22 may 2026, 18:07:26
    Author     : thapelo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Profile — Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="admin-layout">
        <div class="admin-sidebar">
            <h3>GROOT ADMIN</h3>
            <a href="${pageContext.request.contextPath}/AdminDashboardServlet">📊 Dashboard</a>
            <a href="${pageContext.request.contextPath}/AdminProductServlet">👕 Products</a>
            <a href="${pageContext.request.contextPath}/AdminUserServlet">👥 Users</a>
            <a href="${pageContext.request.contextPath}/AdminEventServlet">🎉 Events</a>
            <a href="${pageContext.request.contextPath}/AdminMessageServlet">💬 Messages</a>
            <a href="${pageContext.request.contextPath}/AdminProfileServlet" class="active">⚙️ My Profile</a>
            <a href="${pageContext.request.contextPath}/LogoutServlet" style="margin-top:30px; border-top:1px solid #333;">🚪 Logout</a>
        </div>

        <div class="admin-main">
            <h1 style="color:#1a1a1a; margin-bottom:30px;">My Profile</h1>

            <% if (request.getAttribute("success") != null) { %>
                <div class="alert alert-success"><%= request.getAttribute("success") %></div>
            <% } %>
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-error"><%= request.getAttribute("error") %></div>
            <% } %>

            <div style="display:grid; grid-template-columns:1fr 1fr; gap:30px; max-width:1000px;">

                <!-- Update Profile -->
                <div style="background:#fff; border-radius:10px; padding:30px; box-shadow:0 2px 10px rgba(0,0,0,0.05);">
                    <h3 style="margin-bottom:25px; color:#1a1a1a;">Update Profile</h3>

                    <form method="POST" action="${pageContext.request.contextPath}/AdminProfileServlet">
                        <input type="hidden" name="action" value="updateProfile">

                        <div class="form-group">
                            <label>Full Name</label>
                            <input type="text" name="fullName" value="<%= request.getAttribute("adminFullName") != null ? request.getAttribute("adminFullName") : "" %>">
                        </div>

                        <div class="form-group">
                            <label>Email *</label>
                            <input type="email" name="email" required value="<%= request.getAttribute("adminEmail") != null ? request.getAttribute("adminEmail") : "" %>">
                        </div>

                        <div class="form-group">
                            <label>Phone</label>
                            <input type="tel" name="phone" value="<%= request.getAttribute("adminPhone") != null ? request.getAttribute("adminPhone") : "" %>">
                        </div>

                        <div class="form-group">
                            <label>City</label>
                            <input type="text" name="city" value="<%= request.getAttribute("adminCity") != null ? request.getAttribute("adminCity") : "" %>">
                        </div>

                        <button type="submit" class="btn btn-primary">Save Profile</button>
                    </form>
                </div>

                <!-- Change Password -->
                <div style="background:#fff; border-radius:10px; padding:30px; box-shadow:0 2px 10px rgba(0,0,0,0.05);">
                    <h3 style="margin-bottom:25px; color:#1a1a1a;">🔐 Change Password</h3>

                    <form method="POST" action="${pageContext.request.contextPath}/AdminProfileServlet">
                        <input type="hidden" name="action" value="changePassword">

                        <div class="form-group">
                            <label>Current Password *</label>
                            <input type="password" name="currentPassword" required>
                        </div>

                        <div class="form-group">
                            <label>New Password * (min 8 chars)</label>
                            <input type="password" name="newPassword" minlength="8" required>
                        </div>

                        <div class="form-group">
                            <label>Confirm New Password *</label>
                            <input type="password" name="confirmPassword" minlength="8" required>
                        </div>

                        <button type="submit" class="btn btn-gold">Update Password</button>
                    </form>

                    <p style="color:#666; font-size:13px; margin-top:15px;">
                        <strong>Tip:</strong> Use a strong password with a mix of letters, numbers, and symbols.
                    </p>
                </div>

            </div>
        </div>
    </div>
</body>
</html>