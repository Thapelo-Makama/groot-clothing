<%-- 
    Document   : events
    Created on : 17 may 2026, 16:05:09
    Author     : thapelo
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="groot.entity.Event"%>
<%@page import="groot.entity.EventPhoto"%>
<%@page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Events — Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="admin-layout">
        <div class="admin-sidebar">
            <h3>GROOT ADMIN</h3>
            <a href="${pageContext.request.contextPath}/AdminDashboardServlet">📊 Dashboard</a>
            <a href="${pageContext.request.contextPath}/AdminProductServlet">👕 Products</a>
            <a href="${pageContext.request.contextPath}/AdminUserServlet">👥 Users</a>
            <a href="${pageContext.request.contextPath}/AdminEventServlet" class="active">🎉 Events</a>
            <a href="${pageContext.request.contextPath}/AdminMessageServlet">💬 Messages</a>
            <a href="${pageContext.request.contextPath}/AdminProfileServlet">⚙️ My Profile</a>
            <a href="${pageContext.request.contextPath}/LogoutServlet" style="margin-top:30px; border-top:1px solid #333;">🚪 Logout</a>
        </div>

        <div class="admin-main">
            <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:30px;">
                <h1 style="color:#1a1a1a;">Manage Events</h1>
                <a href="${pageContext.request.contextPath}/admin/add-event.jsp" class="btn btn-primary">➕ Add New Event</a>
            </div>

            <% if (request.getAttribute("success") != null) { %>
                <div class="alert alert-success"><%= request.getAttribute("success") %></div>
            <% } %>

            <%
                List<Event> events = (List<Event>) request.getAttribute("events");
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                if (events != null && !events.isEmpty()) {
                    for (Event event : events) {
            %>
                <div style="background:#fff; border-radius:10px; padding:25px; margin-bottom:20px; box-shadow:0 2px 10px rgba(0,0,0,0.05);">
                    <div style="display:flex; justify-content:space-between; align-items:start;">
                        <div style="flex:1;">
                            <h3 style="color:#1a1a1a; margin-bottom:10px;"><%= event.getTitle() %></h3>
                            <div style="color:#666; font-size:14px; margin-bottom:15px;">
                                📅 <%= event.getEventDate() != null ? sdf.format(event.getEventDate()) : "—" %>
                                · 📍 <%= event.getVenue() != null ? event.getVenue() : "—" %>
                                <% if (event.getCity() != null) { %>, <%= event.getCity() %><% } %>
                            </div>
                            <% if (event.getDescription() != null) { %>
                                <p style="color:#555; margin-bottom:15px;"><%= event.getDescription() %></p>
                            <% } %>

                            <%-- Event Photos --%>
                            <% if (event.getPhotos() != null && !event.getPhotos().isEmpty()) { %>
                                <div style="display:flex; gap:8px; flex-wrap:wrap;">
                                    <% for (EventPhoto photo : event.getPhotos()) { %>
                                        <div style="position:relative;">
                                            <img src="${pageContext.request.contextPath}<%= photo.getImagePath() %>"
                                                 style="width:80px; height:80px; object-fit:cover; border-radius:6px; border:2px solid #eee;">
                                            <form method="POST" action="${pageContext.request.contextPath}/AdminEventServlet"
                                                  style="position:absolute; top:2px; right:2px;"
                                                  onsubmit="return confirm('Delete this photo?');">
                                                <input type="hidden" name="action" value="deletePhoto">
                                                <input type="hidden" name="photoId" value="<%= photo.getId() %>">
                                                <input type="hidden" name="eventId" value="<%= event.getId() %>">
                                                <button type="submit" style="background:#c33; color:#fff; border:none; border-radius:50%; width:20px; height:20px; cursor:pointer; font-size:10px;">×</button>
                                            </form>
                                        </div>
                                    <% } %>
                                </div>
                            <% } else { %>
                                <p style="color:#999; font-size:13px;">No photos yet</p>
                            <% } %>

                            <%-- Add photo form --%>
                            <form method="POST" action="${pageContext.request.contextPath}/AdminEventServlet"
                                  enctype="multipart/form-data" style="margin-top:15px;">
                                <input type="hidden" name="action" value="addPhoto">
                                <input type="hidden" name="eventId" value="<%= event.getId() %>">
                                <input type="file" name="photo" accept="image/*" required
                                       style="font-size:12px; padding:6px;">
                                <input type="text" name="caption" placeholder="Caption (optional)"
                                       style="font-size:12px; padding:6px; width:200px;">
                                <button type="submit" class="btn btn-gold" style="padding:6px 15px; font-size:12px;">📷 Add Photo</button>
                            </form>
                        </div>

                        <div style="margin-left:20px;">
                            <form method="POST" action="${pageContext.request.contextPath}/AdminEventServlet"
                                  onsubmit="return confirm('Delete this entire event?');">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="eventId" value="<%= event.getId() %>">
                                <button type="submit" style="background:#c33; color:#fff; border:none; padding:8px 15px; border-radius:5px; cursor:pointer; font-size:13px;">
                                    🗑️ Delete Event
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            <%
                    }
                } else {
            %>
                <div style="text-align:center; padding:60px; background:#fff; border-radius:10px;">
                    <h3 style="color:#999;">No events yet</h3>
                    <p>Click "Add New Event" to create one.</p>
                </div>
            <% } %>
        </div>
    </div>
</body>
</html>
