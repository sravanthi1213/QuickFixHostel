<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder" %>
<%
    // Retrieve user input from the request
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    // Database connection and query execution
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // Load database driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish connection to the database
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/box?useSSL=false", "root", "1234");

        // Create a PreparedStatement object
        String query = "SELECT * FROM user WHERE username = ? AND password = ?";
        pstmt = con.prepareStatement(query);
        pstmt.setString(1, username);
        pstmt.setString(2, password);
        rs = pstmt.executeQuery();

        // Check if a record is found
        if (rs.next()) {
            // Store the username in the session
            session.setAttribute("username", username);

            // Redirect to home.html with the username as a query parameter
            String encodedUsername = URLEncoder.encode(username, "UTF-8");
            response.sendRedirect("home.html?name=" + encodedUsername);
        } else {
            // Display error message if credentials are invalid
            out.println("<html><body><center><h1>Invalid Username or Password</h1></center></body></html>");
        }

    } catch (Exception e) {
        // Display any exception that occurs
        out.println("<html><body><center><h1>Error: " + e.getMessage() + "</h1></center></body></html>");
    } finally {
        // Close resources
        try { if (rs != null) rs.close(); } catch (Exception e) { /* Ignored */ }
        try { if (pstmt != null) pstmt.close(); } catch (Exception e) { /* Ignored */ }
        try { if (con != null) con.close(); } catch (Exception e) { /* Ignored */ }
    }
%>
