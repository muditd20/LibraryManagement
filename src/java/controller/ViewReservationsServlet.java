package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;
import model.Reservation;
import model.User;
import util.DBConnection;

public class ViewReservationsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User admin = (User) req.getSession().getAttribute("user");
        if (admin == null || !"ADMIN".equalsIgnoreCase(admin.getRole())) {
            resp.sendRedirect("index.jsp");
            return;
        }

        List<Reservation> reservations = new ArrayList<>();

        try (Connection con = DBConnection.getConnection()) {
            String sql = "SELECT r.id, r.book_id, r.student_id, r.reservation_date, " +
                         "b.name AS book_name, u.name AS student_name " +
                         "FROM reservations r " +
                         "JOIN books b ON r.book_id = b.id " +
                         "JOIN users u ON r.student_id = u.id " +
                         "ORDER BY r.reservation_date ASC";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Reservation r = new Reservation();
                r.setId(rs.getInt("id"));
                r.setBookId(rs.getInt("book_id"));
                r.setStudentId(rs.getInt("student_id"));
                r.setReservationDate(rs.getDate("reservation_date").toLocalDate());
                r.setBookName(rs.getString("book_name"));
                r.setStudentName(rs.getString("student_name"));
                reservations.add(r);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }

        req.setAttribute("reservations", reservations);
        req.getRequestDispatcher("admin/view_reservations.jsp").forward(req, resp);
    }
}
