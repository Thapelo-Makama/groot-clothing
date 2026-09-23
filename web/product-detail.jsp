<%-- 
    Document   : product-detail
    Created on : 06 may 2026, 11:39:28
    Author     : thapelo
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="groot.entity.Product"%>
<%@page import="groot.entity.ProductImage"%>
<%@page import="java.util.List"%>
<%@page import="java.math.BigDecimal"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title><%= ((Product)request.getAttribute("product")).getName() %> — Groot Clothing</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="navbar">
        <a href="${pageContext.request.contextPath}/" class="logo">GROOT <span>CLOTHING</span></a>
        <ul>
            <li><a href="${pageContext.request.contextPath}/">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/ShopServlet">Shop</a></li>
            <li><a href="${pageContext.request.contextPath}/EventsServlet">Events</a></li>
            <% if (session.getAttribute("userId") != null) { %>
                <li><a href="${pageContext.request.contextPath}/LogoutServlet">Logout</a></li>
            <% } else { %>
                <li><a href="${pageContext.request.contextPath}/login.jsp" class="btn-nav">Login</a></li>
            <% } %>
        </ul>
    </div>

    <%
        Product product = (Product) request.getAttribute("product");
        List<ProductImage> images = (List<ProductImage>) request.getAttribute("images");
        if (product != null) {
    %>
    <div class="container">
        <div style="display:grid; grid-template-columns:1fr 1fr; gap:50px; align-items:start;">

            <!-- Image Gallery -->
            <div>
                <div style="background:#fff; border-radius:10px; overflow:hidden; box-shadow:0 4px 15px rgba(0,0,0,0.08);">
                    <%
                        String mainImage = "placeholder.jpg";
                        if (images != null && !images.isEmpty()) {
                            for (ProductImage img : images) {
                                if (Boolean.TRUE.equals(img.getIsPrimary())) {
                                    mainImage = img.getImagePath();
                                    break;
                                }
                            }
                            if ("placeholder.jpg".equals(mainImage)) {
                                mainImage = images.get(0).getImagePath();
                            }
                        }
                    %>
                    <% if (!"placeholder.jpg".equals(mainImage)) { %>
                        <img id="mainImage" src="${pageContext.request.contextPath}<%= mainImage %>"
                             alt="<%= product.getName() %>"
                             style="width:100%; height:500px; object-fit:cover;">
                    <% } else { %>
                        <div style="width:100%; height:500px; display:flex; align-items:center; justify-content:center; background:#f0f0f0; color:#999;">
                            No Image Available
                        </div>
                    <% } %>
                </div>

                <% if (images != null && images.size() > 1) { %>
                    <div style="display:flex; gap:10px; margin-top:15px; flex-wrap:wrap;">
                        <% for (ProductImage img : images) { %>
                            <img src="${pageContext.request.contextPath}<%= img.getImagePath() %>"
                                 onclick="document.getElementById('mainImage').src=this.src"
                                 style="width:80px; height:80px; object-fit:cover; border-radius:6px; cursor:pointer; border:2px solid #eee;">
                        <% } %>
                    </div>
                <% } %>
            </div>

            <!-- Product Info -->
            <div>
                <% if (product.getCategory() != null) { %>
                    <p style="color:#e63946; font-size:13px; text-transform:uppercase; letter-spacing:2px; font-weight:600;">
                        <%= product.getCategory().getName() %>
                    </p>
                <% } %>
                <h1 style="font-size:36px; color:#1a1a1a; margin-bottom:15px;"><%= product.getName() %></h1>

                <div style="font-size:32px; color:#e63946; font-weight:700; margin-bottom:20px;">
                    R<%= String.format("%.2f", product.getPrice()) %>
                    <% if (product.getSalePrice() != null && product.getSalePrice().compareTo(BigDecimal.ZERO) > 0) { %>
                        <span style="color:#999; text-decoration:line-through; font-size:20px; margin-left:10px; font-weight:400;">
                            R<%= String.format("%.2f", product.getSalePrice()) %>
                        </span>
                    <% } %>
                </div>

                <% if (product.getStockQuantity() != null && product.getStockQuantity() > 0) { %>
                    <p style="color:#2a7; font-weight:600; margin-bottom:20px;">
                        ✅ In Stock (<%= product.getStockQuantity() %> available)
                    </p>
                <% } else { %>
                    <p style="color:#c33; font-weight:600; margin-bottom:20px;">❌ Out of Stock</p>
                <% } %>

                <% if (product.getDescription() != null && !product.getDescription().isEmpty()) { %>
                    <p style="color:#555; line-height:1.8; margin-bottom:25px;"><%= product.getDescription() %></p>
                <% } %>

                <div style="background:#f9f9f9; padding:20px; border-radius:10px; margin-bottom:25px;">
                    <p style="color:#666; font-size:14px; margin:0;">
                        <strong>📱 Order via WhatsApp:</strong> Send a message to
                        <a href="https://wa.me/27722027820?text=Hi%20Malokase,%20I%20want%20to%20order:%20<%= java.net.URLEncoder.encode(product.getName(), "UTF-8") %>"
                           target="_blank"
                           style="color:#25D366; font-weight:700; text-decoration:none;">
                            072 202 7820
                        </a>
                    </p>
                </div>

                <a href="https://wa.me/27722027820?text=Hi%20Malokase,%20I%20want%20to%20order:%20<%= java.net.URLEncoder.encode(product.getName(), "UTF-8") %>"
                   target="_blank"
                   class="btn"
                   style="background:#25D366; color:#fff; display:inline-block; padding:15px 40px; text-decoration:none; border-radius:8px; font-weight:600;">
                    <i>💬</i> Order on WhatsApp
                </a>

                <a href="${pageContext.request.contextPath}/ShopServlet"
                   style="display:inline-block; margin-left:15px; color:#666; text-decoration:none; padding:15px 20px;">
                    ← Back to Shop
                </a>
            </div>
        </div>
    </div>
    <% } else { %>
        <div class="container" style="text-align:center; padding:100px 20px;">
            <h2 style="color:#666;">Product not found</h2>
            <a href="${pageContext.request.contextPath}/ShopServlet" class="btn btn-primary" style="margin-top:20px; display:inline-block;">Back to Shop</a>
        </div>
    <% } %>

    <footer class="footer">
        <div class="footer-bottom">
            © 2026 Groot Clothing Brand. Owned by Malokase. Marble Hill, Limpopo.
        </div>
    </footer>
</body>
</html>
