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

/**
 *
 * @author kabil
 */
public class login extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String Name = request.getParameter("name");
            String password = request.getParameter("password");
            String userType = request.getParameter("usertype");

          
            Connection connection = null;
            PreparedStatement preparedStatement = null;
            ResultSet resultSet = null;

            try {
              
                Class.forName("org.postgresql.Driver");

                
                String url = "jdbc:postgresql://localhost:5432/postgres";
                String username = "postgres";
                String dbPassword = "kabi";
                connection = DriverManager.getConnection(url, username, dbPassword);

              
                String sql;
                String path;
                if (null == userType) {
                    
                    out.println("<script>alert('Invalid user type.');</script>");
                    return;
                } else switch (userType) {
                    case "student":
                        path = "/stu.jsp";
                        sql = "SELECT password FROM students WHERE name=?";
                        break;
                    case "alumni":
                        path = "/home.jsp";
                        sql = "SELECT password FROM alumni WHERE name=?";
                        break;
                    default:
                        
                        out.println("<script>alert('Invalid user type.');</script>");
                        return;
                }

                preparedStatement = connection.prepareStatement(sql);
                preparedStatement.setString(1, Name);

               
                resultSet = preparedStatement.executeQuery();

          
                if (resultSet.next()) {
              
                    String storedPassword = resultSet.getString("password");

                    if (password.equals(storedPassword)) {
                        HttpSession session = request.getSession(true);
                        session.setAttribute("name", Name);
                        response.sendRedirect(request.getContextPath() + path);
                    } else {
                       
                        out.println("<script>alert('Incorrect password. Please try again.');window.location='login.html';</script>");
                        
                    }
                } else {
                    
                    out.println("<script>alert('User not found. Please check your credentials.');window.location='login.html'</script>");
                }
            } catch (ClassNotFoundException | SQLException e) {
               
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
                  
                }
            }
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
        processRequest(request, response);
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
        processRequest(request, response);
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
