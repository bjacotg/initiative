<%-- 
    Document   : home
    Created on : Apr 1, 2013, 5:54:48 PM
    Author     : aero
--%>

<%@page import="server.Initiative"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>
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
               <%
            ResultSet result;
            ResultSetMetaData meta;
            int nbColumns;
        %>
        <%
            result = Initiative.getInitiative();
            meta = result.getMetaData();
            nbColumns = meta.getColumnCount();
        %>
        <p>Initiatives:</p>
        <table>
            <!-- column headers -->
            <tr>
                <th>Initiative</th>
                <th>Commitee</th>
                <th>Sign</th>
                <th>Display</th>
            </tr>
            <!-- column data -->
            <% while (result.next()) {%> 
            <tr>
                <td><%= result.getObject(2)%></td>
                <td><%= result.getObject(3)%></td>                
                <td><%= result.getObject(1)%></td>                
                <th><form name="Sign init" action="signInitiative.jsp"><button type="submit" name ="Sign" value=<%=result.getObject(1)%>>Click </button></form></th>
            </tr>
            <% }%>
        </table>

    </body>
</html>
