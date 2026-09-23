/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package groot.dao;

import groot.entity.Notification;
import groot.util.JPAUtil;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;

/**
 *
 * @author thapelo
 */


public class NotificationDAO {

    public Notification save(Notification n) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(n);
            em.getTransaction().commit();
            return n;
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public Notification findById(Integer id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Notification.class, id);
        } finally {
            em.close();
        }
    }

    public List<Notification> findByUser(Integer userId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Notification> q = em.createQuery(
                "SELECT n FROM Notification n WHERE n.user.id = :uid ORDER BY n.createdAt DESC",
                Notification.class);
            q.setParameter("uid", userId);
            return q.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Notification> findUnreadByUser(Integer userId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Notification> q = em.createQuery(
                "SELECT n FROM Notification n WHERE n.user.id = :uid AND n.isRead = false ORDER BY n.createdAt DESC",
                Notification.class);
            q.setParameter("uid", userId);
            return q.getResultList();
        } finally {
            em.close();
        }
    }

    public void markAllRead(Integer userId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.createQuery(
                "UPDATE Notification n SET n.isRead = true WHERE n.user.id = :uid AND n.isRead = false")
                .setParameter("uid", userId)
                .executeUpdate();
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public void delete(Integer id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Notification n = em.find(Notification.class, id);
            if (n != null) em.remove(n);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public long countUnread(Integer userId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT COUNT(n) FROM Notification n WHERE n.user.id = :uid AND n.isRead = false",
                Long.class)
                .setParameter("uid", userId)
                .getSingleResult();
        } finally {
            em.close();
        }
    }
}