<%-- 
    AI Assistant Section — included in index.jsp
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<section id="ai-assistant" style="background:linear-gradient(135deg,#1a1a1a 0%,#2d2d2d 100%); padding:70px 20px; margin-top:60px;">
    <div style="max-width:900px; margin:0 auto; background:#fff; border-radius:16px; padding:45px; box-shadow:0 20px 60px rgba(0,0,0,0.35);">
        <div style="text-align:center; margin-bottom:30px;">
            <div style="display:inline-block; background:linear-gradient(135deg,#e63946,#c32); width:70px; height:70px; border-radius:50%; line-height:70px; font-size:36px; margin-bottom:15px;">🤖</div>
            <h2 style="color:#1a1a1a; margin-bottom:8px; font-size:34px; font-weight:800;">Ask Groot AI</h2>
            <p style="color:#666; font-size:15px;">Instant answers about products, events, orders, and delivery</p>
        </div>

        <div id="chat-window" style="height:380px; overflow-y:auto; border:2px solid #eee; border-radius:12px; padding:20px; margin-bottom:20px; background:#fafafa;">
            <div style="background:#e63946; color:#fff; padding:14px 20px; border-radius:18px 18px 18px 4px; max-width:80%; margin-bottom:14px; line-height:1.6; font-size:15px;">
                Hi! 👋 I'm <strong>Groot AI</strong>. Ask me anything about our brand, products, or events.
                <br><br>
                <span style="opacity:0.9; font-size:14px;">
                Try: "What products do you sell?" · "When is the next event?" · "How do I order?" · "Where are you based?"</span>
            </div>
        </div>

        <form id="ai-form" onsubmit="grootSend(event)" style="display:flex; gap:10px;">
            <input type="text" id="ai-input" placeholder="Type your question..."
                   style="flex:1; padding:15px 20px; border:2px solid #e0e0e0; border-radius:10px; font-size:15px; font-family:inherit;"
                   autocomplete="off" required>
            <button type="submit" id="ai-send"
                    style="background:#e63946; color:#fff; border:none; padding:15px 35px; border-radius:10px; font-weight:700; cursor:pointer; font-size:15px; letter-spacing:1px;">
                SEND
            </button>
        </form>

        <p style="text-align:center; color:#999; font-size:13px; margin-top:15px;">
            💬 Prefer WhatsApp? <a href="https://wa.me/27722027820" target="_blank" style="color:#25D366; font-weight:600;">Chat directly: 072 202 7820</a>
        </p>
    </div>
</section>

<script>
async function grootSend(e) {
    e.preventDefault();
    const input = document.getElementById('ai-input');
    const chat = document.getElementById('chat-window');
    const msg = input.value.trim();
    if (!msg) return;

    chat.innerHTML += `<div style="text-align:right; margin-bottom:14px;">
        <div style="display:inline-block; background:#1a1a1a; color:#fff; padding:14px 20px; border-radius:18px 18px 4px 18px; max-width:80%; text-align:left; line-height:1.6; font-size:15px;">
            ${grootEscape(msg)}
        </div>
    </div>`;
    input.value = '';
    chat.scrollTop = chat.scrollHeight;

    const typingId = 'typing-' + Date.now();
    chat.innerHTML += `<div id="${typingId}" style="background:#e63946; color:#fff; padding:14px 20px; border-radius:18px 18px 18px 4px; max-width:80%; margin-bottom:14px; font-style:italic; opacity:0.85;">
        Groot AI is thinking...
    </div>`;
    chat.scrollTop = chat.scrollHeight;

    try {
        const res = await fetch('${pageContext.request.contextPath}/AiChatServlet', {
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: 'message=' + encodeURIComponent(msg)
        });
        const data = await res.text();
        document.getElementById(typingId).remove();
        chat.innerHTML += `<div style="background:#e63946; color:#fff; padding:14px 20px; border-radius:18px 18px 18px 4px; max-width:80%; margin-bottom:14px; line-height:1.6; font-size:15px; white-space:pre-line;">
            ${grootEscape(data)}
        </div>`;
    } catch (err) {
        document.getElementById(typingId).remove();
        chat.innerHTML += `<div style="background:#c33; color:#fff; padding:14px 20px; border-radius:18px 18px 18px 4px; max-width:80%; margin-bottom:14px;">
            Sorry, something went wrong. Please try again.
        </div>`;
    }
    chat.scrollTop = chat.scrollHeight;
}

function grootEscape(text) {
    const div = document.createElement('div');
    div.textContent = text;
    return div.innerHTML;
}
</script>
