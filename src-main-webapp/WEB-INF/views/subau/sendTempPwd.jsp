<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mail.JavaMailUtil" %>
<%@ page import="user.UserDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
		request.setCharacterEncoding("UTF-8");
		String emailadrs = request.getParameter("emailadrs");
		
		String tempPwd = "";
		for (int j = 0; j < 8; j++)
			tempPwd += (char)((Math.random() * 26)  +65);
		for (int j = 0; j < 4; j++)
			tempPwd += (char)((Math.random() * 10) + 48);
			
		UserDAO userDAO = new UserDAO();
		int res = userDAO.changePwd(emailadrs, tempPwd);
		if(res == 0){
			emailadrs += "@sungshin.ac.kr";
			
			JavaMailUtil.sendMail(emailadrs, tempPwd);

			
			out.print("<h1> 임시 비밀번호 전송 </h1>");
			out.print("<h3>" + emailadrs + "으로 임시 비밀번호를 전송했습니다. 다시 로그인 해주십시오.</h3>");

			out.print("<br><button value=\"확인\" onClick=\"fClose()\">확인</button>");	
			
		} else{
			out.print("<h3> 비밀번호 변경 실패 </h3>");
		}
		
	
	%>

</body>
<script>
	function fClose(){
	    window.close();
	}

</script>
</html>