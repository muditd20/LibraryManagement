package controller;

import util.DBConnection;
import model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class RenewBookServlet extends HttpServlet {
    private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("dd/MM/yyyy");

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User student = (User) req.getSession().getAttribute("user");
        if (student == null || !"STUDENT".equalsIgnoreCase(student.getRole())) {
            resp.sendRedirect("index.jsp");
            return;
        }

        int issuedBookId = Integer.parseInt(req.getParameter("issuedBookId"));
        LocalDate newReturnDate = LocalDate.now().plusDays(7);

        try (Connection con = DBConnection.getConnection()) {
            String checkSql = "SELECT * FROM reservations WHERE book_id = (SELECT book_id FROM issued_books WHERE id = ?) AND student_id != ?";
            PreparedStatement checkPs = con.prepareStatement(checkSql);
            checkPs.setInt(1, issuedBookId);
            checkPs.setInt(2, student.getId());
            ResultSet rs = checkPs.executeQuery();

            if (rs.next()) {
                req.setAttribute("error", "This book is reserved by another student. Cannot renew.");
                req.getRequestDispatcher("student/renew_error.jsp").forward(req, resp);
                return;
            }

            String updateSql = "UPDATE issued_books SET return_date = ? WHERE id = ?";
            PreparedStatement updatePs = con.prepareStatement(updateSql);
            updatePs.setDate(1, Date.valueOf(newReturnDate));
            updatePs.setInt(2, issuedBookId);

            int rows = updatePs.executeUpdate();

            if (rows > 0) {
                String formattedDate = newReturnDate.format(FORMATTER);
                req.setAttribute("message", "Book renewed successfully. New return date: " + formattedDate);
                req.getRequestDispatcher("student/renew_confirmation.jsp").forward(req, resp);
            } else {
                req.setAttribute("error", "Failed to renew the book.");
                req.getRequestDispatcher("student/renew_error.jsp").forward(req, resp);
            }

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
