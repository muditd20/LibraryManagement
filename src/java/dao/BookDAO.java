package dao;

import model.Book;
import util.DBConnection;
import java.sql.*;
import java.util.*;

public class BookDAO {

    public void addBook(Book book) throws SQLException {
        String sql = "INSERT INTO books (name, author, edition, quantity, parking_slot) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, book.getName());
            ps.setString(2, book.getAuthor());
            ps.setString(3, book.getEdition());
            ps.setInt(4, book.getQuantity());
            ps.setString(5, book.getParkingSlot());
            ps.executeUpdate();
        }
    }

    public List<Book> getAllBooks() throws SQLException {
        List<Book> list = new ArrayList<>();
        String sql = "SELECT * FROM books";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Book b = new Book(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("author"),
                    rs.getString("edition"),
                    rs.getInt("quantity"),
                    rs.getString("parking_slot")
                );
                list.add(b);
            }
        }
        return list;
    }

  public Book getBookById(int id) throws SQLException {
    String sql = "SELECT * FROM books WHERE id=?";
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            Book b = new Book();
            b.setId(rs.getInt("id"));
            b.setName(rs.getString("name"));
            b.setAuthor(rs.getString("author"));
            b.setEdition(rs.getString("edition"));
            b.setQuantity(rs.getInt("quantity"));
            b.setParkingSlot(rs.getString("parking_slot"));
            return b;
        }
    }
    return null;
}

public void updateBook(Book book) throws SQLException {
    String sql = "UPDATE books SET name=?, author=?, edition=?, quantity=?, parking_slot=? WHERE id=?";
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, book.getName());
        ps.setString(2, book.getAuthor());
        ps.setString(3, book.getEdition());
        ps.setInt(4, book.getQuantity());
        ps.setString(5, book.getParkingSlot());
        ps.setInt(6, book.getId());
        ps.executeUpdate();
    }
}


    public void deleteBook(int id) throws SQLException {
        String sql = "DELETE FROM books WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }
}
