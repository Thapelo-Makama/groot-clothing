<%-- 
    Document   : messages
    Created on : 22 may 2026, 09:07:26
    Author     : thapelo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="groot.entity.Message"%>
<%@page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Messages — Admin</title>
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
            <a href="${pageContext.request.contextPath}/AdminMessageServlet" class="active">💬 Messages</a>
            <a href="${pageContext.request.contextPath}/AdminProfileServlet">⚙️ My Profile</a>
            <a href="${pageContext.request.contextPath}/LogoutServlet" style="margin-top:30px; border-top:1px solid #333;">🚪 Logout</a>
        </div>

        <div class="admin-main">
            <h1 style="color:#1a1a1a; margin-bottom:30px;">Customer Messages</h1>

            <% if (request.getAttribute("success") != null) { %>
                <div class="alert alert-success"><%= request.getAttribute("success") %></div>
            <% } %>

            <%
                List<Message> messages = (List<Message>) request.getAttribute("messages");
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                if (messages != null && !messages.isEmpty()) {
            %>
                <div style="display:grid; gap:15px;">
                    <% for (Message m : messages) { %>
                        <div style="background:#fff; border-radius:10px; padding:20px; box-shadow:0 2px 10px rgba(0,0,0,0.05); border-left:5px solid <%= Boolean.TRUE.equals(m.getIsRead()) ? "#ccc" : "#e63946" %>;">
                            <div style="display:flex; justify-content:space-between; margin-bottom:10px;">
                                <div>
                                    <strong style="color:#1a1a1a;"><%= m.getName() %></strong>
                                    <span style="color:#666; font-size:13px;">&lt;<%= m.getEmail() %>&gt;</span>
                                    <% if (m.getPhone() != null && !m.getPhone().isEmpty()) { %>
                                        <span style="color:#666; font-size:13px;">· 📞 <%= m.getPhone() %></span>
                                    <% } %>
                                </div>
                                <span style="color:#999; font-size:12px;"><%= m.getCreatedAt() != null ? sdf.format(m.getCreatedAt()) : "" %></span>
                            </div>
                            <% if (m.getSubject() != null && !m.getSubject().isEmpty()) { %>
                                <p style="color:#e63946; font-weight:600; margin-bottom:8px;">
                                    Subject: <%= m.getSubject() %>
                                </p>
                            <% } %>
                            <p style="color:#444; line-height:1.7; margin-bottom:15px;"><%= m.getMessage() %></p>

                            <div style="display:flex; gap:10px; flex-wrap:wrap;">
                                <a href="mailto:<%= m.getEmail() %>?subject=Re: <%= m.getSubject() != null ? m.getSubject() : "Your Message" %>"
                                   class="btn" style="background:#248; color:#fff; padding:6px 15px; font-size:12px; text-decoration:none;">
                                    ✉️ Reply by Email
                                </a>

                                <% if (m.getPhone() != null && !m.getPhone().isEmpty()) { 
                                    String cleanPhone = m.getPhone().replaceAll("[^0-9]", "");
                                    if (cleanPhone.startsWith("0")) cleanPhone = "27" + cleanPhone.substring(1);
                                %>
                                    <a href="https://wa.me/<%= cleanPhone %>"
                                       target="_blank"
                                       class="btn" style="background:#25D366; color:#fff; padding:6px 15px; font-size:12px; text-decoration:none;">
                                        💬 WhatsApp
                                    </a>
                                <% } %>

                                <form method="POST" action="${pageContext.request.contextPath}/AdminMessageServlet" style="display:inline;">
                                    <input type="hidden" name="action" value="toggleRead">
                                    <input type="hidden" name="messageId" value="<%= m.getId() %>">
                                    <button type="submit" class="btn" style="background:#f4a261; color:#fff; padding:6px 15px; font-size:12px; border:none; cursor:pointer;">
                                        <%= Boolean.TRUE.equals(m.getIsRead()) ? "Mark Unread" : "Mark Read" %>
                                    </button>
                                </form>

                                <form method="POST" action="${pageContext.request.contextPath}/AdminMessageServlet" style="display:inline;" onsubmit="return confirm('Delete this message?');">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="messageId" value="<%= m.getId() %>">
                                    <button type="submit" style="background:#c33; color:#fff; border:none; padding:6px 15px; border-radius:5px; font-size:12px; cursor:pointer;">
                                        🗑️ Delete
                                    </button>
                                </form>
                            </div>
                        </div>
                    <% } %>
                </div>
            <% } else { %>
                <div style="text-align:center; padding:60px; background:#fff; border-radius:10px;">
                    <h3 style="color:#999;">No messages yet</h3>
                    <p>Customer messages from the contact form will appear here.</p>
                </div>
            <% } %>
        </div>
    </div>
</body>
</html>
