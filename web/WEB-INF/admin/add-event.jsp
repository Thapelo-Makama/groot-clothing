<%-- 
    Document   : add-event
    Created on : 17 may 2026, 19:06:21
    Author     : thapelo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Event — Admin</title>
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
            <h1 style="color:#1a1a1a; margin-bottom:30px;">Add New Event</h1>

            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-error"><%= request.getAttribute("error") %></div>
            <% } %>

            <div class="form-container" style="margin:0; max-width:700px;">
                <form method="POST" action="${pageContext.request.contextPath}/AdminEventServlet" enctype="multipart/form-data">
                    <input type="hidden" name="action" value="create">

                    <div class="form-group">
                        <label>Event Title *</label>
                        <input type="text" name="title" required placeholder="e.g. Groot Annually 2027">
                    </div>

                    <div class="form-group">
                        <label>Description</label>
                        <textarea name="description" rows="4" placeholder="Describe the event..."></textarea>
                    </div>

                    <div style="display:grid; grid-template-columns:1fr 1fr; gap:20px;">
                        <div class="form-group">
                            <label>Venue</label>
                            <input type="text" name="venue" placeholder="e.g. Zama Gakekana">
                        </div>
                        <div class="form-group">
                            <label>City / Area</label>
                            <input type="text" name="city" placeholder="e.g. Moutse West">
                        </div>
                    </div>

                    <div class="form-group">
                        <label>Event Date & Time</label>
                        <input type="datetime-local" name="eventDate">
                    </div>

                    <div class="form-group">
                        <label>📸 Event Photos (optional, multiple)</label>
                        <input type="file" name="photos" accept="image/*" multiple>
                    </div>

                    <button type="submit" class="btn btn-primary">Create Event</button>
                    <a href="${pageContext.request.contextPath}/AdminEventServlet"
                       style="display:inline-block; margin-left:15px; padding:14px 20px; color:#666; text-decoration:none;">Cancel</a>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
