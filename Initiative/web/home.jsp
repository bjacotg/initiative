<%--
    Document   : home
    Created on : Apr 1, 2013, 5:54:48 PM
    Author     : aero
--%>

<%@page import="server.User"%>
<%@page import="server.Initiative"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>
<%
    if (session.getAttribute("user") == null) {
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
        <h2>Welcome home!</h2>
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
            String signature = request.getParameter("Sign");
            if (signature != null) {
                 Initiative init = new Initiative(Long.parseLong(signature));
                
                if (user.sign(init)) {
        %> Congratulations, you have made your citizen duty!<% 
                      } else {
        %>Sorry, it seems that the system could not fulfill your query.<%                           }

            }
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
                <td><form name="Sign init" action="home.jsp"><button type="submit" name ="Sign" value=<%=result.getLong(1)%> <%if(new Initiative(result.getLong(1)).hasVoted(user)){%>disabled<%}%>>Sign</button></form></td>
                <td><form name="Display init" action="displayIni.jsp"><button type="submit" name="Display" value=<%=result.getLong(1)%>>Display</button> </form></td>
    </tr>
    <% }%>
</table>

</body>
</html>
