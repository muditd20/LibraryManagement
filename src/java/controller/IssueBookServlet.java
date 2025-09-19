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
            // Check available quantity
            PreparedStatement ps1 = con.prepareStatement("SELECT quantity FROM books WHERE id=?");
            ps1.setInt(1, bookId);
            ResultSet rs = ps1.executeQuery();

            if (rs.next()) {
                int qty = rs.getInt("quantity");

                if (qty > 0) {
                    // Insert issued book with return_date = 15 din baad
                    PreparedStatement ps2 = con.prepareStatement(
                        "INSERT INTO issued_books(book_id, student_id, issue_date, return_date) " +
                        "VALUES(?, ?, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 15 DAY))"
                    );
                    ps2.setInt(1, bookId);
                    ps2.setInt(2, studentId);
                    int rows = ps2.executeUpdate();

                    if (rows > 0) {
                        // Quantity kam karo
                        PreparedStatement ps3 = con.prepareStatement(
                            "UPDATE books SET quantity = quantity - 1 WHERE id=?"
                        );
                        ps3.setInt(1, bookId);
                        ps3.executeUpdate();

                        req.setAttribute("message", "✅ Book issued successfully! Return within 15 days.");
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
