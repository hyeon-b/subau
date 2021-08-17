<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width">
  <title>수정바다 유리병</title>
   <link rel="stylesheet" href="/resources/css/signUp.css">
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
	String userId = (String)session.getAttribute("user_id");
	String userNname = (String)session.getAttribute("user_nname");
	String loginout;
	String loginouturl;
	if (userId == null){
		loginout = "로그인";
		loginouturl="login";
	}
	else {
		loginout = "로그아웃";
		loginouturl = "logout";
	}
%>

    <ul class="floating_bar_menu">
      <li><a href="welcome" class="floating_bar_item">메인</a></li>
      <li><a href="introduction" class="floating_bar_item">소개</a></li>
      <li><a href="<%=loginouturl %>" class="floating_bar_item"><%=loginout %></a></li>
    </ul>

  </nav>

  <div id ="content">
    <!--회원가입 글자-->
   <div>
       <p class="signIn"> 비밀번호 변경 </p>
   </div>

   <!--구분 가로선-->
   <hr>

   <!--기입란-->
  <form action="changepwd" method="post" class="ChangePwd">
   <table class="tg">
    <tbody>
      <tr><!--아이디 기입-->
        <td class="tg-my85">기존 비밀번호</td>
        <td class="tg-73oq"><input type = "password" name = "orgPwd" id="orgPwd" size = "30"></span><br>
      </tr>
      <tr><!--비밀번호 기입-->
        <td class="tg-my85">설정할 비밀번호</td>
        <td class="tg-73oq"><input type = "password" name = "user_pwd" id="pwd" size = "30"></td>
        <td class="tg-73oq"></td>
      </tr>
      <tr><!--비밀번호 확인-->
        <td class="tg-my85">비밀번호 확인</td>
        <td class="tg-73oq"><input type = "password" name = "passwordCheck" id="pwdck" size = "30"></td>
        <td class="tg-73oq"></td>
      </tr>
      <tr><!--비밀번호 두 개 일치 확인-->
        <td></td>
        <td><span id="same"></span></td>
      </tr>
    </tbody>
    </table>

   <div style="text-align:center;">
       <input id = "signUp" type = "submit" onClick="pwdCheck(event); isSame(event)" value = "확인" >
   </div>
   </div>
  </form>
     <!--구분 가로선-->
   <hr>
  
  <footer>
    <div class="footer"></div>
  </footer>
</body>
   <script>
  		function pwdCheck(){
   		    var pwd = document.querySelector("#pwd").value;
   		    var pwdck = document.querySelector("#pwdck").value;
			if(pwd.length > 20 || pwdck.length > 20){
	  			event.preventDefault();
				alert('비밀번호가 너무 깁니다.');
			}
			else return true;
  		}
   		function isSame(event){
   		    var pwd = document.querySelector("#pwd").value;
   		    var pwdck = document.querySelector("#pwdck").value;
   		    if(pwd !== '' && pwdck !== '') {
   		      if(pwd==pwdck) {
   		        return true;
   		      }
   		      else {
   	   			event.preventDefault();
   		        alert('비밀번호 확인을 다시 해주십시오');
   		      }
   		    }else{
   	   			event.preventDefault();
   		    	alert('설정할 비밀번호를 입력해주십시오');
   		    }
   		}
   </script>
</html>