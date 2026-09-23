<%-- 
    Document   : dashboard
    Created on : 10 may 2026, 23:00:15
    Author     : thapelo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard — Groot Clothing</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="admin-layout">
        <div class="admin-sidebar">
            <h3>GROOT ADMIN</h3>
            <a href="${pageContext.request.contextPath}/AdminDashboardServlet" class="active">📊 Dashboard</a>
            <a href="${pageContext.request.contextPath}/AdminProductServlet">👕 Products</a>
            <a href="${pageContext.request.contextPath}/AdminUserServlet">👥 Users</a>
            <a href="${pageContext.request.contextPath}/AdminEventServlet">🎉 Events</a>
            <a href="${pageContext.request.contextPath}/AdminMessageServlet">💬 Messages</a>
            <a href="${pageContext.request.contextPath}/AdminProfileServlet">⚙️ My Profile</a>
            <a href="${pageContext.request.contextPath}/LogoutServlet" style="margin-top:30px; border-top:1px solid #333;">🚪 Logout</a>
        </div>

        <div class="admin-main">
            <h1 style="color:#1a1a1a; margin-bottom:30px;">Welcome, <%= session.getAttribute("fullName") != null ? session.getAttribute("fullName") : "Admin" %> 👋</h1>

            <div class="stats-grid">
                <div class="stat-card">
                    <h3><%= request.getAttribute("totalUsers") != null ? request.getAttribute("totalUsers") : "0" %></h3>
                    <p>Total Users</p>
                </div>
                <div class="stat-card" style="border-left-color:#2a7;">
                    <h3><%= request.getAttribute("totalProducts") != null ? request.getAttribute("totalProducts") : "0" %></h3>
                    <p>Products</p>
                </div>
                <div class="stat-card" style="border-left-color:#f4a261;">
                    <h3><%= request.getAttribute("pendingUsers") != null ? request.getAttribute("pendingUsers") : "0" %></h3>
                    <p>Pending Users</p>
                </div>
                <div class="stat-card" style="border-left-color:#248;">
                    <h3><%= request.getAttribute("totalEvents") != null ? request.getAttribute("totalEvents") : "0" %></h3>
                    <p>Events</p>
                </div>
                <div class="stat-card" style="border-left-color:#8e44ad;">
                    <h3><%= request.getAttribute("totalOrders") != null ? request.getAttribute("totalOrders") : "0" %></h3>
                    <p>Orders</p>
                </div>
                <div class="stat-card" style="border-left-color:#c33;">
                    <h3><%= request.getAttribute("unreadMessages") != null ? request.getAttribute("unreadMessages") : "0" %></h3>
                    <p>Unread Messages</p>
                </div>
            </div>

            <div style="background:#fff; padding:25px; border-radius:10px; box-shadow:0 2px 10px rgba(0,0,0,0.05);">
                <h3 style="margin-bottom:20px;">Quick Actions</h3>
                <a href="${pageContext.request.contextPath}/AdminProductServlet?action=add" class="btn btn-primary" style="margin-right:10px;">➕ Add Product</a>
                <a href="${pageContext.request.contextPath}/AdminUserServlet?filter=pending" class="btn btn-gold" style="margin-right:10px;">⏳ Review Pending Users</a>
                <a href="${pageContext.request.contextPath}/AdminEventServlet" class="btn" style="background:#e63946; color:#fff;">🎉 Manage Events</a>
            </div>
        </div>
    </div>
</body>
</html>