<%@ page language="java" import="java.sql.*, java.io.*, java.util.*, java.time.*"%>
<%@include file="database-files/database-operations.jsp" %>
<%@include file="utils/string-operations.jsp" %>

<%
    try{
        List<List<String>> details = getPreviousThemeDetails(out);
        if(details == null){
            out.println(" No records found!");
            return;
        }
        String printPreviousThemeDetails = "";
        for(List<String> list : details){
            StringBuilder sb = new StringBuilder(list.get(2).split("photo-competition")[1]);
            String photoPath = sb.deleteCharAt(0).toString();
            String url = "view-theme.html?theme_id="+list.get(5);
            printPreviousThemeDetails += ""+
                "<div class=\"col-md-4 bottom\">"+
                    "<div class=\"card hoverable\">"+
                        "<img class=\"card-img-top hoverable\" src="+photoPath+" alt=\"photo\">"+
                        "<div class=\"card-body\">"+
                            "<h4 class=\"card-title\"><a>"+list.get(0)+"</a></h4>"+
                            "<p class=\"card-text\">"+
                                list.get(1)+
                            "</p>"+
                            "<a href="+url+" style=\"background: linear-gradient(to left, #6600ff 0%, #ff99cc 100%);\" class=\"btn custom btn-block btn-primary\">View Theme</a>"+
                        "</div>"+
                    "</div>"+
                "</div>";
        }
        out.println(printPreviousThemeDetails);
    } catch(Exception e){
        out.println(" Show previous themes exception: " +e);
    }
%>

<%!
    public static List<List<String>> getPreviousThemeDetails(JspWriter out) throws Exception {
        List<List<String>> details = new ArrayList<List<String>>();
        try{
            con = fetchConnection();
            stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String query = "select * from theme where current_theme_flag = 0";
            rs = stmt.executeQuery(query);
            if(!rs.next()){
                details = null;
            } else {
                rs.previous();
                while(rs.next()){
                    List<String> record = new ArrayList<String>();
                    record.add(rs.getString("name"));
                    record.add(rs.getString("theme_description"));
                    record.add(rs.getString("theme_photo"));
                    record.add(rs.getString("start_date"));
                    record.add(rs.getString("to_date"));
                    record.add(rs.getString("theme_id"));
                    details.add(record);
                }
            }
        } catch(Exception e){
            out.println(" Get previous theme details: " +e);
        } finally {
            closeConnection();
        }
        return details;
    }
%>
