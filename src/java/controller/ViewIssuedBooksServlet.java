package controller;

import util.DBConnection;
import model.IssuedBook;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ViewIssuedBooksServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<IssuedBook> issuedList = new ArrayList<>();

        try (Connection con = DBConnection.getConnection()) {
            String sql = "SELECT ib.id, b.name AS book_name, u.name AS student_name, " +
                         "ib.issue_date, ib.return_date " +
                         "FROM issued_books ib " +
                         "JOIN books b ON ib.book_id = b.id " +
                         "JOIN users u ON ib.student_id = u.id";

            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                IssuedBook ib = new IssuedBook();
                ib.setId(rs.getInt("id"));
                ib.setBookName(rs.getString("book_name"));
                ib.setStudentName(rs.getString("student_name"));
                ib.setIssueDate(rs.getDate("issue_date").toLocalDate());

                Date returnDate = rs.getDate("return_date");
                ib.setReturnDate(returnDate != null ? returnDate.toLocalDate() : null);

                issuedList.add(ib);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }

        req.setAttribute("issuedBooks", issuedList);
        req.getRequestDispatcher("/admin/view_issued_books.jsp").forward(req, resp);
    }
}
