package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class LogoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false); // existing session
        if (session != null) {
            session.invalidate(); // destroy session
        }
        resp.sendRedirect(req.getContextPath() + "/index.jsp"); // back to login
    }
}
