package model;

public class Book {
    private int id;
    private String name;
    private String author;
    private String edition;
    private int quantity;
    private String parkingSlot;

    public Book() {}

    public Book(int id, String name, String author, String edition, int quantity, String parkingSlot) {
        this.id = id;
        this.name = name;
        this.author = author;
        this.edition = edition;
        this.quantity = quantity;
        this.parkingSlot = parkingSlot;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getAuthor() { return author; }
    public void setAuthor(String author) { this.author = author; }

    public String getEdition() { return edition; }
    public void setEdition(String edition) { this.edition = edition; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public String getParkingSlot() { return parkingSlot; }
    public void setParkingSlot(String parkingSlot) { this.parkingSlot = parkingSlot; }
}
