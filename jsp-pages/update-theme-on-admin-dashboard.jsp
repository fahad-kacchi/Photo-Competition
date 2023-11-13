<%@ page language="java" import="java.sql.*, java.util.*, java.time.*"%>
<%@include file="database-files/database-operations.jsp" %>
<%@include file="utils/string-operations.jsp" %>

<%
    try{
        List<String> details = getCurrentThemeDetails(out);
		if(details == null){
			out.println("There is no current theme available");
			return;
		}
        int photoCount = getPhotoCount(out);
        out.println(details.get(0) + "$" + details.get(1) + "$" + details.get(2) + "$" + details.get(3) + "$" + photoCount);
    } catch(Exception e){
        out.println(" Update theme exception: " +e);
    }
%>

<%!
    public static List<String> getCurrentThemeDetails(JspWriter out) throws Exception {
        List<String> details = new ArrayList<String>();
        try{
            con = fetchConnection();
            stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE );
            String query = "select * from theme where current_theme_flag = 1";
            rs = stmt.executeQuery(query);
            if(!rs.next()){
                details = null;
            } else {
                rs.last();
                details.add(rs.getString("name"));
                details.add(rs.getString("theme_photo"));
                details.add(rs.getString("start_date"));
                details.add(rs.getString("to_date"));
            }
        } catch(Exception e){
            out.println(" Get current theme details exception: " +e);
        } finally {
            closeConnection();
        }
        return details;
    }
%>

<%!
    public static int getPhotoCount(JspWriter out) throws Exception{
        int photoCount = 0;
        try{
            con = fetchConnection();
            stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE );
            String query = "select count(*) from photo_register";
            rs = stmt.executeQuery(query);
            if(!rs.next()){
                photoCount = 0;
            } else {
                photoCount = rs.getInt("count");
            }
        } catch(Exception e){
            out.println(" Get current theme details exception: " +e);
        } finally {
            closeConnection();
        }
        return photoCount;
    }
%>