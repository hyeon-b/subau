<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width">
  <title>수정바다 유리병</title>
  <link rel="stylesheet" href="/resources/css/login.css">
</head>
<body width="100%" height="100%">
  <nav>
    <div class="floating_bar"> 수정바다 유리병</div>
    <ul class="fake_btn">
      <div></div>
      <div></div>
      <div></div>
     </ul>
      
      <% 
	String user_id=null;
    String temp = (String)session.getAttribute("user_id");
	if(session.getAttribute("user_id") != null){
		user_id = (String) session.getAttribute("user_id");
	}
	if (user_id != null)response.sendRedirect("loginAction");
	
	%>
    
    
    <ul class="floating_bar_menu">
      <li><a href="welcome" class="floating_bar_item">메인</a></li>
      <li><a href="introduction" class="floating_bar_item">소개</a></li>
      <li><a href="" class="floating_bar_item">로그인</a></li>
    </ul>

  </nav>
  
  <section class="title">
     <img src="..." alt="수정바다유리병" class="logo">
  </section>
  
  <hr>
  
  
  <!--https://www.nextree.co.kr/p8428/ form 태그 사용법 참고-->
  <form action="loginAction" method="POST" class="login">
    <div>
      <input class="form" type="text" placeholder="ID" name="user_id">
    </div>

    <div>
      <input class="form" type="password" placeholder="PW" name="user_pwd">
    </div>

    <div class="more">
      <a href="signUp" id=sign_up>회원가입</a>
      <a href="pwdSearch" id=find_pw>비밀번호 찾기</a>
    </div>

    <div>
      <input class="button" type="submit" value="로그인">
    </div>
      
   </form> 

  <footer>
    <div class="footer"></div>
  </footer>
  
</body>
</html>