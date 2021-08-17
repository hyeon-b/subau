<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.UserDAO" %>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>수정바다 유리병</title>
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/list.css'/>"></link>
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
</head>
<body>
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
    >


<!-- 받은 메일함  -->
<form action="" method="get">
    <table id="listTable">
      <thead>
        <tr id="tableHead">
          <th></th>
          <th></th>
          <th>작성자</th>
          <th>마지막 메일 수신 날짜</th>
        </tr>
      </thead>
      
      <tbody>
      <!-- 구분선  -->
      <tr class="tableHr">
          <td colspan="5"><hr></td>
      </tr>

      <c:forEach items="${list}" var="list">
      <tr>
          <td></td>
          <td> <input type="checkbox" class="chk" name="partnerToUnconnect" value="${list.sender}"></td>
          <td>
	          <div class="writer">
	          	<a href="mail"> <c:out value="${list.user_nname}"/> </a>
	          </div>
	      </td>  
          <td class="date"><fmt:formatDate pattern="yyyy/MM/dd" value="${list.sndtime}"/></td>
        </tr>
      </c:forEach>
      <tr class="tableHr"> <td colspan="5"> <hr> </td> </tr>
      </tbody>

      <tfoot>
      <tr class="etc">
      	<td><input type="button" id="unmatching" value="매칭끊기"></td>
	    <td><input type="button" id="matching" value="매칭신청" onClick="location.href='matching'"></td>

      </tr>
      </tfoot>
      
	</table>
</form>
  
  <footer>
    <div class="footer"></div>
    
  </footer>

<script>

	/*'매칭끊기'를 누를 경우, 매칭끊을 상대에 대한 정보(id)를 controller로 넘김*/
	var delcheck=[];
	
	$("#unmatching").click(function(){
		//if('.chk:checked') //선택된 것이 없다면
		
		var result = confirm('정말로 선택한 상대와의 매칭을 끊겠습니까?\n 매칭을 끊으면 상대방과 더 이상 편지를 주고받을 수 없습니다.');
		if(result){
			$('.chk:checked').each(function() {
				delcheck.push($(this).val());
				
				$.ajax({
					url : '/mailBox/unmatching',
					type:'post',
					dataType:'text',
					data:{
						unmatching : delcheck
						},
					success:function(data){
						console.log("success\n");
						console.log(data);
						location.reload();
						 },
						
					error : function(data) {
				        console.log("fail\n");
				        console.log(data);
				         }		
					}) //ajax문 끝
			});
			alert("선택한 상대와 매칭을 끊었습니다.\n '매칭신청'으로 새로운 인연을 찾아보세요.");
		}//if문 끝
		else {
			
			}
		});

		
	window.onpageshow = function(event) {
		if ( event.persisted || (window.performance && window.performance.navigation.type == 2)) {
			// Back Forward Cache로 브라우저가 로딩될 경우 혹은 브라우저 뒤로가기 했을 경우
			history.go(0);	//새로고침
		}
	}
</script>
</body>
</html>