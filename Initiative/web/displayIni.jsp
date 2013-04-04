<%-- 
    Document   : displayIni
    Created on : Apr 3, 2013, 11:27:43 PM
    Author     : bastienjacot-guillarmod
--%>

<%@page import="java.math.BigInteger"%>
<%@page import="server.Initiative"%>
<%@page import="server.User"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Initiative</title>
    </head>
    <body>
        <h1>Online Initiative System</h1>
        <h2>Initiative review page</h2>
            <%
            ResultSet result;
            ResultSetMetaData meta;
            int nbColumns;
        %>
        <%
            User user = (User) session.getAttribute("user");
            if (user == null) {
                response.sendRedirect("login.jsp");
            }
            Initiative init = new Initiative(Long.parseLong(request.getParameter("Display")));

            result = init.getVote();
            meta = result.getMetaData();
            nbColumns = meta.getColumnCount();
            result.last();
            int size = result.getRow();
            result.first();
        %>
        <p><%="Status of the initiative:" + init.name%></p>
        <table>
            Number of votes: <%=size%>
            <!-- column headers -->
            <%if (size != 0){%>
            <tr>
                <th>Hash</th>

            </tr>
            <!-- column data -->
            <% do{%>
            <tr>
                <td><%=String.format("%040x", new BigInteger(1,result.getObject(1).toString().getBytes()))%></td>
    </tr>
    <% }while (result.next()); }%>
    </body>
</html>
