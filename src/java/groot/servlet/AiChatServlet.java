/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package groot.servlet;

import groot.dao.EventDAO;
import groot.dao.ProductDAO;
import groot.entity.Event;
import groot.entity.Product;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Rule-based AI assistant for the Groot Clothing home page.
 * Answers common customer questions using keyword matching.
 *
 * @author thapelo
 */
@WebServlet("/AiChatServlet")
public class AiChatServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();
    private final EventDAO eventDAO = new EventDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        res.setContentType("text/plain;charset=UTF-8");

        String message = req.getParameter("message");
        if (message == null || message.trim().isEmpty()) {
            res.getWriter().print("Please type a question.");
            return;
        }

        String q = message.toLowerCase().trim();
        String response = generateResponse(q);

        PrintWriter out = res.getWriter();
        out.print(response);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        res.sendRedirect(req.getContextPath() + "/");
    }

    private String generateResponse(String q) {
        // Greetings
        if (matches(q, "hi", "hello", "hey", "good morning", "good afternoon", "good evening")) {
            return "Hello! 👋 Welcome to Groot Clothing. I can help with products, events, ordering, "
                 + "delivery, or general info. What would you like to know?";
        }

        // Brand info
        if (matches(q, "about", "who are you", "who is groot", "brand", "story", "owner", "malokase", "founded")) {
            return "Groot Clothing is a South African fashion brand founded by Malokase in Marble Hall, Limpopo. "
                 + "We design bold African streetwear that celebrates our culture and empowers young talent. "
                 + "Every year we host 'Groot Annually' — a youth talent showcase at Moutse West.";
        }

        // Location / contact
        if (matches(q, "where", "location", "address", "based", "situated", "contact", "phone", "call", "email", "reach", "whatsapp")) {
            return "📍 Based in Marble Hall, Limpopo (Line 5, 0450).\n"
                 + "📞 Phone/WhatsApp: 072 202 7820\n"
                 + "✉️ Email: kmalokase77@gmail.com";
        }

        // How to order
        if (matches(q, "order", "buy", "purchase", "how to buy", "checkout", "payment", "pay")) {
            return "We take orders via WhatsApp! 💬\n\n"
                 + "1. Browse the Shop and find what you like\n"
                 + "2. Click 'Order on WhatsApp' on the product page\n"
                 + "3. Send us a message — we'll confirm stock + delivery\n\n"
                 + "WhatsApp: 072 202 7820";
        }

        // Products list
        if (matches(q, "product", "products", "what do you sell", "clothing", "items", "catalog", "shop", "collection", "what do you have")) {
            try {
                List<Product> products = productDAO.findAllActive();
                if (products.isEmpty()) {
                    return "Our collection is being updated right now. Check back soon! 🛍️";
                }
                StringBuilder sb = new StringBuilder("Here's what we have in stock:\n\n");
                int count = 0;
                for (Product p : products) {
                    if (count++ >= 6) { sb.append("...and more!\n"); break; }
                    sb.append("• ").append(p.getName())
                      .append(" — R").append(String.format("%.2f", p.getPrice()));
                    if (p.getCategory() != null) sb.append(" (").append(p.getCategory().getName()).append(")");
                    sb.append("\n");
                }
                sb.append("\nBrowse the full catalog at the Shop page 👕");
                return sb.toString();
            } catch (Exception e) {
                return "I couldn't load the products right now. Please visit the Shop page. 🛍️";
            }
        }

        // Prices
        if (matches(q, "price", "cost", "how much", "expensive", "cheap", "sale", "discount")) {
            try {
                List<Product> products = productDAO.findAllActive();
                if (products.isEmpty()) return "Our prices are being updated. Check the Shop page for the latest!";
                Product cheapest = products.get(0);
                Product priciest = products.get(0);
                for (Product p : products) {
                    if (p.getPrice().compareTo(cheapest.getPrice()) < 0) cheapest = p;
                    if (p.getPrice().compareTo(priciest.getPrice()) > 0) priciest = p;
                }
                return "Our prices range from R" + String.format("%.2f", cheapest.getPrice())
                     + " to R" + String.format("%.2f", priciest.getPrice()) + ".\n"
                     + "Check individual products on the Shop page for exact prices. 💰";
            } catch (Exception e) {
                return "Check the Shop page for the latest prices! 💰";
            }
        }

        // Events
        if (matches(q, "event", "events", "show", "annually", "when is", "upcoming")) {
            try {
                List<Event> events = eventDAO.findPublished();
                if (events.isEmpty()) {
                    return "No events scheduled right now, but follow us for updates on Groot Annually! 🎉";
                }
                StringBuilder sb = new StringBuilder("🎉 Our events:\n\n");
                SimpleDateFormat sdf = new SimpleDateFormat("dd MMMM yyyy");
                int count = 0;
                for (Event e : events) {
                    if (count++ >= 3) break;
                    sb.append("• ").append(e.getTitle());
                    if (e.getEventDate() != null) sb.append(" — ").append(sdf.format(e.getEventDate()));
                    if (e.getVenue() != null) sb.append(" @ ").append(e.getVenue());
                    sb.append("\n");
                }
                sb.append("\nSee all events on the Events page 🎤");
                return sb.toString();
            } catch (Exception e) {
                return "Check the Events page for upcoming showcases! 🎉";
            }
        }

        // Groot Annually
        if (matches(q, "groot annually", "annually", "talent show", "moutse", "zama", "ga-feni", "gakena")) {
            return "Groot Annually is our biggest event of the year! 🎉\n\n"
                 + "📍 Held at Moutse West (Zama Gakekana & Ga-Feni)\n"
                 + "🎤 Features dancers, models, and fashion designers\n"
                 + "💼 Connects young talent with job opportunities\n\n"
                 + "Follow us for the next date!";
        }

        // Sizes
        if (matches(q, "size", "sizes", "fit", "small", "medium", "large", "xl", "measurement")) {
            return "We stock sizes Small to XL. Each product page shows available sizes. "
                 + "WhatsApp us on 072 202 7820 if you need a custom fit! 📏";
        }

        // Delivery
        if (matches(q, "delivery", "shipping", "ship", "courier", "send", "post", "deliver")) {
            return "We deliver nationwide across South Africa! 🚚\n"
                 + "Delivery cost depends on your location. WhatsApp us at 072 202 7820 for a quote.";
        }

        // Returns / problems
        if (matches(q, "return", "refund", "exchange", "broken", "wrong", "damaged", "problem")) {
            return "If there's an issue with your order, contact us within 7 days:\n"
                 + "📞 WhatsApp: 072 202 7820\n"
                 + "✉️ Email: kmalokase77@gmail.com\n\n"
                 + "We'll sort it out! 🤝";
        }

        // Payment methods
        if (matches(q, "eft", "bank", "transfer", "cash", "card", "cash on delivery")) {
            return "We accept EFT, bank transfer, and cash on delivery (in Marble Hall area). "
                 + "For card payments, WhatsApp us to arrange. 💳";
        }

        // Thanks
        if (matches(q, "thank", "thanks", "cheers", "appreciate")) {
            return "You're welcome! 🙌 Let me know if you need anything else.";
        }

        // Bye
        if (matches(q, "bye", "goodbye", "see you", "later")) {
            return "Goodbye! 👋 Come back soon — and don't forget to check the Shop!";
        }

        // Default
        return "I'm not sure about that one 🤔. Try asking:\n"
             + "• What products do you sell?\n"
             + "• When is the next event?\n"
             + "• Where are you based?\n"
             + "• How do I order?\n\n"
             + "Or WhatsApp us directly: 072 202 7820";
    }

    private boolean matches(String query, String... keywords) {
        for (String kw : keywords) {
            if (query.contains(kw)) return true;
        }
        return false;
    }
}
