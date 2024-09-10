<%@ page import="java.sql.*" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.setContentType("text/html");
    PrintWriter pw = response.getWriter();
    String studentName = request.getParameter("studentName");
    String registrationNumber = request.getParameter("registrationNumber");
    String hostelName = request.getParameter("hostelName");
    String roomNumber = request.getParameter("roomNumber");
    String description = request.getParameter("description");

    try {
        // Load the MySQL JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish the connection
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/box?useSSL=false", "root", "1234");

        // Create the SQL query
        String query = "INSERT INTO status (studentName, registrationNumber, hostelName, roomNumber, description) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement stm = con.prepareStatement(query);

        // Set the parameters
        stm.setString(1, studentName);
        stm.setString(2, registrationNumber);
        stm.setString(3, hostelName);
        stm.setString(4, roomNumber);
        stm.setString(5, description);

        // Print the query for debugging purposes
        pw.println("Query: " + stm.toString());

        // Execute the update
        int rowsInserted = stm.executeUpdate();

        // Check if the insertion was successful
        if (rowsInserted > 0) {
            // Registration successful, redirect to home.html with studentName as query parameter
            response.sendRedirect("home.html?name=" + studentName);
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
