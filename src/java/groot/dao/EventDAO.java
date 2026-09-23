/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package groot.dao;

import groot.entity.Event;
import groot.util.JPAUtil;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;

/**
 *
 * @author thapelo
 */


public class EventDAO {

    public Event save(Event e) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(e);
            em.getTransaction().commit();
            return e;
        } catch (Exception ex) {
            em.getTransaction().rollback();
            throw ex;
        } finally {
            em.close();
        }
    }

    public Event update(Event e) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Event merged = em.merge(e);
            em.getTransaction().commit();
            return merged;
        } catch (Exception ex) {
            em.getTransaction().rollback();
            throw ex;
        } finally {
            em.close();
        }
    }

    public Event findById(Integer id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Event.class, id);
        } finally {
            em.close();
        }
    }

    public Event findBySlug(String slug) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Event> q = em.createQuery(
                "SELECT e FROM Event e WHERE e.slug = :slug", Event.class);
            q.setParameter("slug", slug);
            return q.getSingleResult();
        } catch (NoResultException ex) {
            return null;
        } finally {
            em.close();
        }
    }

    public List<Event> findPublished() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT e FROM Event e WHERE e.isPublished = true ORDER BY e.eventDate DESC",
                Event.class).getResultList();
        } finally {
            em.close();
        }
    }

    public List<Event> findAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT e FROM Event e ORDER BY e.eventDate DESC", Event.class)
                .getResultList();
        } finally {
            em.close();
        }
    }

    public List<Event> findUpcoming() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT e FROM Event e WHERE e.eventDate >= CURRENT_TIMESTAMP AND e.isPublished = true ORDER BY e.eventDate ASC",
                Event.class).getResultList();
        } finally {
            em.close();
        }
    }

    public void delete(Integer id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Event e = em.find(Event.class, id);
            if (e != null) em.remove(e);
            em.getTransaction().commit();
        } catch (Exception ex) {
            em.getTransaction().rollback();
            throw ex;
        } finally {
            em.close();
        }
    }
}
