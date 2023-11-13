<%@ page language="java" import="java.sql.*, java.io.*, java.util.*, java.time.*"%>
<%@include file="database-files/database-operations.jsp" %>
<%@include file="utils/string-operations.jsp" %>

<%
	String themeId = request.getParameter("themeId");
	try{
		List<String> record = getPhotosByThemeId(themeId, out);
		String photoList = "";
		int i = 1;
		for(String list : record){
			String split = list.split("photo-competition")[1];
			StringBuilder sb = new StringBuilder(split);
			sb.deleteCharAt(0);
			String photo = sb.toString();
			String id = "#exampleModalPopovers"+i;
			photoList += ""+
				"<div class=\"col-md-4 view overlay zoom bottom\">"+
					"<img src="+photo+" class=\"img-fluid\" data-toggle=\"modal\" data-target="+id+" alt=\"zoom\">"+
				"</div>";
			++i;
		}
		out.println(photoList);
	} catch(Exception e){
		out.println(" View previous theme details exception: " +e);
	}
%>

<%!
	public static List<String> getPhotosByThemeId(String themeId, JspWriter out) throws Exception {
		List<String> record = new ArrayList<String>();
		try{
			con = fetchConnection();
			stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			String query = "select photo from photo_register where theme_id = '"+themeId+"'";
			rs = stmt.executeQuery(query);
			if(!rs.next()){
				record = null;
			} else {
				rs.beforeFirst();
				while(rs.next()){
					record.add(rs.getString("photo"));
				}
			}
		} catch(Exception e){
			out.println(" Get photos by theme id exception: " +e);
		} finally {
			closeConnection();
		}
		return record;
	}
%>