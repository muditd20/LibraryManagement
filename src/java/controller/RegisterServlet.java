package controller;
import javax.mail.*;
import dao.UserDAO;
import model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import util.EmailUtil;
import util.MembershipUtil;
import util.PasswordGenerator;


public class RegisterServlet extends HttpServlet {
 @Override
protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    String name = req.getParameter("name");
    String email = req.getParameter("email");
    String role = req.getParameter("role");

    if (name == null || name.isEmpty() || email == null || email.isEmpty()) {
        req.setAttribute("error", "All fields are required.");
        req.getRequestDispatcher("register.jsp").forward(req, resp);
        return;
    }

    // Generate membership & password
    String membershipNo = MembershipUtil.generateMembershipNo();
String generatedPassword = PasswordGenerator.generate();

    User user = new User();
    user.setName(name);
    user.setEmail(email);
    user.setRole(role);
    user.setMembershipNo(membershipNo);
    user.setPassword(generatedPassword); 

    UserDAO dao = new UserDAO();
    try {
        if (dao.registerUser(user)) {
            // Send email karne ke liye
            String subject = "Library Registration Successful";
            String body = "Dear " + name + ",\n\n" +
                          "Your registration is successful.\n" +
                          "Membership Number: " + membershipNo + "\n" +
                          "Password: " + generatedPassword + "\n\n" +
                          "Please keep these safe.";
            EmailUtil.sendEmail(email, subject, body);

            req.setAttribute("message", "Registration successful! Membership No. and password sent to your email.");
            req.getRequestDispatcher("register.jsp").forward(req, resp);
        } else {
            req.setAttribute("error", "Registration failed.");
            req.getRequestDispatcher("register.jsp").forward(req, resp);
        }
    } catch (Exception e) {
        throw new ServletException(e);
    }
}
}
