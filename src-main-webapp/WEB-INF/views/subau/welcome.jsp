<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>

<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="user_nname" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width">
  <title>수정바다 유리병 :: 환영해요!!</title>
 <link rel="stylesheet" href="/resources/css/welcome.css">
</head>
<body width="100%" height="100%">
  <nav>
    <div class="floating_bar">수정바다 유리병</div>
    <ul class="fake_btn">
      <div></div>
      <div></div>
      <div></div>
    </ul>
<%
	String userId = (String)session.getAttribute("user_id");
	if (userId == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요.')");
		script.println("location.href='login'");
		script.println("</script>");
	}
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

<!-- 상단바  -->
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
      <li><a href="<%=loginouturl %>" class="floating_bar_item"><%=loginout %></a></li>
    </ul>
    
</nav>

 <div id ="content">
         <!--환영메시지-->
        <div class="ment">
          
            <p class="site"><img src="/resources/img/sea-waves.png" style="width:4%; height:4%; margin-right:10px; display:float;">수정바다 유리병</p>

            <p class="nickName"><%=userNname %></p>
            <p class="welcome">님, 안녕하세요!</p>
            <img src="/resources/img/crystal-ball.png" style="width:4%; height:4%; margin-left:10px; display:float;">
        </div>

        <!--구분 가로선-->
        <hr width = "80%" color = "white" size = "3px" >

        <!--이동버튼들-->
        <div id = "goto">
            <block> 
                <!-- <a href="writeLetter.jsp"><img src="mail-send.png"> </a> -->
                <a href="write"><img src="/resources/img/mail-send.png"> </a>
                <p class="explain">메일보내기</p>
            </block>
            
            <block>
                <a href="list"><img src="/resources/img/mailbox.png"> </a>
                <p class="explain">받은 메일함</p>
            </block>

            <block style="display:block">
                <a href="introduction"><img src="/resources/img/questions.png"> </a>
                <p class="explain">소개 및 사용 방법</p>
            </block>
        </div>

        <!--탈퇴버튼-->
        <div id = "byebye">
            <button id="changePwd" onClick="location='pwdChange'">비밀번호 변경</button>
            <button id="deleteUser" onclick="checkDelete()">탈퇴하기</button>
        </div>
    </div>
    
    <div class="font">
   		<div>Icons made by <a href="https://www.freepik.com" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>
   		<div>Icons made by <a href="https://www.flaticon.com/authors/iconixar" title="iconixar">iconixar</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>
   </div>
  <footer>
    <div class="footer"></div>
  </footer>
 
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
	function checkDelete() {
		if (confirm("정말 탈퇴하시겠습니까??") == true){    //확인
			// TODO 자바를 통해 디비와 연결해서 아이디 중복 체크를 한다.
			var form_data = {
		      user_id: <%=userId%>,
		    };
	
			$.ajax({
		      type: "POST",
		      url: "byebye",
		      data: form_data,
	
		      success: function(response) {
				var result=response.replace(/^.*?<body>(.*?)<\/body>.*?$/s,"$1").trim();
		        if(result == "success") {
				  alert("탈퇴가 완료됐습니다.");
				  location='logout';
		        } else if (result == "fail") {
		          alert("사용자 정보가 없습니다.");
		          location='login';
		        } else if (result == "database error") {
				  alert("데이터베이스 오류입니다");
				}
		      },
		      error: function() {
		        alert("폼 제출 에러입니다!")
		      }
			});	
		} 
		else{   //취소
			return false;
		}
	}
</script>
</html>