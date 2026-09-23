<%-- 
    Document   : shop
    Created on : 06 may 2026, 12:37:41
    Author     : thapelo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="groot.entity.Product"%>
<%@page import="groot.entity.Category"%>
<%@page import="java.math.BigDecimal"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Shop — Groot Clothing</title>
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
            <h2>Our Collection</h2>
            <div class="divider"></div>
        </div>

        <%-- Category filter --%>
        <% List<Category> categories = (List<Category>) request.getAttribute("categories"); %>
        <% if (categories != null && !categories.isEmpty()) { %>
            <div style="text-align:center; margin-bottom:30px;">
                <a href="${pageContext.request.contextPath}/ShopServlet" 
                   style="display:inline-block; padding:8px 20px; margin:5px; border-radius:20px; 
                          text-decoration:none; background:#fff; color:#333; border:2px solid #eee;">
                    All
                </a>
                <% for (Category cat : categories) { %>
                    <a href="${pageContext.request.contextPath}/ShopServlet?category=<%= cat.getId() %>" 
                       style="display:inline-block; padding:8px 20px; margin:5px; border-radius:20px; 
                              text-decoration:none; background:#fff; color:#333; border:2px solid #eee;">
                        <%= cat.getName() %>
                    </a>
                <% } %>
            </div>
        <% } %>

        <% List<Product> products = (List<Product>) request.getAttribute("products"); %>
        <% if (products != null && !products.isEmpty()) { %>
            <div class="product-grid">
                <% for (Product p : products) { 
                    String imgPath = p.getPrimaryImage();
                    boolean hasImg = !"placeholder.jpg".equals(imgPath);
                %>
                    <a href="${pageContext.request.contextPath}/ProductDetailServlet?id=<%= p.getId() %>" class="product-card">
                        <div class="image-wrap">
                            <% if (Boolean.TRUE.equals(p.getIsFeatured())) { %>
                                <span class="badge-featured">FEATURED</span>
                            <% } %>
                            <% if (hasImg) { %>
                                <img src="${pageContext.request.contextPath}<%= imgPath %>" alt="<%= p.getName() %>">
                            <% } else { %>
                                <div style="width:100%;height:100%;display:flex;align-items:center;justify-content:center;color:#999;">
                                    No Image
                                </div>
                            <% } %>
                        </div>
                        <div class="info">
                            <h3><%= p.getName() %></h3>
                            <div class="price">
                                R<%= String.format("%.2f", p.getPrice()) %>
                                <% if (p.getSalePrice() != null && p.getSalePrice().compareTo(BigDecimal.ZERO) > 0) { %>
                                    <span class="old-price">R<%= String.format("%.2f", p.getSalePrice()) %></span>
                                <% } %>
                            </div>
                        </div>
                    </a>
                <% } %>
            </div>
        <% } else { %>
            <div style="text-align:center; padding:80px 20px; background:#fff; border-radius:10px;">
                <h3 style="color:#999; margin-bottom:15px;">🛍️ No products yet</h3>
                <p style="color:#666;">Check back soon for our latest collection!</p>
            </div>
        <% } %>
    </div>

    <footer class="footer">
        <div class="footer-bottom">
            © 2026 Groot Clothing Brand. Owned by Malokase. Marble Hall, Limpopo.
        </div>
    </footer>
</body>
</html>