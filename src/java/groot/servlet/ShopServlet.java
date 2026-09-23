/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package groot.servlet;

import groot.dao.CategoryDAO;
import groot.dao.ProductDAO;
import groot.entity.Category;
import groot.entity.Product;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


/**
 *
 * @author thapelo
 */

@WebServlet("/ShopServlet")
public class ShopServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String categoryParam = req.getParameter("category");
        String searchParam = req.getParameter("search");

        List<Product> products;
        try {
            if (searchParam != null && !searchParam.trim().isEmpty()) {
                products = productDAO.search(searchParam.trim());
            } else if (categoryParam != null && !categoryParam.isEmpty()) {
                Integer catId = Integer.parseInt(categoryParam);
                products = productDAO.findByCategory(catId);
            } else {
                products = productDAO.findAllActive();
            }
            req.setAttribute("products", products);
            req.setAttribute("categories", categoryDAO.findAll());
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
        }

        req.getRequestDispatcher("/shop.jsp").forward(req, res);
    }
}