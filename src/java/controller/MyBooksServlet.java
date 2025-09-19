package controller;

import util.DBConnection;
import model.IssuedBook;
import model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class MyBooksServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User student = (User) req.getSession().getAttribute("user");
        if (student == null || !"STUDENT".equalsIgnoreCase(student.getRole())) {
            resp.sendRedirect("index.jsp");
            return;
        }

        List<IssuedBook> myBooks = new ArrayList<>();

        try (Connection con = DBConnection.getConnection()) {
      String sql =
    "SELECT ib.id AS issue_id, b.name AS book_name, ib.issue_date, ib.return_date " +
    "FROM issued_books ib " +
    "JOIN books b ON ib.book_id = b.id " +
    "WHERE ib.student_id = ?";

PreparedStatement ps = con.prepareStatement(sql);
ps.setInt(1, student.getId());
ResultSet rs = ps.executeQuery();

while (rs.next()) {
    IssuedBook ib = new IssuedBook();
    ib.setId(rs.getInt("issue_id")); 
    ib.setBookName(rs.getString("book_name"));
     LocalDate issueDate = rs.getDate("issue_date").toLocalDate();
    ib.setIssueDate(issueDate);

    java.sql.Date rd = rs.getDate("return_date");
    if (rd != null) {
        ib.setReturnDate(rd.toLocalDate());
    } else {
        ib.setReturnDate(issueDate.plusDays(14));
    }

    myBooks.add(ib);
}       } catch (SQLException e) {
            throw new ServletException(e);
        }
        req.setAttribute("myBooks", myBooks);
        req.getRequestDispatcher("student/my_books.jsp").forward(req, resp);
    }
}
