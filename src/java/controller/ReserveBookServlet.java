package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;
import model.User;
import util.DBConnection;

public class ReserveBookServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User student = (User) req.getSession().getAttribute("user");
        if (student == null || !"STUDENT".equalsIgnoreCase(student.getRole())) {
            resp.sendRedirect("index.jsp");
            return;
        }

        int bookId = Integer.parseInt(req.getParameter("bookId"));

        try (Connection con = DBConnection.getConnection()) {
            String sql = "INSERT INTO reservations (book_id, student_id, reservation_date) VALUES (?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, bookId);
            ps.setInt(2, student.getId());
            ps.setDate(3, Date.valueOf(LocalDate.now()));
            ps.executeUpdate();

            req.setAttribute("message", "Book reserved successfully ✅");
            req.getRequestDispatcher("student/reserve_confirmation.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
