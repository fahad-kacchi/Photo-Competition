<%@ page language="java" import="java.sql.*, java.io.*, java.util.*, java.time.*"%>
<%@include file="database-files/database-operations.jsp" %>
<%@include file="utils/string-operations.jsp" %>

<%
    try{
        List<List<String>> details = getCompetitionResponse(out);
        if(details == null){
            out.println(" No records found!");
            return;
        }
        String printCompetitionResponse = "";
        for(List<String> list : details){
            StringBuilder sb = new StringBuilder(list.get(1).split("photo-competition")[1]);
            String photoPath = sb.deleteCharAt(0).toString();
			String loginId = list.get(2);
			String url = "show-competitor-details.html?loginId="+loginId;
			
            printCompetitionResponse += ""+
                "<div class=\"col-md-4 bottom\">"+
                    "<div class=\"card hoverable\">"+
                        "<a href="+url+">"+
                            "<img class=\"card-img-top hoverable\" src="+photoPath+" alt=\"photo\">"+
                        "</a>"+
                        "<div class=\"card-body\">"+
                            "<center><p><b>"+list.get(0)+"</b></p></center>"+
                        "</div>"+
                    "</div>"+
                "</div>";
        }
        out.println(printCompetitionResponse);
    } catch(Exception e){
        out.println(" Competition response exception: " +e);
    }
%>

<%!
    public static List<List<String>> getCompetitionResponse(JspWriter out) throws Exception {
        List<List<String>> details = new ArrayList<List<String>>();
        try{
            con = fetchConnection();
            stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String query = "select full_name, photo, login.login_id from photo_register, login where photo_register.login_id = login.login_id and theme_id = (select theme_id from theme where current_theme_flag = 1)";
            rs = stmt.executeQuery(query);
            if(!rs.next()){
                details = null;
            } else {
                rs.beforeFirst();
                while(rs.next()){
                    List<String> record = new ArrayList<String>();
                    record.add(rs.getString("full_name"));
                    record.add(rs.getString("photo"));
                    record.add(rs.getString("login_id"));
                    details.add(record);
                }
            }
        } catch(Exception e){
            out.println(" Get competition response exception: " +e);
            e.printStackTrace();
        } finally {
            closeConnection();
        }
        return details;
    }
%>