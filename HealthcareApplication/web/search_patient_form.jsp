<%-- 
    Document   : search_patient_form
    Created on : Mar 22, 2015, 9:24:36 PM
    Author     : Ajanthan Asogamoorth
--%>
<%@ include file="/master.jsp" %>
<%@ include file="/auth.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <body>
        <%
            if (_patientId == -1) {
                response.sendRedirect(request.getContextPath() + "/main.jsp");
            }
        %>
        <div class="content">
            <div class="horizontal-center">
                <h2 style="text-align: center;">
                    Lookup a Patient
                </h2>
                <div class="horizontal-center" style="width: 25%;">
                    <form action="FindPatient" method="post">
                        <p>Username Contains</p>
                        <input type="text" name="alias" size="45">
                        <p>City</p>
                        <input type="text" size="45" name="city"><br/>
                        <p>Province</p>
                        <select name="province" style="width: 347px;">
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
                        <br/><br/>
                        <div style="text-align: center;">
                            <input type="submit" value="Search" class="button medium">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <%@ include file="/footer.jsp" %>
    </body>
</html>
