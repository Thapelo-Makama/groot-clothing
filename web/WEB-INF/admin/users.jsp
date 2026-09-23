<%-- 
    Document   : users
    Created on : 11 may 2026, 19:02:36
    Author     : thapelo
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="groot.entity.User"%>
<%@page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Users — Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="admin-layout">
        <div class="admin-sidebar">
            <h3>GROOT ADMIN</h3>
            <a href="${pageContext.request.contextPath}/AdminDashboardServlet">📊 Dashboard</a>
            <a href="${pageContext.request.contextPath}/AdminProductServlet">👕 Products</a>
            <a href="${pageContext.request.contextPath}/AdminUserServlet" class="active">👥 Users</a>
            <a href="${pageContext.request.contextPath}/AdminEventServlet">🎉 Events</a>
            <a href="${pageContext.request.contextPath}/AdminMessageServlet">💬 Messages</a>
            <a href="${pageContext.request.contextPath}/AdminProfileServlet">⚙️ My Profile</a>
            <a href="${pageContext.request.contextPath}/LogoutServlet" style="margin-top:30px; border-top:1px solid #333;">🚪 Logout</a>
        </div>

        <div class="admin-main">
            <h1 style="color:#1a1a1a; margin-bottom:30px;">Manage Users</h1>

            <% if (request.getAttribute("success") != null) { %>
                <div class="alert alert-success"><%= request.getAttribute("success") %></div>
            <% } %>
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-error"><%= request.getAttribute("error") %></div>
            <% } %>

            <%-- Pending Approval --%>
            <%
                List<User> pending = (List<User>) request.getAttribute("pendingUsers");
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            %>
            <% if (pending != null && !pending.isEmpty()) { %>
                <div style="background:#fff; border-radius:10px; padding:20px; margin-bottom:30px; box-shadow:0 2px 10px rgba(0,0,0,0.05); border-left:5px solid #f4a261;">
                    <h3 style="color:#f4a261; margin-bottom:20px;">⏳ Pending Approval (<%= pending.size() %>)</h3>
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Username</th>
                                <th>Full Name</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Registered</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (User u : pending) { %>
                                <tr>
                                    <td><strong><%= u.getUsername() %></strong></td>
                                    <td><%= u.getFullName() != null ? u.getFullName() : "—" %></td>
                                    <td><%= u.getEmail() %></td>
                                    <td><%= u.getPhone() != null ? u.getPhone() : "—" %></td>
                                    <td><%= u.getCreatedAt() != null ? sdf.format(u.getCreatedAt()) : "—" %></td>
                                    <td>
                                        <form method="POST" action="${pageContext.request.contextPath}/AdminUserServlet" style="display:inline;">
                                            <input type="hidden" name="action" value="approve">
                                            <input type="hidden" name="userId" value="<%= u.getId() %>">
                                            <button type="submit" class="btn" style="background:#2a7; color:#fff; padding:6px 14px; font-size:12px;">✅ Approve</button>
                                        </form>
                                        <form method="POST" action="${pageContext.request.contextPath}/AdminUserServlet" style="display:inline;" onsubmit="return confirm('Reject and delete this user?');">
                                            <input type="hidden" name="action" value="reject">
                                            <input type="hidden" name="userId" value="<%= u.getId() %>">
                                            <button type="submit" class="btn" style="background:#c33; color:#fff; padding:6px 14px; font-size:12px;">❌ Reject</button>
                                        </form>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            <% } %>

            <%-- All Users --%>
            <div style="background:#fff; border-radius:10px; padding:20px; box-shadow:0 2px 10px rgba(0,0,0,0.05);">
                <h3 style="margin-bottom:20px;">👥 All Users</h3>
                <%
                    List<User> users = (List<User>) request.getAttribute("users");
                    if (users != null && !users.isEmpty()) {
                %>
                    <table class="table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Username</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>City</th>
                                <th>Status</th>
                                <th>Role</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (User u : users) { %>
                                <tr>
                                    <td><%= u.getId() %></td>
                                    <td><strong><%= u.getUsername() %></strong></td>
                                    <td><%= u.getFullName() != null ? u.getFullName() : "—" %></td>
                                    <td><%= u.getEmail() %></td>
                                    <td><%= u.getCity() != null ? u.getCity() : "—" %></td>
                                    <td>
                                        <% if (Boolean.TRUE.equals(u.getIsBanned())) { %>
                                            <span style="color:#c33;">🚫 Banned</span>
                                        <% } else if (Boolean.TRUE.equals(u.getIsApproved())) { %>
                                            <span style="color:#2a7;">✅ Active</span>
                                        <% } else { %>
                                            <span style="color:#f4a261;">⏳ Pending</span>
                                        <% } %>
                                    </td>
                                    <td>
                                        <% if (Boolean.TRUE.equals(u.getIsAdmin())) { %>
                                            <span style="background:#8e44ad; color:#fff; padding:3px 10px; border-radius:12px; font-size:12px;">ADMIN</span>
                                        <% } else { %>
                                            <span style="color:#666; font-size:12px;">User</span>
                                        <% } %>
                                    </td>
                                    <td>
                                        <% if (u.getId() != ((Integer) session.getAttribute("userId"))) { %>
                                            <form method="POST" action="${pageContext.request.contextPath}/AdminUserServlet" style="display:inline;">
                                                <input type="hidden" name="action" value="toggleBan">
                                                <input type="hidden" name="userId" value="<%= u.getId() %>">
                                                <button type="submit" class="btn" style="background:<%= Boolean.TRUE.equals(u.getIsBanned()) ? "#2a7" : "#c33" %>; color:#fff; padding:5px 12px; font-size:12px;">
                                                    <%= Boolean.TRUE.equals(u.getIsBanned()) ? "Unban" : "Ban" %>
                                                </button>
                                            </form>
                                            <form method="POST" action="${pageContext.request.contextPath}/AdminUserServlet" style="display:inline;" onsubmit="return confirm('Delete this user permanently?');">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="userId" value="<%= u.getId() %>">
                                                <button type="submit" style="background:#c33; color:#fff; border:none; padding:5px 12px; border-radius:5px; font-size:12px; cursor:pointer;">🗑️</button>
                                            </form>
                                        <% } else { %>
                                            <span style="color:#999; font-size:12px;">(You)</span>
                                        <% } %>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                <% } else { %>
                    <p style="color:#999; text-align:center; padding:40px;">No users yet.</p>
                <% } %>
            </div>
        </div>
    </div>
</body>
</html>
