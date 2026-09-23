<%-- 
    Document   : edit-product
    Created on : 11 may 2026, 16:02:36
    Author     : thapelo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="groot.entity.Category"%>
<%@page import="groot.entity.Product"%>
<%@page import="groot.entity.ProductImage"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Product — Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <%
        Product product = (Product) request.getAttribute("product");
        if (product == null) {
            response.sendRedirect(request.getContextPath() + "/AdminProductServlet");
            return;
        }
    %>
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
            <h1 style="color:#1a1a1a; margin-bottom:30px;">Edit Product: <%= product.getName() %></h1>

            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-error"><%= request.getAttribute("error") %></div>
            <% } %>

            <div class="form-container" style="margin:0; max-width:700px;">
                <form method="POST" action="${pageContext.request.contextPath}/AdminProductServlet" enctype="multipart/form-data">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="id" value="<%= product.getId() %>">

                    <div class="form-group">
                        <label>Product Name *</label>
                        <input type="text" name="name" value="<%= product.getName() %>" required>
                    </div>

                    <div class="form-group">
                        <label>Category</label>
                        <select name="categoryId">
                            <option value="">-- Select Category --</option>
                            <%
                                List<Category> categories = (List<Category>) request.getAttribute("categories");
                                Integer currentCatId = product.getCategory() != null ? product.getCategory().getId() : null;
                                if (categories != null) {
                                    for (Category cat : categories) {
                            %>
                                <option value="<%= cat.getId() %>" <%= (currentCatId != null && currentCatId.equals(cat.getId())) ? "selected" : "" %>>
                                    <%= cat.getName() %>
                                </option>
                            <%
                                    }
                                }
                            %>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>Description</label>
                        <textarea name="description" rows="4"><%= product.getDescription() != null ? product.getDescription() : "" %></textarea>
                    </div>

                    <div style="display:grid; grid-template-columns:1fr 1fr; gap:20px;">
                        <div class="form-group">
                            <label>Price (R) *</label>
                            <input type="number" name="price" step="0.01" min="0" value="<%= product.getPrice() %>" required>
                        </div>
                        <div class="form-group">
                            <label>Sale Price (R)</label>
                            <input type="number" name="salePrice" step="0.01" min="0"
                                   value="<%= product.getSalePrice() != null ? product.getSalePrice() : "" %>">
                        </div>
                    </div>

                    <div style="display:grid; grid-template-columns:1fr 1fr; gap:20px;">
                        <div class="form-group">
                            <label>Stock Quantity</label>
                            <input type="number" name="stockQuantity" min="0" value="<%= product.getStockQuantity() %>">
                        </div>
                        <div class="form-group">
                            <label>&nbsp;</label>
                            <div style="padding-top:35px;">
                                <input type="checkbox" name="isFeatured" id="isFeatured" style="width:auto; margin-right:8px;"
                                       <%= Boolean.TRUE.equals(product.getIsFeatured()) ? "checked" : "" %>>
                                <label for="isFeatured" style="display:inline; font-weight:400;">Featured</label>
                                <br>
                                <input type="checkbox" name="isActive" id="isActive" style="width:auto; margin-right:8px;"
                                       <%= Boolean.TRUE.equals(product.getIsActive()) ? "checked" : "" %>>
                                <label for="isActive" style="display:inline; font-weight:400;">Active</label>
                            </div>
                        </div>
                    </div>

                    <%-- Existing images --%>
                    <% if (product.getImages() != null && !product.getImages().isEmpty()) { %>
                        <div class="form-group">
                            <label>Current Images (click 🗑️ to delete)</label>
                            <div style="display:flex; gap:10px; flex-wrap:wrap;">
                                <% for (ProductImage img : product.getImages()) { %>
                                    <div style="position:relative;">
                                        <img src="${pageContext.request.contextPath}<%= img.getImagePath() %>"
                                             style="width:100px; height:100px; object-fit:cover; border-radius:6px; border:2px solid #eee;">
                                        <form method="POST" action="${pageContext.request.contextPath}/AdminProductServlet"
                                              style="position:absolute; top:2px; right:2px;"
                                              onsubmit="return confirm('Delete this image?');">
                                            <input type="hidden" name="action" value="deleteImage">
                                            <input type="hidden" name="imageId" value="<%= img.getId() %>">
                                            <input type="hidden" name="productId" value="<%= product.getId() %>">
                                            <button type="submit" style="background:#c33; color:#fff; border:none; border-radius:50%; width:22px; height:22px; cursor:pointer; font-size:11px;">×</button>
                                        </form>
                                    </div>
                                <% } %>
                            </div>
                        </div>
                    <% } %>

                    <div class="form-group">
                        <label>📸 Add More Images (optional)</label>
                        <input type="file" name="images" accept="image/*" multiple>
                    </div>

                    <button type="submit" class="btn btn-primary">Update Product</button>
                    <a href="${pageContext.request.contextPath}/AdminProductServlet"
                       style="display:inline-block; margin-left:15px; padding:14px 20px; color:#666; text-decoration:none;">Cancel</a>
                </form>
            </div>
        </div>
    </div>
</body>
</html>