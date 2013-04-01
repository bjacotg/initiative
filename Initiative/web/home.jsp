<%-- 
    Document   : home
    Created on : Apr 1, 2013, 5:54:48 PM
    Author     : aero
--%>

<%
    if(session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home</title>
    </head>
    <body>
        <h1>Home</h1>
        <p>Welcome home!</p>
    </body>
</html>
