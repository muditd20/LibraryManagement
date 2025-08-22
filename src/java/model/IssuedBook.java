package model;

import java.time.LocalDate;

public class IssuedBook {
    private int id;               // issue record id (from issued_books.id)
    private String bookName;
    private String studentName;
    private LocalDate issueDate;
    private LocalDate returnDate; // <-- add this

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getBookName() { return bookName; }
    public void setBookName(String bookName) { this.bookName = bookName; }

    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }

    public LocalDate getIssueDate() { return issueDate; }
    public void setIssueDate(LocalDate issueDate) { this.issueDate = issueDate; }

    public LocalDate getReturnDate() { return returnDate; }        // <-- new getter
    public void setReturnDate(LocalDate returnDate) { this.returnDate = returnDate; } // <-- new setter
}
