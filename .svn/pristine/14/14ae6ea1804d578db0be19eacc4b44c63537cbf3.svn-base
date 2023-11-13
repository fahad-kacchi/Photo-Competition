<%@ page language="java" import="java.sql.*, java.io.*, java.util.*, java.time.*"%>
<%@include file="database-files/database-operations.jsp" %>
<%@include file="utils/string-operations.jsp" %>

<%
	String themeId = request.getParameter("themeId");
	try{
		List<List<String>> allDetails = getThemeDetailsById(themeId, out);
		String modalDetails = "";
		int i = 1;
		for(List<String> list : allDetails){
			String split = list.get(2).split("photo-competition")[1];
			StringBuilder sb = new StringBuilder(split);
			sb.deleteCharAt(0);
			String photo = sb.toString();
			String id = "exampleModalPopovers"+i;
			modalDetails += ""+
				"<div id="+id+" class=\"modal fade\" tabindex=\"-1\" role=\"dialog\" aria-labelledby=\"exampleModalPopoversLabel\">"+
					"<div class=\"modal-dialog\" role=\"document\">"+
						"<div class=\"modal-content\">"+
							"<div class=\"modal-header\">"+
								"<h5 class=\"modal-title\" id=\"exampleModalPopoversLabel\">"+list.get(0)+"</h5>"+
								"<button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-label=\"Close\">"+
								"<span aria-hidden=\"true\">×</span>"+
								"</button>"+
							"</div>"+
							"<div class=\"modal-body\">"+
								"<img src="+photo+" class=\"img-fluid\" alt=\"zoom\">"+
							"</div>"+
							"<div class=\"modal-footer\">"+
								"<table class=\"table table-bordered\">"+
									"<thead>"+
										"<tr>"+
											"<th scope=\"col\">Shutter</th>"+
											"<th scope=\"col\">Aperature</th>"+
											"<th scope=\"col\">ISO</th>"+
											"<th scope=\"col\">MP</th>"+
										"</tr>"+
									"</thead>"+
									"<tbody>"+
										"<tr>"+
											"<td>"+list.get(3)+"</td>"+
											"<td>"+list.get(4)+"</td>"+
											"<td>"+list.get(5)+"</td>"+
											"<td>"+list.get(6)+"</td>"+
										"</tr>"+
									"</tbody>"+
								"</table>"+
							"</div>"+
						"</div>"+
					"</div>"+
				"</div>";
				++i;
		}
		out.println(modalDetails);
	} catch(Exception e){
		out.println(" View previous theme details exception: " +e);
	}
%>

<%!
	public static List<List<String>> getThemeDetailsById(String themeId, JspWriter out) throws Exception {
		List<List<String>> allDetails = new ArrayList<List<String>>();
		try{
			List<String> names = getFullNameListById(themeId, out);
			con = fetchConnection();
			stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			String query = "select * from photo_register where theme_id = '"+themeId+"'";
			rs = stmt.executeQuery(query);
			if(!rs.next()){
				allDetails = null;
			} else {
				rs.beforeFirst();
				int i = 0;
				while(rs.next()){
					List<String> record = new ArrayList<String>();
					record.add(names.get(i));
					record.add(rs.getString("photo_description"));
					record.add(rs.getString("photo"));
					record.add(rs.getString("shutter"));
					record.add(rs.getString("aparture"));
					record.add(rs.getString("iso"));
					record.add(rs.getString("mega_pixel"));
					allDetails.add(record);
					++i;
				}
			}
		} catch(Exception e){
			out.println(" Get theme details by id exception: " +e);
		} finally {
			closeConnection();
		}
		return allDetails;
	}
%>

<%!
	public static List<String> getFullNameListById(String themeId, JspWriter out) throws Exception {
		List<String> fullNameList = new ArrayList<String>();
		try{
			con = fetchConnection();
			stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			String query = "select full_name from login, photo_register where login.login_id = photo_register.login_id and theme_id = '"+themeId+"'";
			rs = stmt.executeQuery(query);
			if(!rs.next()){
				fullNameList = null;
			} else {
				rs.beforeFirst();
				while(rs.next()){
					fullNameList.add(rs.getString("full_name"));
				}
			}
		} catch(Exception e){
			out.println(" Get full name exception: " +e);
		} finally {
			closeConnection();
		}
		return fullNameList;
	}
%>