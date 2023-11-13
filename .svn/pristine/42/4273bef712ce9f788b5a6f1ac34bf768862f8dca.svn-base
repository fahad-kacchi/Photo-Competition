<%@ page language="java" import="java.sql.*, java.io.*, java.util.*, java.time.*"%>
<%@include file="database-files/database-operations.jsp" %>
<%@include file="utils/string-operations.jsp" %>

<%
    try{
        List<String> details = getCurrentThemeDetails(out);
        if(details == null){
            out.println(" No records found!");
            return;
        }
        String printCurrenThemeDetails = "";
        StringBuilder sb = new StringBuilder(details.get(2).split("photo-competition")[1]);
        String photoPath = sb.deleteCharAt(0).toString();
        
        
        printCurrenThemeDetails += ""+
            "<div class=\"row\">"+
                "<div class=\"col-md-8\">"+
                    "<img class=\"card-img-top hoverable\" src="+photoPath+" alt=\"photo\">"+
                "</div>"+
                "<div class=\"col-md-4\">"+
                    "<div class=\"card-body\">"+
                        "<h4 class=\"card-title\">Current theme details: </h4>"+
                        "<table class=\"table table-bordered\">"+
                            "<tr>"+
                                "<th><b> Theme name: </b></th>"+
                                "<th>"+details.get(0)+"</th>"+
                            "</tr>"+
                            "<tr>"+
                                "<th colspan=2><b>Theme desciption: </b> </th>"+
                            "</tr>"+
                            "<tr>"+
                                "<th colspan=2>"+details.get(1)+"</th>"+
                            "</tr>"+
                        "</table>"+
                        /*"<a href="+url+" style=\"background: linear-gradient(to left, #6600ff 0%, #ff99cc 100%);\" class=\"btn custom btn-block btn-primary\">View Theme</a>"+*/
                    "</div>"+
                "</div>"+
            "</div>";
        
        out.println(printCurrenThemeDetails);
    } catch(Exception e){
        out.println(" Show previous themes exception: " +e);
    }
%>

<%!
    public static List<String> getCurrentThemeDetails(JspWriter out) throws Exception {
        List<String> record = new ArrayList<String>();
        try{
            con = fetchConnection();
            stmt = con.createStatement();
            String query = "select * from theme where current_theme_flag = 1";
            rs = stmt.executeQuery(query);
            if(!rs.next()){
                record = null;
            } else {
                record.add(rs.getString("name"));
                record.add(rs.getString("theme_description"));
                record.add(rs.getString("theme_photo"));
                record.add(rs.getString("start_date"));
                record.add(rs.getString("to_date"));
                record.add(rs.getString("theme_id"));
            }
        } catch(Exception e){
            out.println(" Get current theme details exception: " +e);
        } finally {
            closeConnection();
        }
        return record;
    }
%>