<%-- 
    Document   : events
    Created on :  06 may 2026, 16:00:09
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
    <title>Groot Annually — Events</title>
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
                <li><a href="${pageContext.request.contextPath}/LogoutServlet">Logout</a></li>
            <% } else { %>
                <li><a href="${pageContext.request.contextPath}/login.jsp" class="btn-nav">Login</a></li>
            <% } %>
        </ul>
    </div>

    <section class="hero" style="padding:70px 40px;">
        <h1>GROOT <span class="accent">ANNUALLY</span></h1>
        <p>Youth Talent Showcase · Moutse West</p>
        <p style="font-size:15px; opacity:0.8;">
            Where young dancers, models, and fashion designers shine.
        </p>
    </section>

    <div class="container">
        <div class="section-title">
            <h2>Upcoming & Past Events</h2>
            <div class="divider"></div>
        </div>

        <%
            List<Event> events = (List<Event>) request.getAttribute("events");
            SimpleDateFormat sdf = new SimpleDateFormat("dd MMMM yyyy, HH:mm");
            if (events != null && !events.isEmpty()) {
                for (Event event : events) {
        %>
            <div class="event-card">
                <div class="event-image">
                    <%
                        String eventImage = null;
                        if (event.getPhotos() != null && !event.getPhotos().isEmpty()) {
                            eventImage = event.getPhotos().get(0).getImagePath();
                        }
                    %>
                    <% if (eventImage != null) { %>
                        <img src="${pageContext.request.contextPath}<%= eventImage %>" alt="<%= event.getTitle() %>">
                    <% } else { %>
                        <div style="width:100%; height:100%; display:flex; align-items:center; justify-content:center; background:#1a1a1a; color:#f4a261; font-size:80px; font-weight:900;">
                            G
                        </div>
                    <% } %>
                </div>
                <div class="event-info">
                    <h3><%= event.getTitle() %></h3>
                    <div class="event-meta">
                        <% if (event.getEventDate() != null) { %>
                            <span><i>📅</i><%= sdf.format(event.getEventDate()) %></span>
                        <% } %>
                        <% if (event.getVenue() != null) { %>
                            <span><i>📍</i><%= event.getVenue() %>, <%= event.getCity() %></span>
                        <% } %>
                    </div>
                    <% if (event.getDescription() != null) { %>
                        <p><%= event.getDescription() %></p>
                    <% } %>
                </div>
            </div>

            <%-- Event photo gallery --%>
            <% if (event.getPhotos() != null && event.getPhotos().size() > 1) { %>
                <div style="display:grid; grid-template-columns:repeat(auto-fill, minmax(150px, 1fr)); gap:10px; margin-bottom:50px;">
                    <% for (EventPhoto photo : event.getPhotos()) { %>
                        <img src="${pageContext.request.contextPath}<%= photo.getImagePath() %>"
                             alt="<%= photo.getCaption() != null ? photo.getCaption() : event.getTitle() %>"
                             style="width:100%; height:150px; object-fit:cover; border-radius:8px; cursor:pointer;"
                             onclick="window.open(this.src, '_blank');">
                    <% } %>
                </div>
            <% } %>
        <%
                }
            } else {
        %>
            <div style="text-align:center; padding:80px 20px; background:#fff; border-radius:10px;">
                <h3 style="color:#999; margin-bottom:15px;">No events scheduled yet</h3>
                <p style="color:#666;">Follow us for updates on Groot Annually 2026.</p>
            </div>
        <% } %>
    </div>

    <footer class="footer">
        <div class="footer-bottom">
            © 2026 Groot Clothing Brand · Groot Annually · Moutse West, Limpopo
        </div>
    </footer>
</body>
</html>
