<%-- 
    Document   : search_doctor_results
    Created on : 22-Mar-2015, 11:38:53 PM
    Author     : huang
--%>

<%@ include file="/master.jsp" %>
<%@ include file="/auth.jsp" %>

<%@page import="java.util.ArrayList"%>
<%@page import="composite.DoctorReview"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <body>
        <%
            if (_patientId == -1) {
                response.sendRedirect(request.getContextPath() + "/404Page.jsp");
            }
        %>
        <div class="content">
            <%! ArrayList<DoctorReview> doctorReviews;%>
        <table width="80%" class="review-table">
            <thead>
                    <tr>
                        <th colspan="5"><h2 style="text-align:left">Doctor Search Results</h2></th>
                    </tr>
            </thead>
            <tr>
                <td>First Name</td>
                <td>Middle Name</td>
                <td>Last Name</td>
                <td>Gender</td>
                <td>Average Rating</td>
                <td>Number of Reviews</td>
                <td>Profile</td>
            </tr>
        <%
            doctorReviews = (ArrayList<DoctorReview>) request.getAttribute(
                    "doctor_reviews"
            );
            for (DoctorReview ds : doctorReviews) {
        %>
            <% 
            if(ds.getDoctor() != null){   
            %>
            <form method="post" action="Profile">
                    <tr>
                        <td>
                            <%=ds.getDoctor().getFirstName()%>
                        </td>
                            <%
                            if(ds.getDoctor().getMiddleName() != null){
                            %>
                        <td>
                            <%=ds.getDoctor().getMiddleName()%>
                        </td>
                            <%
                            }else{
                            %>
                                <td>
                                N/A
                                </td>
                            <%
                            }
                            %>
                        <td>
                            <%=ds.getDoctor().getLastName()%>
                        </td>
                        <td>
                            <%=ds.getDoctor().getGender()%>
                        </td>
                        <td>
                            <%=ds.getAverageRating()%>
                        </td>
                        <td>
                            <%=ds.getNumberOfReviews()%>
                        </td>
                        <td style="text-align: left;">
                            <input type="submit" class="button small" value="View Profile">
                        </td>
                        <input type="hidden" value="<%=ds.getDoctor().getId()%>" name="docId">
                        <input type="hidden" value="<%=ds.getDoctor().getUserId()%>" name="user_id">
                    </tr>
                
            </form>
                <%        
                }
            %>
        <%
            }
        %>
        </table>
        </div>
        <%@ include file="/footer.jsp" %>
    </body>
</html>
