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
    <title>Alumni Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            display: flex;
            flex-direction: column; 
            min-height: 100vh;
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
            display: grid;
            grid-template-columns: repeat(3, 1fr); 
            gap: 20px;
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background-color: white;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            overflow: auto; 
        }

        .welcome-message,
        .students-header {
            text-align: center;
            width: 100%;
            margin-bottom: 20px;
        }

        .container {
            display: grid;
            grid-template-columns: repeat(3, 1fr); 
            gap: 20px;
            max-height: 400px; 
            overflow-y: auto; 
        }

        .card {
            border: 1px solid #ccc;
            padding: 10px;
            background-color: #ecf0f1; 
            border-radius: 5px;
            text-align: center;
            cursor: pointer;
        }

        .card h3 {
            color: #333;
            font-size: 14px;
            margin-bottom: 5px;
        }

        .card p {
            color: #666;
            font-size: 12px;
            margin-bottom: 3px;
        }

        .mentor-name {
            text-align: center;
            color: #3498db;
            margin-bottom: 10px;
            font-size: 18px;
        }

        .link-to-response {
            text-align: center;
            margin-top: 20px;
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

        
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.7);
        }

        .modal-content {
            background-color: #fefefe;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }

        footer {
            text-align: center;
            padding: 10px;
            background-color: #333;
            color: white;
            position: relative;
            width: 100%;
            margin-top: auto;
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
    <%
        
        HttpSession sess = request.getSession(true);
        String alumniName = (String) sess.getAttribute("name");

      
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            
            Class.forName("org.postgresql.Driver");

         
            String url = "jdbc:postgresql://localhost:5432/postgres";
            String username = "postgres";
            String dbPassword = "kabi";
            connection = DriverManager.getConnection(url, username, dbPassword);

          
            String sql = "SELECT name, email, phone FROM students WHERE mentor=?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, alumniName);

            resultSet = preparedStatement.executeQuery();
    %>
    <div class="mentor-name"><h3>Welcome, <%= alumniName %>!</h3></div> 
    <div class="students-header">Students mentored by you:</div>
    <section>
        <%
            while (resultSet.next()) {
                String name = resultSet.getString("name");
                String email = resultSet.getString("email");
                String phone = resultSet.getString("phone");
        %>
        <div class='card' onclick="showDetails('<%= name %>', '<%= email %>', '<%= phone %>')">
            <h3><%= name %></h3>
            <p>Email: <%= email %></p>
            <p>Phone: <%= phone %></p>
        </div>
        <%
            }
        %>
        <div class="link-to-response"><a href="respond.jsp">Go To Response Page</a></div>
    </section>
    <div id="alumniModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal()">&times;</span>
            <h2 id="alumniName"></h2>
            <p id="alumniDetails"></p>
        </div>
    </div>
    
   
   
   
    <footer>
        <p>&copy; 2023 Alumni Connect</p>
    </footer>

    <script>
        function showDetails(name, email, phone) {
            var modal = document.getElementById("alumniModal");
            var alumniName = document.getElementById("alumniName");
            var alumniDetails = document.getElementById("alumniDetails");

            alumniName.innerHTML = name;
            alumniDetails.innerHTML = "Email: " + email + "<br>Phone: " + phone;

            modal.style.display = "block";
        }

        function closeModal() {
            var modal = document.getElementById("alumniModal");
            modal.style.display = "none";
        }

        // Close the modal if the user clicks outside of it
        window.onclick = function(event) {
            var modal = document.getElementById("alumniModal");
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    </script>

    <%
        } catch (ClassNotFoundException | SQLException e) {
           
        } 
    %>
</body>
</html>
