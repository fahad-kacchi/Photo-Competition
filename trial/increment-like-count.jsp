<%@ page language="java" import="java.sql.*, java.io.*, java.util.*, java.time.*"%>
<%@include file="database-files/database-operations.jsp" %>
<%@include file="utils/string-operations.jsp" %>

<%
    String value = request.getParameter("value");
    try{
        String loginId = getLoginIdByValue(value, out);
        incrementLikeCount(loginId, out);
    } catch(Exception e){
        out.println(" Increment like count exception: " +e);
    }
%>

<%!
    public static String getLoginIdByValue(String value, JspWriter out) throws Exception{
        String loginId = "";
        try{
            con = fetchConnection();
            stmt = con.createStatement();
            String query = "select login_id from photo_register where photo = '"+value+"'";
            rs = stmt.executeQuery(query);
            if(!rs.next()){
                loginId = null;
            } else {
                loginId = rs.getString("login_id");
            }
        } catch(Exception e){
            out.println(" Get login id by value exception: " +e);
        } finally{
            closeConnection();
        }
        return loginId;
    }
%>

<%!
    public static void incrementLikeCount(String loginId, JspWriter out) throws Exception {
        try{
            int latestLikeCount = getLatestCount(loginId, out);
            latestLikeCount++;
            con = fetchConnection();
            stmt = con.createStatement();
            String query = "";
            query = "update photo_register set like_count = "+latestLikeCount+" where login_id = '"+loginId+"'";
            stmt.executeUpdate(query);
        } catch(Exception e){
            out.println(" Increment like count: " +e);
        } finally {
            closeConnection();
        }
    }
%>

<%!
    public static int getLatestCount(String loginId, JspWriter out) throws Exception {
        int latestLikeCount = 0;
        try{
            con = fetchConnection();
            stmt = con.createStatement();
            String query = "select like_count from photo_register where login_id = '"+loginId+"'";
            rs = stmt.executeQuery(query);
            if(!rs.next()){
                latestLikeCount = 0;
            } else {
                latestLikeCount = rs.getInt("like_count");
            }
        } catch(Exception e){
            out.println(" Get latest like count exception: " +e);
        } finally {
            closeConnection();
        }
        return latestLikeCount;
    }
%>