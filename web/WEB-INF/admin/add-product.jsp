<%-- 
    Document   : add-product
    Created on :11 may 2026, 11:56:41
    Author     : thapelo
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="groot.entity.Category"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Product — Admin</title>
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
            <h1 style="color:#1a1a1a; margin-bottom:30px;">Add New Product</h1>

            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-error"><%= request.getAttribute("error") %></div>
            <% } %>

            <div class="form-container" style="margin:0; max-width:700px;">
                <form method="POST" action="${pageContext.request.contextPath}/AdminProductServlet" enctype="multipart/form-data">
                    <input type="hidden" name="action" value="create">

                    <div class="form-group">
                        <label>Product Name *</label>
                        <input type="text" name="name" required>
                    </div>

                    <div class="form-group">
                        <label>Category</label>
                        <select name="categoryId">
                            <option value="">-- Select Category --</option>
                            <%
                                List<Category> categories = (List<Category>) request.getAttribute("categories");
                                if (categories != null) {
                                    for (Category cat : categories) {
                            %>
                                <option value="<%= cat.getId() %>"><%= cat.getName() %></option>
                            <%
                                    }
                                }
                            %>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>Description</label>
                        <textarea name="description" rows="4"></textarea>
                    </div>

                    <div style="display:grid; grid-template-columns:1fr 1fr; gap:20px;">
                        <div class="form-group">
                            <label>Price (R) *</label>
                            <input type="number" name="price" step="0.01" min="0" required>
                        </div>
                        <div class="form-group">
                            <label>Sale Price (R) — optional</label>
                            <input type="number" name="salePrice" step="0.01" min="0">
                        </div>
                    </div>

                    <div style="display:grid; grid-template-columns:1fr 1fr; gap:20px;">
                        <div class="form-group">
                            <label>Stock Quantity</label>
                            <input type="number" name="stockQuantity" value="0" min="0">
                        </div>
                        <div class="form-group">
                            <label>&nbsp;</label>
                            <div style="padding-top:35px;">
                                <input type="checkbox" name="isFeatured" id="isFeatured" style="width:auto; margin-right:8px;">
                                <label for="isFeatured" style="display:inline; font-weight:400;">Feature on homepage</label>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label>📸 Product Images (you can select multiple) *</label>
                        <input type="file" name="images" accept="image/*" multiple required>
                        <small style="color:#666;">JPG, PNG, GIF — first image will be the main one</small>
                    </div>

                    <button type="submit" class="btn btn-primary">Save Product</button>
                    <a href="${pageContext.request.contextPath}/AdminProductServlet"
                       style="display:inline-block; margin-left:15px; padding:14px 20px; color:#666; text-decoration:none;">Cancel</a>
                </form>
            </div>
        </div>
    </div>
</body>
</html>