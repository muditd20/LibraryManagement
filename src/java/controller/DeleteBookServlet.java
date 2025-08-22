package controller;

import dao.BookDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

public class DeleteBookServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");

        if (idParam != null) {
            try {
                int id = Integer.parseInt(idParam);
                BookDAO dao = new BookDAO();
                dao.deleteBook(id);
                // ✅ Redirect to the correct ViewBookServlet path
                response.sendRedirect(request.getContextPath() + "/ViewBooksServlet");
            } catch (NumberFormatException | SQLException e) {
                throw new ServletException(e);
            }
        } else {
            // If no ID is passed
            response.sendRedirect(request.getContextPath() + "/ViewBooksServlet");
        }
    }
}
