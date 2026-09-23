<%-- 
    Document   : my-orders
    Created on : 29 may 2026, 16:13:09
    Author     : thapelo
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="groot.entity.Order"%>
<%@page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Orders — Groot Clothing</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="navbar">
        <a href="${pageContext.request.contextPath}/" class="logo">GROOT <span>CLOTHING</span></a>
        <ul>
            <li><a href="${pageContext.request.contextPath}/">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/ShopServlet">Shop</a></li>
            <li><a href="${pageContext.request.contextPath}/EventsServlet">Events</a></li>
            <li><a href="${pageContext.request.contextPath}/LogoutServlet">Logout</a></li>
        </ul>
    </div>

    <div class="container">
        <div class="section-title">
            <h2>My Orders</h2>
            <div class="divider"></div>
        </div>

        <%
            List<Order> orders = (List<Order>) request.getAttribute("orders");
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            if (orders != null && !orders.isEmpty()) {
        %>
            <table class="table">
                <thead>
                    <tr>
                        <th>Order #</th>
                        <th>Date</th>
                        <th>Total</th>
                        <th>Status</th>
                        <th>Items</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Order o : orders) { %>
                        <tr>
                            <td><strong><%= o.getOrderNumber() %></strong></td>
                            <td><%= o.getCreatedAt() != null ? sdf.format(o.getCreatedAt()) : "—" %></td>
                            <td>R<%= String.format("%.2f", o.getTotalAmount()) %></td>
                            <td>
                                <span style="padding:4px 12px; border-radius:12px; font-size:12px; background:<%= 
                                    "pending".equals(o.getStatus()) ? "#f4a261" :
                                    "completed".equals(o.getStatus()) ? "#2a7" :
                                    "cancelled".equals(o.getStatus()) ? "#c33" : "#666" %>; color:#fff;">
                                    <%= o.getStatus().toUpperCase() %>
                                </span>
                            </td>
                            <td><%= o.getItems() != null ? o.getItems().size() : 0 %> item(s)</td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        <% } else { %>
            <div style="text-align:center; padding:80px 20px; background:#fff; border-radius:10px;">
                <h3 style="color:#999;">No orders yet</h3>
                <a href="${pageContext.request.contextPath}/ShopServlet" class="btn btn-primary" style="margin-top:20px; display:inline-block;">Start Shopping</a>
            </div>
        <% } %>
    </div>

    <footer class="footer">
        <div class="footer-bottom">
            © 2026 Groot Clothing Brand. Owned by Malokase.
        </div>
    </footer>
</body>
</html>
