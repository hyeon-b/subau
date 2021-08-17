  
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.UserDAO" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="/resources/css/write.css">

<title>수정바다 유리병 :: 편지쓰기</title>
</head>

<body width="100%" height="100%">

<!-- 로그인 된 사람은 로그인 정보 표시 -->
	<%
		String user_id =null;
		String user_nname = null;
		if(session.getAttribute("user_id") != null){
			user_id = (String) session.getAttribute("user_id");
			user_nname = (String) session.getAttribute("user_nname");
		}
		
		String loginout;
		String loginouturl;
		if (user_id == null){
			loginout = "로그인";
			loginouturl="login";
		}
		else {
			loginout = "로그아웃";
			loginouturl = "logout";
		}
		
		UserDAO userDAO = new UserDAO();
		String matches[] = userDAO.searchMatch(user_id);
		
		int matchno = 0;
		for(int i = 0; i < 5; i++){
			if(matches[i] == null) {
				matches[i]="매칭없음";
			}
		}
	%>
	
	
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
    
    <form action="WebSendMail" method="post" enctype="multipart/form-data">
    <div id="content">
    	<div class="ment">
            <block class="site">편지쓰기<img src=/resources/img/letter.png style="width:7%; height:7%; margin-left:10px;"></block>
            <block class="fromto">
                <li><span style="margin-right:4%;">보내는 수정</span>:<span class="nickName"><%=user_nname %></span></li>
                <li><span style="margin-right:8%;">받는 수정</span>:<span class="nickName">
					<select name="selectMatch">
					    <option value="선택" readonly>선택</option>
					    <option value="<%=matches[0]%>"><%=matches[0]%></option>
					    <option value="<%=matches[1]%>"><%=matches[1] %></option>
					    <option value="<%=matches[2]%>"><%=matches[2] %></option>
					    <option value="<%=matches[3]%>"><%=matches[3] %></option>
					    <option value="<%=matches[4]%>"><%=matches[4] %></option>
					</select>
                </span>
                </li></block>
        </div>

        <!--구분 가로선-->
        <hr width = "80%" color = "white" size = "3px" >

        <!--편지 내용 입력-->
        <div class="typo">
        	<div>
                <block class="left">제목</block>
                <textarea class="inputTitle" rows="1" size="40" name="subject" style="width: 300pt;  margin-left: 50px;" required oninvalid="this.setCustomValidity('제목을 입력해주세요!')"
  oninput="this.setCustomValidity('')"></textarea>
            </div>
            <div style="margin-bottom:10px;">
                <block class="left">글쓰기</block>
                <textarea class="inputLetter" size = "1000" name="body" style="width: 950pt; height: 200pt; margin-right: 50px;" required oninvalid="this.setCustomValidity('내용을 입력해주세요!')"
  oninput="this.setCustomValidity('')"></textarea>
            </div>
            <div>
                <block class="left">첨부파일</block>
                <block><input type="file" name="attachment" id="FileOpenInput"></input>
            </div>
        </div>

        <!--전송버튼-->
        <div id = "submit">
          <input type="submit" value="유리병을 띄운다"></input><br>
        </div>
    </div>
    </form>
    <script src="https://code.jquery.com/jquery-1.11.3.js" integrity="sha256-IGWuzKD7mwUnNY01LtXxq3L84Tm/RJtNCYBfXZw3Je0=" crossorigin="anonymous"></script>
    <script> src="https://maxcdn.bootstrapcdn.com.bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfulWVxZxUPnCJA712mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
<script>
	window.addEventListener("load",function(){
		for(var i = 5; i > 0; i--){
		    if(document.getElementsByTagName("select")[0].options[i].value == "매칭없음")
		        document.getElementsByTagName("select")[0].options[i] = null;
		}
	},false)
</script>	
	
</body>
</html>