/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ece356;

import bean.Address;
import bean.Doctor;
import bean.Review;
import bean.Specialization;
import composite.ViewProfileResult;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import util.DbConnectionUtil;
import util.Factory;

/**
 *
 * @author Tommy
 */
@WebServlet(name = "ProfileServlet", urlPatterns = {"/Profile"})
public class ProfileServlet extends HttpServlet {

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
            throws ServletException, IOException, SQLException {
        
        String url = "";
        response.setContentType("text/html;charset=UTF-8");

        String docId = request.getParameter("docId");
        if (docId != null) {
            int id = -1;
            try {
                id = Integer.parseInt(docId);
            }
            catch (Exception e) {
                throw(e);
            }
            
            if (id == -1) {
                getServletContext().getRequestDispatcher("/main.jsp")
                                   .forward(request, response);
                return;
            }

            Connection con = null;
            PreparedStatement cs = null;
            PreparedStatement ps = null;
            ViewProfileResult result = new ViewProfileResult();

            try {
                con = DbConnectionUtil.getConnection();
                String userString = "SELECT user_id FROM Doctor WHERE user_id = ?;"; 
                ps = con.prepareStatement(userString);
                ps.setInt(1, id);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    cs = con.prepareCall("{call DoctorProfile(?, ?)}");
                    cs.setInt(1, id);
                    cs.setInt(2, rs.getInt(1));
                    rs = cs.executeQuery();
                    rs.next();

                    Doctor doctor = Factory.CreateDoctor(rs);
                    result.setDoctor(doctor);
                    result.setEmail(rs.getString("email"));
                    result.setAverageRating(rs.getLong("average_rating"));
                    result.setYearsLicensed(rs.getInt("years_licensed"));
                    result.setNumOfReviews(rs.getInt("num_of_reviews"));
                    
                    ArrayList<Specialization> specializations = 
                            result.getSpecializations();
                    cs = con.prepareCall("{call GetSpecializations(?)}");
                    cs.setInt(1, id);
                    rs = cs.executeQuery();
                    while (rs.next()) {
                        Specialization specialization = new Specialization();
                        specialization.setId(rs.getInt("specialization_id"));
                        specialization.setSpecialization(rs.getString("specialization"));
                        specializations.add(specialization);
                    }
                    
                    ArrayList<Address> addresses = 
                            result.getAddresses();
                    cs = con.prepareCall("{call GetDoctorAddresses(?)}");
                    cs.setInt(1, id);
                    rs = cs.executeQuery();
                    while (rs.next()) {
                        Address address = new Address();
                        address.setId(rs.getInt("address_id"));
                        address.setStreet(rs.getString("street"));
                        address.setStreetNumber(rs.getInt("street_number"));
                        address.setPostalCode(rs.getString("postal_code"));
                        address.getRegion().setCity(rs.getString("city"));
                        address.getRegion().setProvince(rs.getString("province"));
                        addresses.add(address);
                    }
                    
                    String reviewString = "Select * from Review as r Where r.doctor_id = ? ORDER BY review_date DESC;";
                    ps = con.prepareStatement(reviewString);
                    ps.setInt(1, id);
                    rs = ps.executeQuery();
                    ArrayList<Review> reviews = result.getReviews();
                    while(rs.next()) {
                        Review review = new Review();
                        review.setId(rs.getInt("id"));
                        review.setReviewDate(rs.getTimestamp("review_date"));
                        review.setRating(rs.getInt("rating"));
                        reviews.add(review);
                    }

                    request.setAttribute("ViewProfileResult", result);
                    url = "/profile.jsp";
                }
                else {
                    url = "/404Page.jsp";
                }
            } catch (NamingException | SQLException | RuntimeException ex) {
                request.setAttribute("exception", ex);
                url = "/error.jsp";
            }
            finally {
                if (cs != null) {
                    cs.close();
                }
                
                if (ps != null) {
                    ps.close();
                }
                
                DbConnectionUtil.closeConnection(con);
            }
        }
        else {
            url = "/main.jsp";
        }
        
        getServletContext().getRequestDispatcher(url).forward(request, response);
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
            request.setAttribute("exception", ex);
            getServletContext().getRequestDispatcher("/error.jsp")
                               .forward(request, response);
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
            request.setAttribute("exception", ex);
            getServletContext().getRequestDispatcher("/error.jsp")
                               .forward(request, response);
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
