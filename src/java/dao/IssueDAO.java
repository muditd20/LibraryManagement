package dao;

import model.IssuedBook;
import util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class IssueDAO {

    public void issueBook(int bookId, int studentId, java.time.LocalDate issueDate) throws SQLException {
        String sql = "INSERT INTO issued_books (book_id, student_id, issue_date) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookId);
            ps.setInt(2, studentId);
            ps.setDate(3, Date.valueOf(issueDate));
            ps.executeUpdate();
        }
    }

    public List<IssuedBook> getAllIssuedBooks() {
        List<IssuedBook> list = new ArrayList<>();
        String sql = "SELECT ib.id AS issue_id, b.name AS book_name, u.name AS student_name, ib.issue_date " +
                     "FROM issued_books ib " +
                     "JOIN books b ON ib.book_id = b.id " +
                     "JOIN users u ON ib.student_id = u.id";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                IssuedBook ibook = new IssuedBook();
                ibook.setId(rs.getInt("issue_id"));
                ibook.setBookName(rs.getString("book_name"));
                ibook.setStudentName(rs.getString("student_name"));
                ibook.setIssueDate(rs.getDate("issue_date").toLocalDate());
                list.add(ibook);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
