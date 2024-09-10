<%@ page import="java.sql.*" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.setContentType("text/html");
    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        // Load the MySQL JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish the connection
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/box?useSSL=false", "root", "1234");

        // Create a statement
        stmt = con.createStatement();

        // Execute the query
        String query = "SELECT * FROM status";
        rs = stmt.executeQuery(query);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Status Table Details</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap');
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #ffecd2, #fcb69f);
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

  .navbar {
            width: 100%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding:8px;
            background-color: rgba(255, 255, 255, 0.8);
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            position: fixed;
            top: 0;
            left: 0;
            z-index: 1000;
        }

        .navbar .logo {
            display: flex;
            align-items: center;
            font-family: 'Pacifico', cursive;
        }

        .navbar .logo img {
            height: 50px;
            margin-right: 10px;
        }

        .navbar .menu ul {
            display: flex;
            list-style: none;
            margin: 0;
            padding: 0;
        }

        .navbar .menu ul li {
            margin: 0 15px;
        }

        .navbar .menu ul li a {
            text-decoration: none;
            color: #333;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .navbar .menu ul li a:hover {
            color: #ff9800;
        }

        .container {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 15px;
            border: 5px solid #f08a5d;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            width: 90%;
            max-width: 800px;
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 25px 0;
        }
        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: center;
        }
        th {
            background-color: #f08a5d;
            color: #fff;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        button, .delete-button {
            background-color: #f08a5d;
            color: #fff;
            border: none;
            border-radius: 8px;
            padding: 8px 12px;
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        button:hover, .delete-button:hover {
            background-color: #d07a50;
        }
        .delete-button {
            background-color: #e74c3c;
        }
        .delete-button:hover {
            background-color: #c0392b;
        }
        a.update-link {
            background-color: #3498db;
            color: #fff;
            padding: 6px 12px;
            border-radius: 4px;
            text-decoration: none;
            font-size: 14px;
        }
        a.update-link:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>
<div class="navbar">
        <div class="logo">
            <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsp9FUVMjDBoUb0og42lOx0aPuTwaTrVZ8Ng&s" alt="Quick Fix Hostel">
            <span>Quick Fix Hostel</span>
        </div>
        <div class="menu">
            <ul>
                <li><a href="lock.html">Logout</a></li>
                           </ul>
        </div>
    </div>

<div class="container">
    <h2>Status Table</h2>
    <form action="update.jsp" method="post">
        <table>
            <thead>
                <tr>
                    <th>Select</th>
                    <th>Student Name</th>
                    <th>Registration Number</th>
                    <th>Hostel Name</th>
                    <th>Room Number</th>
                    <th>Description</th>
                                    </tr>
            </thead>
            <tbody>
                <% 
                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String studentName = rs.getString("studentName");
                        String registrationNumber = rs.getString("registrationNumber");
                        String hostelName = rs.getString("hostelName");
                        String roomNumber = rs.getString("roomNumber");
                        String description = rs.getString("description");
                %>
                <tr>
                    <td><input type="checkbox" name="delete[]" value="<%= id %>"></td>
                    <td><%= studentName %></td>
                    <td><%= registrationNumber %></td>
                    <td><%= hostelName %></td>
                    <td><%= roomNumber %></td>
                    <td><%= description %></td>
                   
                </tr>
                <% 
                    } 
                %>
            </tbody>
        </table>
        <button type="submit">Delete Selected</button>
    </form>
</div>
</body>
</html>
<%
    } catch (ClassNotFoundException e) {
        out.println("<h3>JDBC Driver not found: " + e.getMessage() + "</h3>");
    } catch (SQLException e) {
        out.println("<h3>SQL error: " + e.getMessage() + "</h3>");
    } finally {
        // Close the resources
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            out.println("<h3>Error closing resources: " + e.getMessage() + "</h3>");
        }
    }
%>
