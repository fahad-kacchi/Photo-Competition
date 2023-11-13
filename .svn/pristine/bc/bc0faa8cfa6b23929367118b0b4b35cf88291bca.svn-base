<%@ page language="java" import="java.sql.*, java.util.*, java.time.*"%>
<%@include file="database-files/database-operations.jsp" %>
<%@include file="utils/string-operations.jsp" %>

<%
    String themeName = request.getParameter("theme_name");
    String themeDescription = request.getParameter("theme_description");
    String startDate = request.getParameter("start_date");
    String endDate = request.getParameter("end_date");
    int currentThemeFlag = 1;
    
    try{
        updateOldThemeFlag(out);
        boolean flag = storeNewThemeDetails(themeName, themeDescription, startDate, endDate, currentThemeFlag, out);
        if(flag){
            out.println(" <br><br><center> <font color=green size=5> <b> Details store successfully! <br> <a href=\"../admin-dashboard.html\">Click here to go dashboard.<a/> </b> </font> </center>");
        } else{
            out.println(" <center> <font color=red size=4> <b> Details not stored! <a href=\"../admin-add-theme.html\">Click here to go back.<a/> </b> </font> </center>");
        }
    } catch(Exception e){
        out.println(" Store theme details exception: " +e);
    }
%>

<%!
    public static void updateOldThemeFlag(JspWriter out) throws Exception{
        try{
            con = fetchConnection();
            stmt = con.createStatement();
            String query = "update theme set current_theme_flag = 0";
            stmt.executeUpdate(query);
        } catch(Exception e){
            out.println(" Update old theme flag exception: " +e);
        } finally {
            closeConnection();
        }
    }
%>

<%!
    public static boolean storeNewThemeDetails(String themeName, String themeDescription, String startDate, String endDate, int currentThemeFlag, JspWriter out) throws Exception {
        boolean flag = false;
        try{
            String currentThemeId = getCurrentThemeId(out);
            if(currentThemeId != null){
                con = fetchConnection();
                stmt = con.createStatement();
                String query = "update theme set name = '"+themeName+"', theme_description = '"+themeDescription+"', start_date = '"+startDate+"', to_date = '"+endDate+"', current_theme_flag = "+currentThemeFlag+" where theme_id = '"+currentThemeId+"'";
                stmt.executeUpdate(query);
                flag = true;
            }
        } catch(Exception e){
            out.println(" Store new theme details exception: " +e);
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
            stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String query = "select * from theme";
            rs = stmt.executeQuery(query);
            if(!rs.next()){
                themeId = null;
            } else {
                rs.last();
                themeId = rs.getString("theme_id");
            }
        } catch(Exception e){
            out.println(" Get current theme id exception: " +e);
        } finally {
            closeConnection();
        }
        return themeId;
    }
%>