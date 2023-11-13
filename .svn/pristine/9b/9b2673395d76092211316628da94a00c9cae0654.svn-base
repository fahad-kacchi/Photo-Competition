<%@ page language="java" import="java.sql.*, java.util.*, java.time.*"%>
<%@include file="database-files/common-database.jsp" %>

<%
    String email = request.getParameter("passengerEmailId");
    String password = request.getParameter("passengerPassword");
    
    try{
        boolean isValid = checkLoginValidity(email, password, out);
        if(isValid){
            String loginId = getCurrentUserLoginId(email, password, out);
            changeLoginStatus(loginId, out);
            response.sendRedirect("../welcome-page.html?loginId="+loginId);
        } else {
            String ERROR_MSG = "<center>"+
                                    "<font size=5 color=red>"+
                                        "<br><br>Invalid credentials!<br><br>"+
                                        "<a href=\"../login-page.html\"> Click here to go back... </a>"+
                                    "</font>"+
                               "</center>";
            out.println(ERROR_MSG);
        }
    } catch(Exception e){
        out.println(" Competitor login exception: " +e);
    }
%>

<%!
    public static boolean checkLoginValidity(String email, String password, JspWriter out) throws Exception{
        boolean isValid = false;
        try{
            con = fetchConnection();
            stmt = con.createStatement();
            String query = "select * from login where email = '"+email+"' and password = '"+password+"'";
            rs = stmt.executeQuery(query);
            if(!rs.next()){
                isValid = false;
            } else {
                isValid = true;
            }
        } catch(Exception e){
            out.println(" Competitor login validity exception: " +e);
        } finally {
            closeConnection();
        }
        return isValid;
    }
%>

<%!
    public static String getCurrentUserLoginId(String email, String password, JspWriter out) throws Exception {
        String loginId = "";
        try{
            con = fetchConnection();
            stmt = con.createStatement();
            String query = "select login_id from login where email = '"+email+"' and password = '"+password+"'";
            rs = stmt.executeQuery(query);
            rs.next();
            loginId = rs.getString("login_id");
        } catch(Exception e){
            out.println(" Get current user login id exception: " +e);
        } finally {
            closeConnection();
        }
        return loginId;
    }
%>


<%!
    public static void changeLoginStatus(String loginId, JspWriter out) throws Exception {
        try{
            con = fetchConnection();
            stmt = con.createStatement();
            String query = "update login set login_flag = 1 where login_id = '"+loginId+"'";
            stmt.executeUpdate(query);
        } catch(Exception e){
            out.println(" Change login status exception: " +e);
        } finally {
            closeConnection();
        }
    }
%>