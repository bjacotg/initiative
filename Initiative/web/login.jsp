<%-- 
    Document   : initiativelist
    Created on : Apr 1, 2013, 5:18:23 PM
    Author     : aero
--%>

<%@page import="server.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Online Initiative System</h1>
        <h2>Login</h2> <%
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username != null && password != null) {
            User user = User.login(username, password);
            if (user != null) {
                session.setAttribute("user", user);
                response.sendRedirect("home.jsp");
            } else { %>
                <p>Login failed</p> <%
            }
        } %>
        <form action="login.jsp" method="post">
            <table border="0">
                <tr><td>Username:</td><td><input type="text" name="username"></td></tr>
                <tr><td>Password:</td><td><input type="password" name="password"></td></tr>
            </table>
            <input type="submit" value="Submit">
        </form>
        <p>Don't have an account? <a href="register.jsp">Register now.</a></p>
    </body>
</html>
