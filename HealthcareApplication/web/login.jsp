<%-- 
    Document   : login
    Created on : 21-Mar-2015, 11:05:47 PM
    Author     : Tommy
--%>
<%@ include file="/master.jsp" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <% String errorMessage = (String)request.getAttribute("errorMessage"); %>
    <%! String username = "";%>
    <% 
        Object name = request.getAttribute("username");
        if (name != null) {
            username = (String) name;
        } 
    %>
    
    <body>
        <div style="padding: 20px;">
            <form action="AuthenticationServlet" method=post>
                <p>Username</p>
                <input type="text" name="username" value="<%=username%>" size="45">
                <p>Password</p>
                <input type="password" size="45" name="password"><br/>
                <br/><br/>
                <input type="submit" value="Login" class="button login"><br/><br/>
                <a href="">Create an account</a>
                <%
                    if (errorMessage != null) {
                %>
                    <p style="color: red;"><%=errorMessage%></p>
                <%
                    }
                %>
            </form>
        </div>
    </body>
</html>