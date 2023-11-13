<%@ page language="java" import="java.sql.*, java.util.*, java.time.*"%>
<%@include file="database-files/database-operations.jsp" %>
<%@include file="utils/string-operations.jsp" %>

<%
	String fullName = request.getParameter("name");
	String email = request.getParameter("email");
	String password = request.getParameter("password");
    String phoneNo = request.getParameter("phoneNo");
    int loginFlag = 0;
    
	if(isNull(fullName) || isNull(email) || isNull(password) || isNull(phoneNo)){
		out.println(" Please fill all the details.");
		return;
	}
	
	try{
		List<KeyValue> data = new ArrayList<KeyValue>();
        String loginId = generatePrimaryKey("L", "login", "login_id", out);
        data.add(new KeyValue(DTConstants.STRING, fullName));
        data.add(new KeyValue(DTConstants.STRING, email));
        data.add(new KeyValue(DTConstants.STRING, password));
        data.add(new KeyValue(DTConstants.STRING, phoneNo));
        data.add(new KeyValue(DTConstants.INTEGER, loginFlag));
        boolean flag = insertData(data, loginId, "login", out);
        if(flag){
            out.println(" Data successfully inserted.!");
            response.sendRedirect("../login-page.html");
        } else {
            out.println(" Error 404.!");
        }
	} catch(Exception e){
		out.println("Competitor login verification exception: " +e);
	}
%>