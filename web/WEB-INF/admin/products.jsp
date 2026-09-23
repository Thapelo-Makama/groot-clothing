<%-- 
    Document   : products
    Created on : 11 may 2026, 09:23:13
    Author     : thapelo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="groot.entity.Product"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Products — Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="admin-layout">
        <div class="admin-sidebar">
            <h3>GROOT ADMIN</h3>
            <a href="${pageContext.request.contextPath}/AdminDashboardServlet">📊 Dashboard</a>
            <a href="${pageContext.request.contextPath}/AdminProductServlet" class="active">👕 Products</a>
            <a href="${pageContext.request.contextPath}/AdminUserServlet">👥 Users</a>
            <a href="${pageContext.request.contextPath}/AdminEventServlet">🎉 Events</a>
            <a href="${pageContext.request.contextPath}/AdminMessageServlet">💬 Messages</a>
            <a href="${pageContext.request.contextPath}/AdminProfileServlet">⚙️ My Profile</a>
            <a href="${pageContext.request.contextPath}/LogoutServlet" style="margin-top:30px; border-top:1px solid #333;">🚪 Logout</a>
        </div>

        <div class="admin-main">
            <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:30px;">
                <h1 style="color:#1a1a1a;">Manage Products</h1>
                <a href="${pageContext.request.contextPath}/AdminProductServlet?action=add" class="btn btn-primary">➕ Add New Product</a>
            </div>

            <% if (request.getAttribute("success") != null) { %>
                <div class="alert alert-success"><%= request.getAttribute("success") %></div>
            <% } %>

            <%
                List<Product> products = (List<Product>) request.getAttribute("products");
                if (products != null && !products.isEmpty()) {
            %>
                <table class="table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Image</th>
                            <th>Name</th>
                            <th>Category</th>
                            <th>Price</th>
                            <th>Stock</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Product p : products) { %>
                            <tr>
                                <td><%= p.getId() %></td>
                                <td>
                                    <% if (p.getImages() != null && !p.getImages().isEmpty()) { %>
                                        <img src="${pageContext.request.contextPath}<%= p.getImages().get(0).getImagePath() %>"
                                             style="width:50px; height:50px; object-fit:cover; border-radius:5px;">
                                    <% } else { %>
                                        <span style="color:#999;">—</span>
                                    <% } %>
                                </td>
                                <td><strong><%= p.getName() %></strong></td>
                                <td><%= p.getCategory() != null ? p.getCategory().getName() : "—" %></td>
                                <td>R<%= String.format("%.2f", p.getPrice()) %></td>
                                <td><%= p.getStockQuantity() %></td>
                                <td>
                                    <% if (Boolean.TRUE.equals(p.getIsActive())) { %>
                                        <span style="color:#2a7;">✅ Active</span>
                                    <% } else { %>
                                        <span style="color:#c33;">❌ Hidden</span>
                                    <% } %>
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/AdminProductServlet?action=edit&id=<%= p.getId() %>"
                                       style="color:#248; text-decoration:none; margin-right:10px;">✏️ Edit</a>
                                    <form method="POST" action="${pageContext.request.contextPath}/AdminProductServlet"
                                          style="display:inline;" onsubmit="return confirm('Delete this product?');">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="id" value="<%= p.getId() %>">
                                        <button type="submit" style="background:none; border:none; color:#c33; cursor:pointer; padding:0;">🗑️ Delete</button>
                                    </form>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } else { %>
                <div style="text-align:center; padding:60px; background:#fff; border-radius:10px;">
                    <h3 style="color:#999;">No products yet</h3>
                    <p>Click "Add New Product" to get started.</p>
                </div>
            <% } %>
        </div>
    </div>
</body>
</html>