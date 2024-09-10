<%@ page import="java.sql.*" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.setContentType("text/html");
    PrintWriter pw = response.getWriter();
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String email = request.getParameter("email");

    try {
        // Load the MySQL JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish the connection
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/box?useSSL=false", "root", "1234");

        // Create the SQL query
        String query = "INSERT INTO user(username, password, email) VALUES (?, ?, ?)";
        PreparedStatement stm = con.prepareStatement(query);

        // Set the parameters
        stm.setString(1, username);
        stm.setString(2, password);
        stm.setString(3, email);

        // Execute the update
        int rowsInserted = stm.executeUpdate();

        // Check if the insertion was successful
        if (rowsInserted > 0) {
            // Registration successful, redirect to login.html
            response.sendRedirect("studentlogin.html");
        } else {
            pw.println("<html><body><h1>Registration not successful</h1></body></html>");
        }

        // Close the connection
        con.close();
    } catch (ClassNotFoundException e) {
        pw.println("JDBC Driver not found: " + e.getMessage());
    } catch (SQLException e) {
        pw.println("SQL error: " + e.getMessage());
    } catch (Exception e) {
        pw.println("Error: " + e.getMessage());
    }
%>
