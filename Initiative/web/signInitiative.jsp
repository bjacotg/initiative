<%-- 
    Document   : signInitiative
    Created on : Apr 3, 2013, 8:43:10 PM
    Author     : bastienjacot-guillarmod
--%>

<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Map"%>
<%@page import="server.Initiative"%>
<%@page import="server.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head></head>
    <body>
        <%
               User user = (User) session.getAttribute("user");
               if(user == null){
                   response.sendRedirect("login.jsp");
               }
               Initiative init = new Initiative(Long.parseLong(request.getParameter("Sign")));  
               if(init== null){
                   response.sendRedirect("login.jsp");
               }   
        %>Waitititititiititi<%                                                                                                                                                           
               if(user.sign(init)){
                %> Congratulations, you have made your citizen duty!<%
               }else{
                   %>f<%
               }
        %>
        
        
    </body>
</html>
