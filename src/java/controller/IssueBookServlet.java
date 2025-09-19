package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import util.DBConnection;

public class IssueBookServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int bookId = Integer.parseInt(req.getParameter("bookId"));
        HttpSession session = req.getSession();
        int studentId = (int) session.getAttribute("studentId");  // login ke time store kiya hoga

        try (Connection con = DBConnection.getConnection()) {
            PreparedStatement ps1 = con.prepareStatement("SELECT quantity FROM books WHERE id=?");
            ps1.setInt(1, bookId);
            ResultSet rs = ps1.executeQuery();

            if (rs.next()) {
                int qty = rs.getInt("quantity");

                if (qty > 0) {
                    PreparedStatement ps2 = con.prepareStatement(
                        "INSERT INTO issued_books(book_id, student_id, issue_date) VALUES(?, ?, NOW())"
                    );
                    ps2.setInt(1, bookId);
                    ps2.setInt(2, studentId);
                    int rows = ps2.executeUpdate();

                    if (rows > 0) {
                        PreparedStatement ps3 = con.prepareStatement("UPDATE books SET quantity = quantity - 1 WHERE id=?");
                        ps3.setInt(1, bookId);
                        ps3.executeUpdate();

                        req.setAttribute("message", "✅ Book issued successfully!");
                    } else {
                        req.setAttribute("message", "❌ Failed to issue book. Try again!");
                    }
                } else {
                    req.setAttribute("message", "❌ Book is not available right now.");
                }
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }

req.getRequestDispatcher("student/issue_confirmation.jsp").forward(req, resp);
    }
}
