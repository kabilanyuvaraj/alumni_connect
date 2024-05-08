<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.io.PrintWriter" %>
<%@page import="jakarta.servlet.http.HttpSession"%>
<%@page import="jakarta.servlet.http.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
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

        section {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
            margin: 20px;
            overflow-y: auto; 
            max-height: 80vh; 
}

        .response-container {
            width: 30%;
            margin: 10px;
            padding: 10px;
            border-radius: 8px;
            clear: both;
            overflow: hidden;
        }

        textarea {
            width: 100%;
            margin-top: 10px;
        }

        button {
            background-color: #3498db;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 5px;
            cursor: pointer;
        }

        button:hover {
            background-color: #2980b9;
        }

        footer {
            text-align: center;
            padding: 10px;
            background-color: #333;
            color: white;
            position: fixed;
            bottom: 0;
            width: 100%;
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

    <section>
        <%
            try {
               
                HttpSession sess = request.getSession(true);
                String alumniName = (String) sess.getAttribute("name");

                String sql = "select name, query from query where mentor=? and taken='no'";
                
                Class.forName("org.postgresql.Driver");

               
                String url = "jdbc:postgresql://localhost:5432/postgres";
                String username = "postgres";
                String dbPassword = "kabi";
                Connection connection = DriverManager.getConnection(url, username, dbPassword);

                PreparedStatement p = connection.prepareStatement(sql);
                p.setString(1, alumniName);
                ResultSet rs = p.executeQuery();
                while (rs.next()) {
                    String n = rs.getString(1);
                    String q = rs.getString(2);
        %>
                    <div class="response-container">
                        <form action="ans" method="post">
                            <strong>Name:</strong> <%= n %><br>
                            <strong>Query:</strong> <%= q %><br>
                            <input type="hidden" value="<%= n %>" name="name1">
                            <input type="hidden" value="<%= q %>" name="query1">
                            <label for="answer">Enter your Answer for Query:</label><br>
                            <textarea rows="5" cols="40" name="answer"></textarea><br>
                            <button type="submit">Submit</button>
                        </form>
                    </div>
                    <br>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </section>

    <footer>
        <p>&copy; 2023 Alumni Connect</p>
    </footer>

</body>
</html>
