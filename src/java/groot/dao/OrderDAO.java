/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package groot.dao;


import groot.entity.Order;
import groot.util.JPAUtil;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;
/**
 *
 * @author thapelo
 */


public class OrderDAO {

    public Order save(Order o) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(o);
            em.getTransaction().commit();
            return o;
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public Order update(Order o) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Order merged = em.merge(o);
            em.getTransaction().commit();
            return merged;
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public Order findById(Integer id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Order.class, id);
        } finally {
            em.close();
        }
    }

    public Order findByOrderNumber(String num) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Order> q = em.createQuery(
                "SELECT o FROM Order o WHERE o.orderNumber = :num", Order.class);
            q.setParameter("num", num);
            return q.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    public List<Order> findAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT o FROM Order o ORDER BY o.createdAt DESC", Order.class)
                .getResultList();
        } finally {
            em.close();
        }
    }

    public List<Order> findByUser(Integer userId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Order> q = em.createQuery(
                "SELECT o FROM Order o WHERE o.user.id = :uid ORDER BY o.createdAt DESC",
                Order.class);
            q.setParameter("uid", userId);
            return q.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Order> findByStatus(String status) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Order> q = em.createQuery(
                "SELECT o FROM Order o WHERE o.status = :status ORDER BY o.createdAt DESC",
                Order.class);
            q.setParameter("status", status);
            return q.getResultList();
        } finally {
            em.close();
        }
    }

    public void delete(Integer id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Order o = em.find(Order.class, id);
            if (o != null) em.remove(o);
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
            return em.createQuery("SELECT COUNT(o) FROM Order o", Long.class)
                     .getSingleResult();
        } finally {
            em.close();
        }
    }

    public long countByStatus(String status) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT COUNT(o) FROM Order o WHERE o.status = :status", Long.class)
                .setParameter("status", status)
                .getSingleResult();
        } finally {
            em.close();
        }
    }
}