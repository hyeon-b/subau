<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String userId = (String)session.getAttribute("user_id");
	System.out.println(userId);
	String userNname = (String)session.getAttribute("user_nname");
	UserDAO userDAO = new UserDAO();
	int res=userDAO.deleteUser(userId);
	
	if(res == 0)
		out.print("success");
	else 
		out.print("database error");
%>
</body>
</html>