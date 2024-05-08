/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.sql.Connection;
import jakarta.jms.JMSException;
import jakarta.servlet.ServletException;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.logging.Level;
import java.util.logging.Logger;

public class register extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, JMSException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            String Name = request.getParameter("name");
            String password = request.getParameter("password");
            String userType = request.getParameter("usertype");
            String email = request.getParameter("email");
            String phoneNumber = request.getParameter("phonenumber");

            PreparedStatement preparedStatement = null;
            Connection connection = null;
            try {
               
                Class.forName("org.postgresql.Driver");

               
                String url = "jdbc:postgresql://localhost:5432/postgres";
                String username = "postgres";
                String dbPassword = "kabi";
                connection = DriverManager.getConnection(url, username, dbPassword);

                
                String sql;
                if ("alumni".equals(userType)) {
                    sql = "INSERT INTO alumni (name, password, email, phone) VALUES (?, ?, ?, ?)";
                } else if ("student".equals(userType)) {
                    sql = "INSERT INTO students (name, password, email, phone) VALUES (?, ?, ?, ?)";
                } else {
                    
                    response.sendRedirect(request.getContextPath() + "/register.html");
                    return;
                }

                preparedStatement = connection.prepareStatement(sql);
                preparedStatement.setString(1, Name);
                preparedStatement.setString(2, password);
                preparedStatement.setString(3, email);
                preparedStatement.setString(4, phoneNumber);
                preparedStatement.executeUpdate();

                
                response.sendRedirect(request.getContextPath() + "/index.html");
            } catch (ClassNotFoundException e) {
               
                response.sendRedirect(request.getContextPath() + "/register.html");

            } finally {
                
                try {
                    if (preparedStatement != null) {
                        preparedStatement.close();
                    }
                    if (connection != null) {
                        connection.close();
                    }
                } catch (SQLException e) {
                }
            }

        } catch (IOException | SQLException e) {

        }
    }



    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(register.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JMSException ex) {
            Logger.getLogger(register.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(register.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JMSException ex) {
            Logger.getLogger(register.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
