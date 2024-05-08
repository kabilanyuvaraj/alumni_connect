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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Alumni Connect</title>
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
        }

        .message-container {
            width: 30%;
            margin: 10px;
            padding: 10px;
            border-radius: 8px;
            clear: both;
            overflow: hidden;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .message-container:hover {
            background-color: #95a5a6; /* Change color on hover */
        }

        .user-message {
            background-color: #3498db;
            color: white;
        }

        .mentor-message {
            background-color: #2ecc71;
            color: white;
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
            try{
                Class.forName("org.postgresql.Driver");
                
                String url = "jdbc:postgresql://localhost:5432/postgres";
                String user = "postgres";
                String pw = "kabi";
                
                HttpSession s = request.getSession(true);
                String name = (String) s.getAttribute("name");
                
                Connection conn = DriverManager.getConnection(url,user,pw);
                String sql = "select query,ans,mentor from query where name=?";
                PreparedStatement p = conn.prepareStatement(sql);
                p.setString(1,name);
                ResultSet rs = p.executeQuery();
                while(rs.next()){
                    String que = rs.getString(1);
                    String answer = rs.getString(2);
                    String mentor = rs.getString(3);
                    if(answer==null || answer.length()==0){
                        answer="No Answers Yet";
                    }
        %>
                <div class="message-container <%= (mentor.equals(name)) ? "mentor-message" : "user-message" %>"
                     onclick="showMessageDetails('<%= name %>', '<%= que %>', '<%= mentor %>', '<%= answer %>')">
                    <%= name %>: <%= que %><br>
                    <%= mentor %>: <%= answer %><br><br>
                </div>
        <%
                }
            }catch(Exception e){
                
            }
        %>
    </section>

    <footer>
        <p>&copy; 2023 Alumni Connect</p>
    </footer>

    <script>
        function showMessageDetails(name, que, mentor, answer) {
            var messageDetails = "From: " + name + "\n\n" +
                                "Question: " + que + "\n\n" +
                                "Mentor: " + mentor + "\n\n" +
                                "Answer: " + answer;

            alert(messageDetails);
        }
    </script>

</body>
</html>
