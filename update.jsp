<%@ page import="java.sql.*" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.setContentType("text/html");
    String[] recordsToDelete = request.getParameterValues("delete[]");

    Connection con = null;
    PreparedStatement pstmt = null;

    try {
        // Load the MySQL JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish the connection
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/box?useSSL=false", "root", "1234");

        // Prepare the SQL query for deletion
        String query = "DELETE FROM status WHERE id = ?";
        pstmt = con.prepareStatement(query);

        if (recordsToDelete != null) {
            for (String record : recordsToDelete) {
                pstmt.setInt(1, Integer.parseInt(record));
                pstmt.addBatch();
            }
            pstmt.executeBatch();
        }

        // Redirect to the display page
        response.sendRedirect("details.jsp");

    } catch (ClassNotFoundException e) {
        out.println("<h3>JDBC Driver not found: " + e.getMessage() + "</h3>");
    } catch (SQLException e) {
        out.println("<h3>SQL error: " + e.getMessage() + "</h3>");
    } finally {
        // Close the resources
        try {
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            out.println("<h3>Error closing resources: " + e.getMessage() + "</h3>");
        }
    }
%>
