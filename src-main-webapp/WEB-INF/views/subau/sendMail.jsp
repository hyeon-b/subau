<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="mail.JavaMailUtil"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<body>
	<%//1. 한글처리 & 받아온 파라미터 변수화
	request.setCharacterEncoding("UTF-8");
	String emailadrs = request.getParameter("emailadrs");
	
	//2. UserDAO객체 생성 -> 전달받은 정보 모두 저장
	UserDAO userDAO = new UserDAO();
	
	//3. idCheck(이메일)메서드
	int result = userDAO.idCheck(emailadrs);
	out.print("<h1> 이메일 등록 </h1>");
	if (result > 0){
		out.print(emailadrs + "은/는 이미 등록된 아이디 입니다.");
		out.print("<button value=\"확인\" onClick=\"fClose()\">확인</button>");
	}
	else if (result == 0){
		/*코드 생성*/
		String code = "";
		for (int j = 0; j < 8; j++)
			code += (char)((Math.random() * 26)  +65);
		for (int j = 0; j < 4; j++)
			code += (char)((Math.random() * 10 ) + 48);
		
		emailadrs += "@sungshin.ac.kr";
		JavaMailUtil.sendMail("회원가입 인증 메일", "인증 코드", emailadrs,code);
		
		out.print("<h3>" + emailadrs + "으로 인증 코드를 전송하였습니다.</h3>");
		out.print("<br><button value=\"확인\" onClick=\"sendChildValue(\'" + code + "\')\">확인</button>");
		
	}else{
		out.print(result);
		out.print("에러 발생!!!(-1)"); 
	}
	
	%>
</body>
<script>
	function fClose(){
	    window.close();
	}
    function sendChildValue(name){
    	opener.setChildValue(name);
    	window.close();
    }
</script>
</html>