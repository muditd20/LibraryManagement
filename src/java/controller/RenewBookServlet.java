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
    private static final int RENEW_DAYS = 15;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User student = (User) req.getSession().getAttribute("user");
        if (student == null || !"STUDENT".equalsIgnoreCase(student.getRole())) {
            resp.sendRedirect("index.jsp");
            return;
        }

        int issuedBookId = Integer.parseInt(req.getParameter("issuedBookId"));

        try (Connection con = DBConnection.getConnection()) {
            String fetchSql = "SELECT book_id, return_date, is_renewed FROM issued_books WHERE id=? AND student_id=?";
            PreparedStatement ps = con.prepareStatement(fetchSql);
            ps.setInt(1, issuedBookId);
            ps.setInt(2, student.getId());
            ResultSet rs = ps.executeQuery();

            if (!rs.next()) {
                req.setAttribute("error", "Invalid issued book record.");
                req.getRequestDispatcher("student/renew_error.jsp").forward(req, resp);
                return;
            }

            int bookId = rs.getInt("book_id");
            LocalDate currentReturnDate = rs.getDate("return_date").toLocalDate();
            boolean alreadyRenewed = rs.getBoolean("is_renewed");

            if (alreadyRenewed) {
                req.setAttribute("error", "You can renew this book only once.");
                req.getRequestDispatcher("student/renew_error.jsp").forward(req, resp);
                return;
            }

            String reservationSql = "SELECT student_id FROM reservations WHERE book_id=? ORDER BY reservation_date ASC LIMIT 1";
            PreparedStatement resPs = con.prepareStatement(reservationSql);
            resPs.setInt(1, bookId);
            ResultSet resRs = resPs.executeQuery();

            if (resRs.next()) {
                int firstInQueue = resRs.getInt("student_id");
                if (firstInQueue != student.getId()) {
                    req.setAttribute("error", "This book has been reserved by another user. You cannot renew now.");
                    req.getRequestDispatcher("student/renew_error.jsp").forward(req, resp);
                    return;
                }
            }

            LocalDate newReturnDate = currentReturnDate.plusDays(RENEW_DAYS);
            String updateSql = "UPDATE issued_books SET return_date=?, is_renewed=TRUE WHERE id=?";
            PreparedStatement updatePs = con.prepareStatement(updateSql);
            updatePs.setDate(1, Date.valueOf(newReturnDate));
            updatePs.setInt(2, issuedBookId);

            int updated = updatePs.executeUpdate();
            if (updated > 0) {
                req.setAttribute("message", "Book renewed successfully. New return date: " + newReturnDate.format(FORMATTER));
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
