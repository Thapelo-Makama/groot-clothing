/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package groot.servlet;


import groot.dao.ProductDAO;
import groot.dao.ProductImageDAO;
import groot.entity.Product;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author thapelo
 */


@WebServlet("/ProductDetailServlet")
public class ProductDetailServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();
    private final ProductImageDAO imageDAO = new ProductImageDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String idParam = req.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            res.sendRedirect(req.getContextPath() + "/ShopServlet");
            return;
        }

        try {
            Integer id = Integer.valueOf(idParam);
            Product product = productDAO.findById(id);

            if (product == null) {
                res.sendRedirect(req.getContextPath() + "/ShopServlet");
                return;
            }

            req.setAttribute("product", product);
            req.setAttribute("images", imageDAO.findByProduct(id));

        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
        }

        req.getRequestDispatcher("/product-detail.jsp").forward(req, res);
    }
}
