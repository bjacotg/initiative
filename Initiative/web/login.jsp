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
        <h1>Login</h1> <%
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            if (username != null) {
                User user = User.login(username, password);
                if (user != null) {
                    session.setAttribute("user", user);
                    response.sendRedirect("home.jsp");
                } else { %>
                    <p>Login failed</p> <%
                }
            } %>
            <form action="login.jsp" method="post">
                <br/>Username: <input type="text" name="username">
                <br/>Password: <input type="password" name="password">
                <br/><input type="submit" value="Submit">
            </form> <%
            %>

    </body>
</html>
