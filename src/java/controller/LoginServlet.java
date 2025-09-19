package controller;

import dao.UserDAO;
import model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String membershipNo = req.getParameter("membership_no");
        String password = req.getParameter("password");
        String role = req.getParameter("role");   // role bhi fetch karo

        UserDAO dao = new UserDAO();

        try {
            // role ke sath validate karo
            User user = dao.loginUser(membershipNo, password, role);

            if (user != null) {
                HttpSession session = req.getSession();
                session.setAttribute("user", user); 
                session.setAttribute("studentId", user.getId()); 
                
                if ("ADMIN".equalsIgnoreCase(user.getRole())) {
                    resp.sendRedirect("admin/dashboard.jsp");
                } else if ("STUDENT".equalsIgnoreCase(user.getRole())) {
                    resp.sendRedirect("student/home.jsp");
                } else {
                    req.setAttribute("error", "Invalid role selected.");
                    req.getRequestDispatcher("index.jsp").forward(req, resp);
                }
            } else {
                req.setAttribute("error", "Invalid Membership No, Password, or Role.");
                req.getRequestDispatcher("index.jsp").forward(req, resp);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
