/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package groot.dao;

import groot.entity.Product;
import groot.util.JPAUtil;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;

/**
 *
 * @author thapelo
 */


public class ProductDAO {

    public Product save(Product p) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(p);
            em.getTransaction().commit();
            return p;
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public Product update(Product p) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Product merged = em.merge(p);
            em.getTransaction().commit();
            return merged;
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public Product findById(Integer id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Product.class, id);
        } finally {
            em.close();
        }
    }

    public Product findBySlug(String slug) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Product> q = em.createQuery(
                "SELECT p FROM Product p WHERE p.slug = :slug", Product.class);
            q.setParameter("slug", slug);
            return q.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    public List<Product> findAllActive() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT p FROM Product p WHERE p.isActive = true ORDER BY p.createdAt DESC",
                Product.class).getResultList();
        } finally {
            em.close();
        }
    }

    public List<Product> findAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT p FROM Product p ORDER BY p.createdAt DESC", Product.class)
                .getResultList();
        } finally {
            em.close();
        }
    }

    public List<Product> findByCategory(Integer categoryId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Product> q = em.createQuery(
                "SELECT p FROM Product p WHERE p.category.id = :cid AND p.isActive = true ORDER BY p.createdAt DESC",
                Product.class);
            q.setParameter("cid", categoryId);
            return q.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Product> findFeatured() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT p FROM Product p WHERE p.isFeatured = true AND p.isActive = true ORDER BY p.createdAt DESC",
                Product.class).setMaxResults(8).getResultList();
        } finally {
            em.close();
        }
    }

    public List<Product> search(String keyword) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Product> q = em.createQuery(
                "SELECT p FROM Product p WHERE LOWER(p.name) LIKE :kw AND p.isActive = true ORDER BY p.createdAt DESC",
                Product.class);
            q.setParameter("kw", "%" + keyword.toLowerCase() + "%");
            return q.getResultList();
        } finally {
            em.close();
        }
    }

    public void delete(Integer id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Product p = em.find(Product.class, id);
            if (p != null) em.remove(p);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public long countAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT COUNT(p) FROM Product p", Long.class)
                     .getSingleResult();
        } finally {
            em.close();
        }
    }
}
