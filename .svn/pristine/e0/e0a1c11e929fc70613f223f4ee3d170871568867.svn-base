<%@ page language="java" import="java.sql.*, java.io.*, java.util.*, java.time.*"%>
<%@include file="database-files/database-operations.jsp" %>
<%@include file="utils/string-operations.jsp" %>

<%
    String loginId = request.getParameter("loginId");
    try{
        boolean flag = isPhotographSubmitted(loginId, out);
        if(flag){
            out.println("1");
        } else {
            out.println("0");
        }
    } catch(Exception e){
        out.println(" Photograph submitted exception: " +e);
    }
%>

<%!
    public static boolean isPhotographSubmitted(String loginId, JspWriter out) throws Exception{
        boolean flag = false;
        try{
            con = fetchConnection();
            stmt = con.createStatement();
            String query = "select photo from photo_register where login_id = '"+loginId+"'";
            rs = stmt.executeQuery(query);
            if(!rs.next()){
                flag = false;
            } else {
                flag = true;
            }
        } catch(Exception e){
            out.println(" Is photograph submitted exception: " +e);
        } finally {
            closeConnection();
        }
        return flag;
    }
%>