/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package groot.dao;

import groot.entity.Message;
import groot.util.JPAUtil;
import java.util.List;
import javax.persistence.EntityManager;


/**
 *
 * @author thapelo
 */


public class MessageDAO {

    public Message save(Message m) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(m);
            em.getTransaction().commit();
            return m;
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public Message update(Message m) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Message merged = em.merge(m);
            em.getTransaction().commit();
            return merged;
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public Message findById(Integer id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Message.class, id);
        } finally {
            em.close();
        }
    }

    public List<Message> findAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT m FROM Message m ORDER BY m.createdAt DESC", Message.class)
                .getResultList();
        } finally {
            em.close();
        }
    }

    public List<Message> findUnread() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT m FROM Message m WHERE m.isRead = false ORDER BY m.createdAt DESC",
                Message.class).getResultList();
        } finally {
            em.close();
        }
    }

    public void delete(Integer id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Message m = em.find(Message.class, id);
            if (m != null) em.remove(m);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public void markRead(Integer id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Message m = em.find(Message.class, id);
            if (m != null) {
                m.setIsRead(true);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public long countUnread() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT COUNT(m) FROM Message m WHERE m.isRead = false", Long.class)
                .getSingleResult();
        } finally {
            em.close();
        }
    }

    public long countAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT COUNT(m) FROM Message m", Long.class)
                     .getSingleResult();
        } finally {
            em.close();
        }
    }
}
