<%@ page language="java" import="java.sql.*, java.util.*, java.time.*"%>
<%@include file="database-files/database-operations.jsp" %>
<%@include file="utils/string-operations.jsp" %>

<%
    String photoDescription = request.getParameter("photoDescription");
    String shutter = request.getParameter("selectedShutter");
    String aparture = request.getParameter("aparture");
    String iso = request.getParameter("iso");
    String megaPixel = request.getParameter("mega_pixel");
    int likeCount = 0;
    int likeStatusOfCurrentUser = 0;
    String loginId = request.getParameter("loginId");
    
    String welcomePageLink = "../welcome-page.html?loginId="+loginId;
    try{
        boolean flag = storeNewPhotoRegisterDetails(photoDescription, shutter, aparture, iso, megaPixel, likeCount, likeStatusOfCurrentUser, out);
        if(flag){
            out.println(" <br><br><center> <font color=green size=5> <b> Details store successfully! <br> <a href="+welcomePageLink+">Click here to go dashboard.<a/> </b> </font> </center>");
        } else{
            out.println(" <center> <font color=red size=4> <b> Details not stored! <a href="+welcomePageLink+">Click here to go back.<a/> </b> </font> </center>");
        }
    } catch(Exception e){
        out.println(" Store theme details exception: " +e);
    }
%>

<%!
    public static boolean storeNewPhotoRegisterDetails(String photoDescription, String shutter, String aparture, String iso, String megaPixel, int likeCount, int likeStatusOfCurrentUser, JspWriter out) throws Exception {
        boolean flag = false;
        try{
            String currentPhotoId = getCurrentPhotoId(out);
            String currentThemeId = getCurrentThemeId(out);
            if(currentPhotoId != null && currentThemeId != null){
                con = fetchConnection();
                stmt = con.createStatement();
                String query = "update photo_register set  photo_description = '"+photoDescription+"', shutter = '"+shutter+"', aparture = '"+aparture+"', iso = '"+iso+"', mega_pixel = "+megaPixel+", like_count = "+likeCount+", theme_id = '"+currentThemeId+"', like_status_of_current_user="+likeStatusOfCurrentUser+" where photo_id = '"+currentPhotoId+"'";
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
        String currentThemeId = "";
        try{
            con = fetchConnection();
            stmt = con.createStatement();
            String query = "select theme_id from theme where current_theme_flag = 1";
            rs = stmt.executeQuery(query);
            if(!rs.next()){
                currentThemeId = null;
            } else {
                currentThemeId = rs.getString("theme_id");
            }
        } catch(Exception e){
            out.println(" Get current theme id exception: " +e);
        } finally {
            closeConnection();
        }
        return currentThemeId;
    }
%>

<%!
    public static String getCurrentPhotoId(JspWriter out) throws Exception {
        String photoId = "";
        try{
            con = fetchConnection();
            stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String query = "select * from photo_register";
            rs = stmt.executeQuery(query);
            if(!rs.next()){
                photoId = null;
            } else {
                rs.last();
                photoId = rs.getString("photo_id");
            }
        } catch(Exception e){
            out.println(" Get current photo id exception: " +e);
        } finally {
            closeConnection();
        }
        return photoId;
    }
%>