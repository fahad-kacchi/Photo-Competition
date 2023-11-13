<%@ page language="java" import="java.sql.*, java.io.*, java.util.*, java.time.*"%>
<%@include file="database-files/database-operations.jsp" %>
<%@include file="utils/string-operations.jsp" %>

<%
    try{
        displayWinnerRecords(out);
    } catch(Exception e){
        out.println(" Winner records result exception: " +e);
    }
%>

<%!
    public static void displayWinnerRecords(JspWriter out)throws Exception{
        try{
            List<List<String>> winnerRecord = new ArrayList<List<String>>();
            con = fetchConnection();
            stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String query = "select * from winner";
            rs = stmt.executeQuery(query);
            if(!rs.next()){
                out.println(" Records not found");
            } else {
                rs.previous();
                while(rs.next()){
                    List<String> winner = new ArrayList<String>();
                    winner.add(rs.getString("winner_id"));
                    winner.add(rs.getString("login_id"));
                    winner.add(rs.getString("theme_id"));
                    winnerRecord.add(winner);
                }
                for(List<String> winRecord : winnerRecord){
                    List<String> photoRecord = fetchPhotoRegisterRecord(winRecord.get(1), winRecord.get(2), out);
                    List<String> loginRecord = fetchLoginRecord(winRecord.get(1), out);
                    List<String> themeRecord = fetchThemeRecord(winRecord.get(2), out);
                    
                    if(photoRecord == null){
                        continue;
                    }
                    String shutter = photoRecord.get(0);
                    String aparture = photoRecord.get(1);
                    String iso = photoRecord.get(2);
                    String megaPixel = photoRecord.get(3);
                    String photoDesc = photoRecord.get(4);
                    String photoLocation = "show-result-image.html?photoPath="+photoRecord.get(5);
                    String printRecord = ""+
                        "<div class=\"col-md-6 bottom\">"+
                            "<div class=\"card hoverable\">"+
                                "<div class=\"card-body\">"+
                                    "<h4 class=\"card-title\">Name: "+loginRecord.get(0)+"</h4>"+
                                    "<h5 class=\"card-title\">Photo Description: "+photoDesc+"</h5>"+
                                    "<p class=\"card-text\">"+
                                        "ISO: "+iso+"<br>"+
                                        "Aparture: "+aparture+"<br>"+
                                        "Mega Pixel: "+megaPixel+"<br>"+
                                        "Shutter: "+shutter+"<br>"+
                                    "</p>"+
                                    
                                    "<p class=\"card-text\">"+
                                        "Theme Name: "+themeRecord.get(0)+"<br>"+
                                        "Theme Description: "+themeRecord.get(1)+"<br>"+
                                    "</p>"+
                                    
                                    "<a href="+photoLocation+" target=\"_blank\" class=\"btn custom\" style=\"background:linear-gradient(to top left, #3333ff 0%, #00ffff 100%);\">Click here to see photo.</a>"+
                                "</div>"+
                            "</div>"+
                        "</div>";
                    out.println(printRecord);
                }
            }
        } catch(Exception e){
            out.println(" Display winner records exception: " +e);
        } finally {
            
        }        
    }
%>

<%!
    public static List<String> fetchPhotoRegisterRecord(String loginId, String themeId, JspWriter out) throws Exception{
        List<String> photoRecord = new ArrayList<String>();
        try{
           con = fetchConnection();
           stmt = con.createStatement();
           String query = "select * from photo_register where theme_id = '"+themeId+"' and login_id = '"+loginId+"'";
           rs = stmt.executeQuery(query);
           if(!rs.next()){
               photoRecord = null;
           } else {
               photoRecord.add(rs.getString("shutter"));
               photoRecord.add(rs.getString("aparture"));
               photoRecord.add(rs.getString("iso"));
               photoRecord.add(rs.getString("mega_pixel"));
               photoRecord.add(rs.getString("photo_description"));
               photoRecord.add(rs.getString("photo"));
               photoRecord.add(rs.getString("photo_id"));
           }
        } catch(Exception e){
            out.println(" Fetch photo register record exception: " +e);
        } finally {
            closeConnection();
        }
        return photoRecord;
    }
%>

<%!
    public static List<String> fetchLoginRecord(String loginId, JspWriter out) throws Exception{
        List<String> loginRecord = new ArrayList<String>();
        try{
           con = fetchConnection();
           stmt = con.createStatement();
           String query = "select * from login where login_id = '"+loginId+"'";
           rs = stmt.executeQuery(query);
           if(!rs.next()){
               loginRecord = null;
           } else {
               loginRecord.add(rs.getString("full_name"));
               loginRecord.add(rs.getString("email"));
               loginRecord.add(rs.getString("phone_no"));
           }
        } catch(Exception e){
            out.println(" Fetch login record exception: " +e);
        } finally {
            closeConnection();
        }
        return loginRecord;
    }
%>


<%!
    public static List<String> fetchThemeRecord(String themeId, JspWriter out) throws Exception{
        List<String> themeRecord = new ArrayList<String>();
        try{
           con = fetchConnection();
           stmt = con.createStatement();
           String query = "select * from theme where theme_id = '"+themeId+"'";
           rs = stmt.executeQuery(query);
           if(!rs.next()){
               themeRecord = null;
           } else {
               themeRecord.add(rs.getString("name"));
               themeRecord.add(rs.getString("theme_description"));
               themeRecord.add(rs.getString("start_date"));
               themeRecord.add(rs.getString("to_date"));
           }
        } catch(Exception e){
            out.println(" Fetch theme record exception: " +e);
        } finally {
            closeConnection();
        }
        return themeRecord;
    }
%>