package controller;

import dao.BookDAO;
import model.Book;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class ViewBooksServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        BookDAO dao = new BookDAO();
        try {
            List<Book> books = dao.getAllBooks();
            req.setAttribute("books", books);
            RequestDispatcher rd = req.getRequestDispatcher("admin/view_books.jsp");
            rd.forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
