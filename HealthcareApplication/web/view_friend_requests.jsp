<%-- 
    Document   : view_friend_requests
    Created on : Mar 22, 2015, 5:20:11 PM
    Author     : Ajanthan Asogamoorthy
--%>
<%@ include file="/master.jsp" %>
<%@ include file="/auth.jsp" %>

<%@page import="java.util.ArrayList"%>
<%@page import="bean.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <body>
        <div class="content">
            <%! ArrayList<User> users_request_friend;%>
            <%
                users_request_friend = (ArrayList<User>) request.getAttribute(
                        "users_request_friend"
                );
                for (User u : users_request_friend) {
            %>
            <%=u.getAlias()%>
            <%=u.getEmail()%>
            <%
                }
            %>
        </div>
        <%@ include file="/footer.jsp" %>
    </body> 
</html>
