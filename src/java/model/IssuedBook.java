package model;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class IssuedBook {
    private int id;               
    private String bookName;
    private String studentName;
    private LocalDate issueDate;
    private LocalDate returnDate; 

    private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("dd/MM/yyyy");

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getBookName() { return bookName; }
    public void setBookName(String bookName) { this.bookName = bookName; }

    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }

    public LocalDate getIssueDate() { return issueDate; }
    public void setIssueDate(LocalDate issueDate) { this.issueDate = issueDate; }

    public LocalDate getReturnDate() { return returnDate; }      
    public void setReturnDate(LocalDate returnDate) { this.returnDate = returnDate; } 

       public String getFormattedIssueDate() {
        return issueDate != null ? issueDate.format(FORMATTER) : "";
    }

    public String getFormattedReturnDate() {
        return returnDate != null ? returnDate.format(FORMATTER) : "";
    }
}
