package controller;

import dao.BookDAO;
import model.Book;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

public class EditBookServlet extends HttpServlet {

    // Show edit form
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        BookDAO dao = new BookDAO();

        try {
            Book book = dao.getBookById(id);
            if (book == null) {
                response.sendRedirect(request.getContextPath() + "/ViewBooksServlet");
                return;
            }
            request.setAttribute("book", book);
            RequestDispatcher rd = request.getRequestDispatcher("/admin/edit_book.jsp");
            rd.forward(request, response);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    // Update book
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String author = request.getParameter("author");
        String edition = request.getParameter("edition");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String parkingSlot = request.getParameter("parkingSlot"); // FIXED NAME

        Book book = new Book(id, name, author, edition, quantity, parkingSlot);

        BookDAO dao = new BookDAO();
        try {
            dao.updateBook(book);
            response.sendRedirect(request.getContextPath() + "/ViewBooksServlet");
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
