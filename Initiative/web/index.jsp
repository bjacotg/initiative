<%-- 
    Document   : index
    Created on : Mar 28, 2013, 6:40:37 PM
    Author     : bastienjacot-guillarmod
--%>

<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.logging.Level"%>
<%@page import="java.sql.SQLException"%>
<%@page import="server.User"%>
<%@page import="server.Initiative"%>
<%

        Initiative.newInitiative("SVP", "Let people get more money!");
        Initiative.newInitiative("Green", "An investigation to know who let the dogs out.");
        Initiative.newInitiative("SVP", "No initiative anymore!");
        Initiative.newInitiative("Green", "Dissolution of the SVP, an anti-democratic party.");
        User.newUser("jack", "jack");
        User.newUser("chris", "chris");
        User.newUser("orlando", "bloom");
        User jack = User.login("jack", "jack");
        User chris = User.login("chris", "chris");
        User orl = User.login("orlando", "bloom");
        try {
            jack.sign(new Initiative(1));
            chris.sign(new Initiative(1));
            orl.sign(new Initiative(2));
            jack.sign(new Initiative(3));
            chris.sign(new Initiative(4));
            orl.sign(new Initiative(4));
        } catch (SQLException ex) {
            Logger.getLogger(Initiative.class.getName()).log(Level.SEVERE, null, ex);
        }
    
    if(session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
    } else {
        response.sendRedirect("home.jsp");
    }
%>