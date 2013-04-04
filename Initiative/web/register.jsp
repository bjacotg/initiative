<%-- 
    Document   : register
    Created on : Apr 3, 2013, 10:55:49 PM
    Author     : aero
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register</title>
    </head>
    <body>
        <h1>Online Initiative System</h1>
        <h2>Registration</h2> <%
        String sin = request.getParameter("sin");
        String address1 = request.getParameter("address1");
        String address2 = request.getParameter("address2");

        if (sin != null && address1 != null && address2 != null) {
            // TODO: add user request to database
            response.sendRedirect("registrationSuccessful.jsp");
        } %>
        <form action="register.jsp" method="post">
            <table border="0">
                <tr><td>SIN:</td><td><input type="text" name="sin"></td></tr>
                <tr><td>Address:</td><td><input type="text" name="address1"></td></tr>
                <tr><td></td><td><input type="text" name="address2"></td></tr>
            </table>
            <input type="submit" value="Submit">
        </form>
    </body>
</html>
