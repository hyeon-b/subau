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

    <ul class="floating_bar_menu">
      <li><a href="welcome" class="floating_bar_item">메인</a></li>
      <li><a href="introduction" class="floating_bar_item">소개</a></li>
      <li><a href="login" class="floating_bar_item">로그인</a></li>
    </ul>

  </nav>

  <div id ="content">
    <!--회원가입 글자-->
   <div>
       <p class="signIn"> 비밀번호 찾기</p>
   </div>

   <!--구분 가로선-->
   <hr>

   <!--기입란-->
  <form>
   <table class="tg">
    <tbody>
      <tr><!--아이디 기입-->
        <td class="tg-my85">아이디</td>
        <td class="tg-73oq"><input type = "text" name = "user_id" id="id" size = "15" style="width:45%;"><span style="margin-left:5px; vertical-align:-10px; color:gray; font-size:16px;">@sungshin.ac.kr</span><br>
        <td class><button onClick="event.preventDefault(); sendEmail()">인증메일 전송</button></td>
      </tr>
      <tr></tr>
    </tbody>
    </table>

   <div style="text-align:center;">
       <input id = "signUp" type = "submit" onClick="ifIdCheck(event); sendTempPwd(); moveToLogin()" value = "확인" >
   </div>
   </div>
  </form>
     <!--구분 가로선-->
   <hr>
  
  <footer>
    <div class="footer"></div>
  </footer>
</body>
   <script type="text/javascript" src="/resources/js/pwdSearch.js">
   </script>
</html>