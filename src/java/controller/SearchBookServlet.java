package controller;

import util.DBConnection;
import model.Book;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SearchBookServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String keyword = req.getParameter("keyword");

        if (keyword == null || keyword.trim().isEmpty()) {
            req.setAttribute("books", new ArrayList<Book>());
            req.getRequestDispatcher("student/search_books.jsp").forward(req, resp);
            return;
        }

        List<Book> books = new ArrayList<>();
        try (Connection con = DBConnection.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM books WHERE name LIKE ? OR author LIKE ?");
            String searchPattern = "%" + keyword + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Book book = new Book();
                book.setId(rs.getInt("id"));
                book.setName(rs.getString("name"));
                book.setAuthor(rs.getString("author"));
                book.setEdition(rs.getString("edition"));
                book.setQuantity(rs.getInt("quantity"));
                books.add(book);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }

req.setAttribute("books", books);
req.getRequestDispatcher("/student/search_books.jsp").forward(req, resp);

    }
}
