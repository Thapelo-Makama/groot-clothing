/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package groot.dao;

import groot.entity.ProductImage;
import groot.util.JPAUtil;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;

/**
 *
 * @author thapelo
 */


public class ProductImageDAO {

    public ProductImage save(ProductImage img) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(img);
            em.getTransaction().commit();
            return img;
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public ProductImage findById(Integer id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(ProductImage.class, id);
        } finally {
            em.close();
        }
    }

    public List<ProductImage> findByProduct(Integer productId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<ProductImage> q = em.createQuery(
                "SELECT i FROM ProductImage i WHERE i.product.id = :pid ORDER BY i.displayOrder, i.id",
                ProductImage.class);
            q.setParameter("pid", productId);
            return q.getResultList();
        } finally {
            em.close();
        }
    }

    public ProductImage findPrimary(Integer productId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<ProductImage> q = em.createQuery(
                "SELECT i FROM ProductImage i WHERE i.product.id = :pid AND i.isPrimary = true",
                ProductImage.class);
            q.setParameter("pid", productId);
            q.setMaxResults(1);
            List<ProductImage> results = q.getResultList();
            return results.isEmpty() ? null : results.get(0);
        } finally {
            em.close();
        }
    }

    public void delete(Integer id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            ProductImage img = em.find(ProductImage.class, id);
            if (img != null) em.remove(img);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public void deleteByProduct(Integer productId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.createQuery("DELETE FROM ProductImage i WHERE i.product.id = :pid")
              .setParameter("pid", productId)
              .executeUpdate();
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }
}