/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package groot.util;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.util.HashMap;
import java.util.Map;

/**
 * JPA Utility class.
 * 
 * Reads JDBC credentials from environment variables:
 *   - JDBC_URL
 *   - JDBC_USER
 *   - JDBC_PASSWORD
 * 
 * Falls back to values in persistence.xml if env vars are not set
 * (useful for local development setups).
 *
 * @author thapelo
 */
public class JPAUtil {

    private static final String PERSISTENCE_UNIT = "GrootPU";
    private static EntityManagerFactory emf;

    static {
        try {
            Map<String, String> props = new HashMap<>();

            // Read credentials from environment variables
            String url = System.getenv("JDBC_URL");
            String user = System.getenv("JDBC_USER");
            String password = System.getenv("JDBC_PASSWORD");

            if (url != null && !url.isEmpty()) {
                props.put("javax.persistence.jdbc.url", url);
                System.out.println(">>> JPAUtil: Using JDBC_URL from environment");
            }
            if (user != null && !user.isEmpty()) {
                props.put("javax.persistence.jdbc.user", user);
                System.out.println(">>> JPAUtil: Using JDBC_USER from environment");
            }
            if (password != null && !password.isEmpty()) {
                props.put("javax.persistence.jdbc.password", password);
            }

            // If no env vars, props map is empty → persistence.xml values used
            emf = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT, props);

        } catch (Throwable ex) {
            System.err.println("EntityManagerFactory creation failed: " + ex);
            throw new ExceptionInInitializerError(ex);
        }
    }

    public static EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public static void shutdown() {
        if (emf != null && emf.isOpen()) {
            emf.close();
        }
    }
}