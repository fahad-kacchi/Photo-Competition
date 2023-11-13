<%@ page language="java" import="java.sql.*, java.io.*, java.util.*, java.time.*"%>
<%@include file="database-files/database-operations.jsp" %>
<%@include file="utils/string-operations.jsp" %>

<%
	String loginId = request.getParameter("loginId");
	try{
		boolean flag = isAlreadyCurrentThemeHasWinner(loginId, out);
		String message = "";
		if(flag){
			message = " <center> <font color=red size=6> Current theme has already selected a winner. You cannot select another winner!"+
					  "<br><a href=\"../admin-dashboard.html\">Click here to go dashboard!</a> </font> </center>";
		} else {
			String winnerId = generatePrimaryKey("W", "winner", "winner_id", out);
			String themeId = getCurrentThemeId(out);
			selectAsWinner(loginId, winnerId, themeId, out);
			message = "<center> <font size=6 color=green> Winner successfully selected!"+
					  "<br><a href=\"../admin-dashboard.html\">Click here to go dashboard!</a> </font> </center>";
		}
		out.println(message);
	} catch(Exception e){
		out.println(" Select as winner exception: " +e);
	}
%>

<%!
	public static void selectAsWinner(String loginId, String winnerId, String themeId, JspWriter out) throws Exception{
		try{
			con = fetchConnection();
			stmt = con.createStatement();
			String query = "insert into winner values('"+winnerId+"', '"+loginId+"', '"+themeId+"')";
			stmt.executeUpdate(query);
		} catch(Exception e){
			out.println(" Select as winner exception: " +e);
		} finally {
			closeConnection();
		}
	}
%>

<%!
	public static boolean isAlreadyCurrentThemeHasWinner(String loginId, JspWriter out) throws Exception{
		boolean flag = false;
		try{
			con = fetchConnection();
			stmt = con.createStatement();
			String query = "select winner_id from winner, photo_register where winner.theme_id = photo_register.theme_id and winner.theme_id = (select theme_id from theme where current_theme_flag = 1)";
			rs = stmt.executeQuery(query);
			if(!rs.next()){
				flag = false;
			} else {
				flag = true;
			}
		} catch(Exception e){
			out.println(" Is already winner exception: " +e);
		} finally {
			closeConnection();
		}
		return flag;
	}
%>

<%!
	public static String getCurrentThemeId(JspWriter out) throws Exception {
		String themeId = "";
		try{
			con = fetchConnection();
			stmt = con.createStatement();
			String query = "select theme_id from theme where current_theme_flag = 1";
			rs = stmt.executeQuery(query);
			if(!rs.next()){
				themeId = null;
			} else {
				themeId = rs.getString("theme_id");
			}
		} catch(Exception e){
			out.println(" Get current theme id exception: " + e);
		} finally {
			closeConnection();
		}
		return themeId;
	}
%>