<%-- 
    Document   : about
    Created on :10 may 2026, 12:00:43
    Author     : thapelo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>About — Groot Clothing</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="navbar">
        <a href="${pageContext.request.contextPath}/" class="logo">GROOT <span>CLOTHING</span></a>
        <ul>
            <li><a href="${pageContext.request.contextPath}/">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/ShopServlet">Shop</a></li>
            <li><a href="${pageContext.request.contextPath}/EventsServlet">Events</a></li>
            <li><a href="${pageContext.request.contextPath}/about.jsp">About</a></li>
            <li><a href="${pageContext.request.contextPath}/ContactServlet">Contact</a></li>
            <% if (session.getAttribute("userId") != null) { %>
                <li><a href="${pageContext.request.contextPath}/LogoutServlet">Logout</a></li>
            <% } else { %>
                <li><a href="${pageContext.request.contextPath}/login.jsp" class="btn-nav">Login</a></li>
            <% } %>
        </ul>
    </div>

    <section class="hero" style="padding:80px 40px;">
        <h1>Our <span class="accent">Story</span></h1>
        <p>Bold fashion rooted in culture, community, and youth empowerment.</p>
    </section>

    <div class="container" style="max-width:900px;">
        <div class="section-title">
            <h2>About Groot Clothing</h2>
            <div class="divider"></div>
        </div>

        <p style="font-size:17px; line-height:1.9; color:#444; margin-bottom:25px;">
            <strong>Groot Clothing Brand</strong> was founded by <strong>Malokase</strong> in Marble Hall, Limpopo —
            a brand born from a love for bold African streetwear and a deep commitment to empowering
            young talent in our communities.
        </p>

        <p style="font-size:17px; line-height:1.9; color:#444; margin-bottom:25px;">
            We design and produce clothing that celebrates our identity — combining modern street
            fashion with the vibrant energy of South African youth culture. Every piece tells a story.
        </p>

        <div style="background:#1a1a1a; color:#fff; padding:40px; border-radius:12px; margin:40px 0;">
            <h3 style="color:#f4a261; margin-bottom:20px; font-size:26px;">GROOT ANNUALLY</h3>
            <p style="line-height:1.9; opacity:0.9; margin-bottom:15px;">
                Every year, we host <strong>Groot Annually</strong> — a youth talent showcase held at
                <strong>Moutse West</strong> (Zama Gakekana &amp; Ga-Feni). Young dancers, models, and
                fashion designers take the stage to showcase their craft.
            </p>
            <p style="line-height:1.9; opacity:0.9;">
                This event is more than a show — it's a platform for opportunity, connecting talented
                young people with jobs and recognition in the fashion and entertainment industry.
            </p>
        </div>

        <h3 style="color:#1a1a1a; margin-top:40px; margin-bottom:15px;">Our Mission</h3>
        <ul style="font-size:16px; line-height:2; color:#555; padding-left:20px;">
            <li>Empower youth through fashion and creativity</li>
            <li>Create job opportunities for local designers and models</li>
            <li>Celebrate South African culture through bold design</li>
            <li>Build a platform where talent meets opportunity</li>
        </ul>

        <div style="text-align:center; margin-top:50px;">
            <a href="${pageContext.request.contextPath}/ShopServlet" class="btn btn-primary">Shop Our Collection</a>
            <a href="${pageContext.request.contextPath}/EventsServlet" class="btn btn-outline" style="color:#1a1a1a; border-color:#1a1a1a; margin-left:10px;">See Events</a>
        </div>
    </div>

    <footer class="footer">
        <div class="footer-content">
            <div>
                <h4>GROOT CLOTHING</h4>
                <p>Bold African fashion. Made with pride in Marble Hall, Limpopo.</p>
            </div>
            <div>
                <h4>Contact</h4>
                <p>📍 Line 5, Marble Hall, 0450</p>
                <p>📞 072 202 7820</p>
                <p>✉️ kmalokase77@gmail.com</p>
            </div>
            <div>
                <h4>Events</h4>
                <p>Groot Annually</p>
                <p>Moutse West</p>
                <p>Zama Gakekana · Ga-Feni</p>
            </div>
        </div>
        <div class="footer-bottom">
            © 2026 Groot Clothing Brand. Owned by Malokase.
        </div>
    </footer>
</body>
</html>
