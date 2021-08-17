<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
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

    <ul class="floating_bar_menu">
      <li><a href="welcome" class="floating_bar_item">메인</a></li>
      <li><a href="introduction" class="floating_bar_item">소개</a></li>
      <li><a href="login" class="floating_bar_item">로그인</a></li>
    </ul>

  </nav>

  <div id ="content">
    <!--회원가입 글자-->
   <div>
       <p class="signIn"> 회원가입</p>
   </div>

   <!--구분 가로선-->
   <hr>

   <!--기입란-->
   <form action="signup" method="post" class="Signup">
	<h1 id="code"></h1>
	<table class="tg">
	  <tbody>
		
	  <tr><!--아이디 기입-->
        <td class="tg-my85">아이디</td>
        <td class="tg-73oq"><input type = "text" name = "user_id" id="id" size = "15" style="width:45%;"><span style="margin-left:5px; vertical-align:-10px; color:gray; font-size:16px;">@sungshin.ac.kr</span><br>
          <span style="font-weight:bold;text-decoration:underline; vertical-align:-8px;">학교 이메일</span><span style="text-decoration:underline; vertical-align:-8px;">로만 회원가입이 가능합니다</span></td>
        <td><button onClick="event.preventDefault(); sendEmail()">인증메일 전송</button></td>
      </tr>
    
      <tr><!--닉네임 기입-->
        <td class="tg-my85">닉네임</td>
        <td class="tg-73oq"><input type = "text" name = "nickName" id="nname" size = "30"><br><span style="font-weight:bold;text-decoration:underline;color:#333; vertical-align:-8px;">본인을 드러내지 않는</span><span style="text-decoration:underline;color:#333; vertical-align:-8px;"> 닉네임을 추천합니다</span></td>
        <td><button onClick="event.preventDefault(); nnameCheck()">중복확인</button></td>
      </tr>

      <tr><!--비밀번호 기입-->
        <td class="tg-my85">비밀번호</td>
        <td class="tg-73oq"><input type = "password" name = "user_pwd" id="pwd" size = "30"></td>
        <td class="tg-73oq"></td>
      </tr>

      <tr><!--비밀번호 확인-->
        <td class="tg-my85">비밀번호 확인</td>
        <td class="tg-73oq"><input type = "password" name = "passwordCheck" id="pwdck" size = "30" onInput="isSame()"></td>
        <td class="tg-73oq"></td>
      </tr>
      <tr><!--비밀번호 두 개 일치 확인-->
        <td></td>
        <td><span id="same"></span></td>
      </tr>
    </tbody>
    </table>

   <div style="text-align:center;">
       <input id = "signUp" type = "submit" onClick="ifIdCheck(event); ifNnameCheck(event); pwdCheck(event);" value = "회원가입" >
   </div>
   </div>
  </form>

  <footer>
    <div class="footer"></div>
  </footer>
</body>

    <script type="text/javascript" src="/resources/js/signUp.js"></script>
</body>