<%@page import="java.sql.*"%>
<%@page import="java.net.URLEncoder"%>
<%
    // Retrieve user input from the request
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    // Database connection and query execution
    Connection con = null;
    Statement stm = null;
    ResultSet rs = null;

    try {
        // Load database driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish connection to the database
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/box?useSSL=false", "root", "1234");

        // Create a Statement object
        stm = con.createStatement();

        // Execute query to check user credentials
        String query = "SELECT * FROM admin WHERE username = ? AND password = ?";
        PreparedStatement pstmt = con.prepareStatement(query);
        pstmt.setString(1, username);
        pstmt.setString(2, password);
        rs = pstmt.executeQuery();

        // Check if a record is found
        if (rs.next()) {
            // Redirect to home.html with the username as a query parameter
            String encodedUsername = URLEncoder.encode(username, "UTF-8");
            response.sendRedirect("details.jsp");
        } else {
            // Display error message if credentials are invalid
            out.println("<html><b><center><h1>Invalid Username or Password</h1></center></b></html>");
        }

    } catch (Exception e) {
        // Display any exception that occurs
        out.println("<html><b><center><h1>Error: " + e.getMessage() + "</h1></center></b></html>");
    } finally {
        // Close resources
        try { if (rs != null) rs.close(); } catch (Exception e) { /* Ignored */ }
        try { if (stm != null) stm.close(); } catch (Exception e) { /* Ignored */ }
        try { if (con != null) con.close(); } catch (Exception e) { /* Ignored */ }
    }
%>
