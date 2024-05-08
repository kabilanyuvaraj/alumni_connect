/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author kabil
 */
public class query extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String query = request.getParameter("query");
            String url = "jdbc:postgresql://localhost:5432/postgres";
            String username = "postgres";
            String password = "kabi";
            
            Class.forName("org.postgresql.Driver");
            
            HttpSession session = request.getSession(true);
            String studentRollNumber = (String) session.getAttribute("name");
            
            Connection connection = DriverManager.getConnection(url,username,password);
            String sql1 = "Select mentor from students where name=?";
            PreparedStatement p1 = connection.prepareStatement(sql1);
            p1.setString(1,studentRollNumber);
            ResultSet rs = p1.executeQuery();
            String ment="";
            if(rs.next()){
                ment = rs.getString(1);
            }
            
            String sql = "Insert into query(name,query,taken,mentor) values(?,?,?,?)";
            PreparedStatement p = connection.prepareStatement(sql);
            
            p.setString(1,studentRollNumber);
            p.setString(2,query);
            p.setString(3,"no");
            p.setString(4,ment);
            out.println(studentRollNumber+" "+query);
            p.executeUpdate();
            response.sendRedirect(request.getContextPath() + "/stu.jsp");
        }
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(query.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(query.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
