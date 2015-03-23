<%-- 
    Document   : search_doctor_form
    Created on : Mar 22, 2015, 5:08:59 AM
    Author     : Ajanthan Asogamoorthy
--%>

<%@ include file="/master.jsp" %>
<%@ include file="/auth.jsp" %>

<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <body>
        <%
            if (_patientId == -1) {
                response.sendRedirect(request.getContextPath() + "/404Page.jsp");
            }
        %>
        <div class="content default-padding">
            <h2>Find your Personalized Doctor</h2>
            <form method="post" action="FindDoctor">
                <fieldset>
                <legend>Personal Information</legend>
                <table>
                <tr>
                    <td width="12%">First Name</td>
                    <td>
                        <input 
                            type="text"
                            name="firstname"
                            style="margin-right: 20px;"
                            maxlength="100"
                        >
                    </td>
                    <td width="15%">Middle Name</td>
                    <td>
                        <input 
                            type="text"
                            name="middlename"
                            style="margin-right: 20px;"
                            maxlength="100"
                        >
                    </td>
                    <td width="12%">Last Name</td>
                    <td>
                        <input type="text" name="lastname" maxlength="100">
                    </td>   
                </tr>
                <tr>
                    <td width="12%">Gender</td>
                    <td style="display: inline-block; margin-top: -10px;">
                        <input name="gender" type="radio" value="male" style="position: relative; top: 10px;"> Male
                        <input name="gender" type="radio" value="female" style="position: relative; top: 10px;"> Female
                    </td>
                </tr>
                </table>
                </fieldset><br/>
                <fieldset>
                    <legend>Work Address</legend>
                    <table>
                        <tr>
                            <td width="12%">Street Number</td>
                            <td>
                                <input type="number" name="street_number" min="1">
                            </td>
                            <td width="12%">Street</td>
                            <td>
                                <input 
                                    type="text"
                                    name="street"
                                    maxlength="100"
                                    style="width: 205px;"
                                >
                            </td>
                            <td width="15%" style="padding-left: 20px;">
                                Postal Code
                            </td>
                            <td>
                                <input 
                                    type="text"
                                    name="postal_code"
                                    size="6"
                                    maxlength="6"
                                >
                            </td>
                        </tr>
                        <tr>
                            <td>City</td>
                            <td>
                                <select name="city">
                                    <option value="">Select One</option>
                                    <%! ArrayList<String> cities;%>
                                    <%
                                        cities = (ArrayList<String>) request.getAttribute("cities");
                                        for (String city : cities) {
                                    %>
                                    <option value="<%=city%>"><%=city%></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </td>
                            <td>Province</td>
                            <td>
                            <select name="province">
                                <option value="">Select One</option>
                                <option>Ontario</option>
                                <option>Quebec</option>
                                <option>British Columbia</option>
                                <option>Alberta</option>
                                <option>Saskatchewan</option>
                                <option>Winnipeg</option>
                                <option>Manitoba</option>
                                <option>Nova Scotia</option>
                                <option>New Brunswick</option>
                                <option>Newfoundland and Labrador</option>
                                <option>North West Territories</option>
                                <option>Yukon</option>
                                <option>Nunavut</option>
                            </select>
                            </td>
                        </tr>
                    </table>
                </fieldset><br/>
                <fieldset>
                    <legend>Doctor Attributes</legend>
                    <table>
                        <tr>
                            <td width="12%">Year License Obtained</td>
                            <td><input type="number" name="year_license_obtained" min="1800"></td>
                        </tr>
                        <tr>
                            <td width="12%">Specialization</td>
                            <td>
                                <select name="specialization" style="width: 160px;">
                                    <option value="">Select One</option>
                                    <%! ArrayList<String> specializations;%>
                                    <%
                                        specializations = (ArrayList<String>) request.getAttribute("specializations");
                                        for (String specialization : specializations) {
                                    %>
                                    <option value="<%=specialization%>"><%=specialization%></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td width="12%">
                                Average Rating Threshold</td>
                            <td><input type="number" name="rating_threshold" min="0" max="5"></td>
                        </tr>
                        <tr>
                            <td width="12%">Friend Reviewed</td>
                            <td><input type="checkbox" name="friend_reviewed" style="position: relative; top: 3px;"></td>
                        </tr>
                    </table>
                </fieldset><br/>
                <fieldset>
                    <legend>Review Characteristics</legend>
                    <table>
                        <tr>
                            <td width="32%">Keyword in Review</td>
                            <td>
                                <input type="text" name="keyword" size="50" maxlength="50">
                            </td>
                        </tr>
                    </table>
                </fieldset>
                <br/>
                <div style="text-align: center;">
                    <input type="submit" class="button medium" value="Search">
                </div>
            </form>
        </div>
        <%@ include file="/footer.jsp" %>
    </body>
</html>
