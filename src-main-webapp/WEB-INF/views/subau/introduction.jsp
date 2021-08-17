<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width">
  <title>수정바다 유리병</title>
   <link rel="stylesheet" href="/resources/css/introduction.css">
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
       <p class="signIn"> 수정바다 유리병</p>
   </div>
   <div class="introd" id="int">
     <h1>소개</h1>
     <hr>
     <p>&nbsp지속하는 코로나 19 펜데믹 상황으로 인해 비대면 수업을 장기화함에 따라, 재학생 사이의 교류가 감소했습니다. 
        저희는 “수정바다 유리병” 웹사이트를 통해 비대면으로 만나지 못하는 학생들 간 일대일 소통과 교류의 장을 마련하고자 합니다.
        회원가입을 통해 재학생임을 증명받은 이용자들이 무작위로 1:1 매칭을 맺어 이메일을 주고받을 수 있습니다.
        학과, 학년, 나이에 제한 없이 같은 학교의 학생이라는 공통점 속에서 유대 관계를 맺을 수 있으면 좋겠습니다.
      </p>
   </div>
   <div class="introd" id="howto">
     <h1>사용 방법</h1>
     <hr>
     <p>&nbsp해당 사이트 이용을 위해선 회원가입이 필요합니다. 회원가입은 이메일 인증을 통해 할 수 있는데, 
       이때 꼭! 성신여자대학교 이메일을 사용해야 합니다. 재학생임을 확인하기 위한 절차이기도 합니다.
       회원 가입을 할 때는 닉네임도 설정하는데 이메일을 주고받을 때 사용되므로 자신을 드러내지 않는 것을 사용하기를 권합니다.
       <br>&nbsp매칭을 신청하면 다른 사용자와 매칭이 되어 서로 메일을 주고받을 수 있게 됩니다. 최대 매칭은 5번 가능하고 새로 매칭을 하기 위해서는
       기존의 매칭을 끊고 새로 신청해야 합니다. 이때, 모든 사용자는 익명으로 표시됩니다. 
       사이트에서 상대방에게 보낼 글을 작성하고 전송 버튼을 누르면 저희가 서로의 정보를 알지 못하게 대신 전달해 드립니다.</p>
   </div>
   

  <footer>
    <div class="footer"></div>
  </footer>

</body>