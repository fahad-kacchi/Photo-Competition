<%@ page language="java" import="java.sql.*, java.io.*, java.util.*, java.time.*"%>
<%@include file="database-files/database-operations.jsp" %>
<%@include file="utils/string-operations.jsp" %>

<%
	String loginId = request.getParameter("loginId");
	try{
		List<String> competitorDetails = getCompetitorDetailsById(loginId, out);
		if(competitorDetails == null){
			out.println(" Records not found.");
		} else {
			String split = competitorDetails.get(3).split("photo-competition")[1];
			StringBuilder sb = new StringBuilder(split);
			sb.deleteCharAt(0);
			String photo = sb.toString();
			String winnerLink = "jsp-pages/select-as-winner.jsp?loginId="+loginId;
			String record = ""+
				"<img class=\"card-img-top hoverable\" src="+photo+" alt=\"photo\">"+
				"<div class=\"card-body\">"+
					"<h4 class=\"card-title\"><a>"+competitorDetails.get(0)+"</a></h4>"+
					"<p class=\"card-text\">"+
						"<table class=\"table table-bordered\">"+
							"<thead align=\"center\">"+
								"<tr>"+
									"<th scope=\"col\">Shutter</th>"+
									"<th scope=\"col\">Aperature</th>"+
									"<th scope=\"col\">ISO</th>"+
									"<th scope=\"col\">MP</th>"+
								"</tr>"+
							"</thead>"+
							"<tbody align=\"center\">"+
								"<tr>"+
									"<td>"+competitorDetails.get(4)+"</td>"+
									"<td>"+competitorDetails.get(5)+"</td>"+
									"<td>"+competitorDetails.get(6)+"</td>"+
									"<td>"+competitorDetails.get(7)+"</td>"+
								"</tr>"+
							"</tbody>"+
						"</table>"+
					"</p>"+
					"<div class=\"row\">"+
						"<div class=\"col-md-6\">"+
							"<a href=\"admin-check-competition-response.html\" class=\"btn custom btn-block btn-primary buttonGradient\" >Click here to go back</a>"+
						"</div>"+
						"<div class=\"col-md-6\">"+
							"<a href="+winnerLink+" class=\"btn custom btn-block btn-primary buttonGradient\" >Select As Winner</a>"+
						"</div>"+
					"</div>"+
				"</div>";
			out.println(record);
		}
	} catch(Exception e){
		out.println(" Show competitor details exception: " +e);
	}
%>

<%!
	public static List<String> getCompetitorDetailsById(String loginId, JspWriter out) throws Exception{
		List<String> competitorDetails = new ArrayList<String>();
		
		try{
			String competitorName = getCompetitorNameById(loginId, out);
			if(competitorName == null){
				return null;
			}
			con = fetchConnection();
			stmt = con.createStatement();
			String query = "select * from photo_register where login_id = '"+loginId+"'";
			rs = stmt.executeQuery(query);
			if(!rs.next()){
				competitorDetails = null;
			} else {
				competitorDetails.add(competitorName);
				competitorDetails.add(rs.getString("photo_id"));
				competitorDetails.add(rs.getString("photo_description"));
				competitorDetails.add(rs.getString("photo"));
				competitorDetails.add(rs.getString("shutter"));
				competitorDetails.add(rs.getString("aparture")); 
				competitorDetails.add(rs.getString("iso"));
				competitorDetails.add(rs.getString("mega_pixel"));
			}
		} catch(Exception e){
			out.println(" Get competitor details exception: " +e);
		} finally {
			closeConnection();
		}
		return competitorDetails;
	}
%>
<%!
	public static String getCompetitorNameById(String loginId, JspWriter out) throws Exception{
		String competitorName = "";
		try{
			con = fetchConnection();
			stmt = con.createStatement();
			String query = "select * from login where login_id = '"+loginId+"'";
			rs = stmt.executeQuery(query);
			if(!rs.next()){
				competitorName = null;
			} else {
				competitorName = rs.getString("full_name");
			}
		} catch(Exception e){
			out.println(" Get competitor name exception: " +e);
		} finally {
			closeConnection();
		}
		return competitorName;
	}
%>
