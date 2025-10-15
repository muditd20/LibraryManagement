package controller;

import util.DBConnection;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class ReturnBookServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String issueIdStr = req.getParameter("issue_id");
        if (issueIdStr == null || issueIdStr.isEmpty()) {
            resp.sendRedirect("student/my_books.jsp?error=Invalid+book+selection");
            return;
        }

        int issueId = Integer.parseInt(issueIdStr);

        try (Connection con = DBConnection.getConnection()) {
            con.setAutoCommit(false);

            String findSql = "SELECT book_id FROM issued_books WHERE id=?";
            PreparedStatement findPs = con.prepareStatement(findSql);
            findPs.setInt(1, issueId);
            ResultSet rs = findPs.executeQuery();

            if (!rs.next()) {
                resp.sendRedirect("student/my_books.jsp?error=Invalid+issue+record");
                return;
            }

            int bookId = rs.getInt("book_id");

            String deleteSql = "DELETE FROM issued_books WHERE id=?";
            PreparedStatement delPs = con.prepareStatement(deleteSql);
            delPs.setInt(1, issueId);
            delPs.executeUpdate();

            String resSql = "SELECT * FROM reservations WHERE book_id=? ORDER BY reservation_date ASC LIMIT 1";
            PreparedStatement resPs = con.prepareStatement(resSql);
            resPs.setInt(1, bookId);
            ResultSet resRs = resPs.executeQuery();

            if (resRs.next()) {
                int reservationId = resRs.getInt("id");
                int reservedStudentId = resRs.getInt("student_id");

                String issueSql = "INSERT INTO issued_books (book_id, student_id, issue_date, return_date, is_renewed) " +
                                  "VALUES (?, ?, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 15 DAY), FALSE)";
                PreparedStatement issuePs = con.prepareStatement(issueSql);
                issuePs.setInt(1, bookId);
                issuePs.setInt(2, reservedStudentId);
                issuePs.executeUpdate();

                String delResSql = "DELETE FROM reservations WHERE id=?";
                PreparedStatement delResPs = con.prepareStatement(delResSql);
                delResPs.setInt(1, reservationId);
                delResPs.executeUpdate();

            } else {
                String updateBookSql = "UPDATE books SET quantity = quantity + 1 WHERE id=?";
                PreparedStatement updBookPs = con.prepareStatement(updateBookSql);
                updBookPs.setInt(1, bookId);
                updBookPs.executeUpdate();
            }

            con.commit();
            resp.sendRedirect("student/my_books.jsp?message=Book+returned+successfully");

        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException(e);
        }
    }
}
