package controller;

import dao.BookDAO;
import model.Book;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

public class AddBookServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.sendRedirect(req.getContextPath() + "/ViewBooksServlet");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String name = req.getParameter("name");
        String author = req.getParameter("author");
        String edition = req.getParameter("edition");
        int quantity = Integer.parseInt(req.getParameter("quantity"));
        String parkingSlot = req.getParameter("parking_slot");

        Book book = new Book();
        book.setName(name);
        book.setAuthor(author);
        book.setEdition(edition);
        book.setQuantity(quantity);
        book.setParkingSlot(parkingSlot);

        BookDAO dao = new BookDAO();
        try {
            dao.addBook(book);
            resp.sendRedirect(req.getContextPath() + "/ViewBooksServlet");
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
