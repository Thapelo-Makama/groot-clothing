/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package groot.servlet;

import groot.dao.CategoryDAO;
import groot.dao.ProductDAO;
import groot.dao.ProductImageDAO;
import groot.entity.Category;
import groot.entity.Product;
import groot.entity.ProductImage;
import groot.util.FileUploadUtil;
import groot.util.SlugUtil;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

/**
 *
 * @author thapelo
 */

@WebServlet("/AdminProductServlet")
@MultipartConfig(maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 50)
public class AdminProductServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO();
    private final ProductImageDAO imageDAO = new ProductImageDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        // ===== NEW: Handle "add" action — forward with categories loaded =====
        if ("add".equals(action)) {
            req.setAttribute("categories", categoryDAO.findAll());
            req.getRequestDispatcher("/admin/add-product.jsp").forward(req, res);
            return;
        }

        // Handle "edit" action
        if ("edit".equals(action)) {
            String idParam = req.getParameter("id");
            if (idParam != null) {
                Product product = productDAO.findById(Integer.parseInt(idParam));
                req.setAttribute("product", product);
                req.setAttribute("categories", categoryDAO.findAll());
                req.getRequestDispatcher("/admin/edit-product.jsp").forward(req, res);
                return;
            }
        }

        // Default: list all products
        req.setAttribute("products", productDAO.findAll());
        req.setAttribute("categories", categoryDAO.findAll());
        req.getRequestDispatcher("/admin/products.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        try {
            if ("create".equals(action)) {
                handleCreate(req, res);
            } else if ("update".equals(action)) {
                handleUpdate(req, res);
            } else if ("delete".equals(action)) {
                handleDelete(req, res);
            } else if ("deleteImage".equals(action)) {
                handleDeleteImage(req, res);
            }
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.setAttribute("categories", categoryDAO.findAll());
            req.getRequestDispatcher("/admin/add-product.jsp").forward(req, res);
        }
    }

    private void handleCreate(HttpServletRequest req, HttpServletResponse res)
            throws Exception {

        Product p = new Product();
        p.setName(req.getParameter("name"));
        p.setSlug(SlugUtil.toSlug(req.getParameter("name")) + "-" + System.currentTimeMillis());
        p.setDescription(req.getParameter("description"));

        String priceStr = req.getParameter("price");
        p.setPrice(new BigDecimal(priceStr));

        String salePriceStr = req.getParameter("salePrice");
        if (salePriceStr != null && !salePriceStr.isEmpty()) {
            p.setSalePrice(new BigDecimal(salePriceStr));
        }

        String stockStr = req.getParameter("stockQuantity");
        p.setStockQuantity(stockStr != null && !stockStr.isEmpty() ? Integer.parseInt(stockStr) : 0);

        String catId = req.getParameter("categoryId");
        if (catId != null && !catId.isEmpty()) {
            Category cat = categoryDAO.findById(Integer.parseInt(catId));
            p.setCategory(cat);
        }

        p.setIsFeatured(req.getParameter("isFeatured") != null);
        p.setIsActive(true);

        productDAO.save(p);

        // Save images
        List<Part> imageParts = (List<Part>) req.getParts().stream()
                .filter(part -> part.getName().equals("images") && part.getSize() > 0)
                .collect(java.util.stream.Collectors.toList());

        boolean first = true;
        for (Part imagePart : imageParts) {
            String path = FileUploadUtil.saveUploadedFile(imagePart, "products");
            if (path != null) {
                ProductImage img = new ProductImage();
                img.setProduct(p);
                img.setImagePath(path);
                img.setIsPrimary(first);
                img.setDisplayOrder(first ? 0 : 1);
                imageDAO.save(img);
                first = false;
            }
        }

        res.sendRedirect(req.getContextPath() + "/AdminProductServlet?success=created");
    }

    private void handleUpdate(HttpServletRequest req, HttpServletResponse res)
            throws Exception {

        Integer id = Integer.parseInt(req.getParameter("id"));
        Product p = productDAO.findById(id);

        if (p == null) {
            res.sendRedirect(req.getContextPath() + "/AdminProductServlet");
            return;
        }

        p.setName(req.getParameter("name"));
        p.setDescription(req.getParameter("description"));
        p.setPrice(new BigDecimal(req.getParameter("price")));

        String salePriceStr = req.getParameter("salePrice");
        p.setSalePrice(salePriceStr != null && !salePriceStr.isEmpty() ? new BigDecimal(salePriceStr) : null);

        String stockStr = req.getParameter("stockQuantity");
        p.setStockQuantity(stockStr != null && !stockStr.isEmpty() ? Integer.parseInt(stockStr) : 0);

        String catId = req.getParameter("categoryId");
        if (catId != null && !catId.isEmpty()) {
            p.setCategory(categoryDAO.findById(Integer.parseInt(catId)));
        } else {
            p.setCategory(null);
        }

        p.setIsFeatured(req.getParameter("isFeatured") != null);
        p.setIsActive(req.getParameter("isActive") != null);

        productDAO.update(p);

        // Add new images
        for (Part imagePart : req.getParts()) {
            if (imagePart.getName().equals("images") && imagePart.getSize() > 0) {
                String path = FileUploadUtil.saveUploadedFile(imagePart, "products");
                if (path != null) {
                    ProductImage img = new ProductImage();
                    img.setProduct(p);
                    img.setImagePath(path);
                    img.setIsPrimary(false);
                    img.setDisplayOrder(1);
                    imageDAO.save(img);
                }
            }
        }

        res.sendRedirect(req.getContextPath() + "/AdminProductServlet?success=updated");
    }

    private void handleDelete(HttpServletRequest req, HttpServletResponse res)
            throws Exception {
        Integer id = Integer.parseInt(req.getParameter("id"));
        productDAO.delete(id);
        res.sendRedirect(req.getContextPath() + "/AdminProductServlet?success=deleted");
    }

    private void handleDeleteImage(HttpServletRequest req, HttpServletResponse res)
            throws Exception {
        Integer imageId = Integer.parseInt(req.getParameter("imageId"));
        Integer productId = Integer.parseInt(req.getParameter("productId"));

        ProductImage img = imageDAO.findById(imageId);
        if (img != null) {
            FileUploadUtil.deleteUploadedFile(img.getImagePath());
            imageDAO.delete(imageId);
        }

        res.sendRedirect(req.getContextPath() + "/AdminProductServlet?action=edit&id=" + productId);
    }
}