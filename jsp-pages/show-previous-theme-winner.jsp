<%@ page language="java" import="java.sql.*, java.io.*, java.util.*, java.time.*"%>
<%@include file="database-files/database-operations.jsp" %>
<%@include file="utils/string-operations.jsp" %>

<%
	String themeId = request.getParameter("themeId");
	try{
		List<String> winnerDetails = getPreviousThemeWinnerDetails(themeId, out);
		String split = winnerDetails.get(2).split("photo-competition")[1];
		StringBuilder sb = new StringBuilder(split);
		sb.deleteCharAt(0);
		String photo = sb.toString();

		String details = ""+
				"<div class=\"row\">"+
					"<div class=\"col-md-8 mask flex-center waves-effect waves-light\">"+
						"<img class=\"animated pulse card-img-top hoverable\" src="+photo+" alt=\"photo\">"+
					"</div>"+
					"<div class=\"col-md-4\">"+
						"<div class=\"card-body\">"+
							"<table class=\"table table-bordered\">"+
								"<thead align=\"left\">"+
									"<tr>"+
										"<th scope=\"col\"><b><font size=4>Winner Name</font></b></th>"+
									"</tr>"+
									"<tr>"+
										"<th scope=\"col\">"+winnerDetails.get(0)+"</th>"+
									"</tr>"+
									"<tr>"+
										"<th scope=\"col\"><b><font size=4>Theme Details</font></b></th>"+
									"</tr>"+
									"<tr>"+
										"<th scope=\"col\">"+winnerDetails.get(1)+"</th>"+
									"</tr>"+
									"<tr>"+
										"<th scope=\"col\"><b><font size=4>Winner Prize: $500</font></b></th>"+
									"</tr>"+
								"</thead>"+
							"</table>"+
						"</div>"+
					"</div>"+
				"</div>";
		out.println(details);
	} catch(Exception e){
		out.println(" Show previous theme winner exception: " +e);
	}
%>

<%!
	public static List<String> getPreviousThemeWinnerDetails(String themeId, JspWriter out) throws Exception{
		List<String> winnerDetails = new ArrayList<String>();
		try{
			con = fetchConnection();
			stmt = con.createStatement();
			String query = "select full_name, theme_description,photo from login, photo_register, winner, theme where login.login_id = photo_register.login_id and theme.theme_id = photo_register.theme_id and winner.theme_id = theme.theme_id and winner.login_id = login.login_id and current_theme_flag != 1";
			rs = stmt.executeQuery(query);
			if(!rs.next()){
				winnerDetails = null;
			} else {
				winnerDetails.add(rs.getString("full_name"));
				winnerDetails.add(rs.getString("theme_description"));
				winnerDetails.add(rs.getString("photo"));
			}
		} catch(Exception e){
			out.println(" Get previous theme winner details exception: " +e);
		} finally {
			closeConnection();
		}
		return winnerDetails;
	}
%>