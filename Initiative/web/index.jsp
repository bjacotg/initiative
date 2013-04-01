<%-- 
    Document   : index
    Created on : Mar 28, 2013, 6:40:37 PM
    Author     : bastienjacot-guillarmod
--%>

<%
    if(session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
    } else {
        response.sendRedirect("home.jsp");
    }
%>