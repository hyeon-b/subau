<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="user_id" />
<jsp:setProperty name="user" property="user_pwd" />
<jsp:setProperty name="user" property="user_nname" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인페이지</title>
</head>
<body>
<% 
	String user_id=null;
	if(session.getAttribute("user_id") != null){
		user_id = (String) session.getAttribute("user_id");
	}
	if (user_id != null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인이 되어있습니다.')");
		script.println("location.href = 'welcome'");
		script.println("</script>");
	}

	UserDAO userDAO = new UserDAO();
	int result = userDAO.login(user.getUser_id(),user.getUser_pwd());
	if(result == 1){
		session.setAttribute("user_id",user.getUser_id());
		session.setAttribute("user_pwd",user.getUser_pwd());
		session.setAttribute("user_nname",userDAO.getNickName());
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'welcome'");
		script.println("</script>");
	}
	else if(result == 0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가 틀립니다.')");
		script.println("history.back()");
		script.println("</script>");
	}
	else if(result == -1){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('아이디가 존재하지 않습니다.')");
		script.println("history.back()");
		script.println("</script>");
	}
	else if(result == -2){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('database에 오류가 발생하였습니다.')");
		script.println("history.back()");
		script.println("</script>");
	}
%>

</body>
</html>