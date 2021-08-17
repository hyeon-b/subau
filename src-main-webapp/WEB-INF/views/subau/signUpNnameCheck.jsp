<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<body>
	<h2>닉네임 중복 체크</h2>
	<%//1. 한글처리 & 받아온 파라미터 변수화
	request.setCharacterEncoding("UTF-8");
	String user_nname = request.getParameter("nname");
	
	//2. UserDAO객체 생성 -> 전달받은 정보 모두 저장
	UserDAO userDAO = new UserDAO();
	
	//3. nnameCheck(별명)메서드
	int result = userDAO.nnameCheck(user_nname);
	if (result == 0){
		out.print(user_nname + "(은)는 사용 가능한 닉네임입니다.");
		//5. 확인버튼
		%>
		 <button value="확인" onClick="fClose()">확인</button>
		<%	
	}else if(result == 1){
		out.print("중복된 닉네임입니다.");
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
</script>
</html>