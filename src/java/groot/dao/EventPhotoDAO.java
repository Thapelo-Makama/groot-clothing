/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package groot.dao;

import groot.entity.EventPhoto;
import groot.util.JPAUtil;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;

/**
 *
 * @author thapelo
 */




public class EventPhotoDAO {

    public EventPhoto save(EventPhoto photo) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(photo);
            em.getTransaction().commit();
            return photo;
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public EventPhoto findById(Integer id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(EventPhoto.class, id);
        } finally {
            em.close();
        }
    }

    public List<EventPhoto> findByEvent(Integer eventId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<EventPhoto> q = em.createQuery(
                "SELECT p FROM EventPhoto p WHERE p.event.id = :eid ORDER BY p.displayOrder, p.id",
                EventPhoto.class);
            q.setParameter("eid", eventId);
            return q.getResultList();
        } finally {
            em.close();
        }
    }

    public void delete(Integer id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            EventPhoto p = em.find(EventPhoto.class, id);
            if (p != null) em.remove(p);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public void deleteByEvent(Integer eventId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.createQuery("DELETE FROM EventPhoto p WHERE p.event.id = :eid")
              .setParameter("eid", eventId)
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
     