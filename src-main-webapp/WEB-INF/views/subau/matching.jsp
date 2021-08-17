<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String userId = (String)session.getAttribute("user_id");
		String userNname = (String)session.getAttribute("user_nname");
		
		PrintWriter script = response.getWriter();

		UserDAO userDAO = new UserDAO();
		int result = userDAO.matching(userId);
		if (result == -1){ //매칭 대기 필요
			script.println("<script>");
			script.println("alert('매칭할 사람이 없어서 대기합니다');");
			script.println("history.back();");
			script.println("</script>");
		} else { //매칭 완료
			script.println("<script>");
			script.println("alert('매칭이 완료됐습니다. 메일로 먼저 인사해 보세요!');");
			script.println("location.href='write'");
			script.println("</script>");
		}
	%>
</body>
</html>