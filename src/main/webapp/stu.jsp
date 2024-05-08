<%-- 
    Document   : stu
    Created on : 17-Nov-2023, 3:22:19 pm
    Author     : kabil
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<!DOCTYPE html>
<html style="height: 100%;">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Student Enrollment</title>
     <style>
        <%@include file="stucss.css" %>
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            margin: 0;
        }

        header {
            background-color: #3498db;
            color: white;
            padding: 10px;
            text-align: center;
        }
        
        nav {
            display: flex;
            justify-content: center;
            background-color: #2980b9;
            padding: 10px;
        }

        nav a {
            color: white;
            margin: 0 10px;
            text-decoration: none;
        }

        .content {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            text-align: center;
        }

        footer {
            text-align: center;
            padding: 10px;
            background-color: #333;
            color: white;
        }
    </style>
</head>
<body>
    <header>
        <h1>Alumni Connect</h1>
    </header>
     <nav>
        <a href="index.html">Home</a>
        <a href="register.html">Register</a>
        <a href="login.html">Login</a>
        <a href="aboutus.html">About Us</a>
    </nav>
    <div class="content">
        <div>
            <h2>Student Enrollment</h2>

            <form action="enroll" method="post">
                <label for="mentorSelect">Choose Mentor:</label>
                <select name="mentorSelect" id="mentorSelect">
                    <% 
                       
                        Connection connection = null;
                        PreparedStatement preparedStatement = null;
                        ResultSet resultSet = null;

                        try {
                           
                            Class.forName("org.postgresql.Driver");

                           
                            String url = "jdbc:postgresql://localhost:5432/postgres";
                            String username = "postgres";
                            String dbPassword = "kabi";
                            connection = DriverManager.getConnection(url, username, dbPassword);

                            
                            String sql = "SELECT name FROM alumni";
                            preparedStatement = connection.prepareStatement(sql);
                            resultSet = preparedStatement.executeQuery();

                           
                            while (resultSet.next()) {
                                String mentorName = resultSet.getString("name");
                    %>
                                <option value="<%= mentorName %>"><%= mentorName %></option>
                    <%
                            }
                        } catch (ClassNotFoundException | SQLException e) {
                            e.printStackTrace();
                        } finally {
                           
                            try {
                                if (resultSet != null) {
                                    resultSet.close();
                                }
                                if (preparedStatement != null) {
                                    preparedStatement.close();
                                }
                                if (connection != null) {
                                    connection.close();
                                }
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    %>
                </select>
                <br><br>
                <input type="submit" value="Enroll">
            </form>
        
            <form action="query" method="post">
                Enter your query:<input type="text" name="query" id="query" >
                <input type="submit" value="submit">
            </form>
            <a href="view.jsp">View Query</a>
        </div>
    </div>
    <footer>
        <p>&copy; 2023 Alumni Connect</p>
    </footer>
</body>
</html>
