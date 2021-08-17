var ifIdChecked = 0;
var code = '';
var codeChecked = 0;

function ifIdCheck(event){
	if (codeChecked == 0){
		event.preventDefault();
		alert('이메일 인증을 해주십시오.');
	}
	else return true;
}

function sendEmail() {
	var emailadrs = document.querySelectorAll("input")[0].value;
	if(codeChecked != 1){
		if(emailadrs.length != 8){
			alert('올바른 이메일 주소를 입력하십시오.');
		}else{
			ifIdChecked++;
			emailadrs = encodeURIComponent(emailadrs);
			window.open("pwdSearchSendMail?emailadrs="+emailadrs,"","width=500, height=300");
			insertCode();
		}
	}
	else{
		alert('인증이 완료되었습니다.');
	}
}

function setChildValue(name){
	code = name;
}

function codeCheck(event) {
	event.preventDefault();
	var usrCode = document.getElementById("insertCode").value;
	if(code !== usrCode || code === ''){
		alert('인증번호가 올바르지 않습니다.');
	}else{
		codeChecked = 1;
		//입력부분 막기
		document.getElementById('insertCode').disabled = true;
		document.querySelectorAll("input")[0].disabled=true;
		alert('인증번호가 확인되었습니다.');
	}
}

function insertCode(){
	  var insert = document.querySelector("tr:nth-child(2)");
	  if(insert.id !== "insert"){
	   	  insert.insertAdjacentHTML('beforebegin', 
	   	  "<tr id=\"insert\"><td class=\"tg-my85\">인증코드 입력</td><td class=\"tg-73oq\"><input type = \"text\" id=\"insertCode\" name = \"emailauth\" size = \"30\"></td><td><button onClick=\"codeCheck(event)\">인증코드 확인</button></td></tr>");		
	  }
}

function sendTempPwd(){
	if (codeChecked == 1){
		var emailadrs = document.querySelectorAll("input")[0].value;
		emailadrs = encodeURIComponent(emailadrs);
		window.open("sendTempPwd?emailadrs="+emailadrs,"","width=500, height=300");
	}
}

function moveToLogin() {
	location.href='/login';
}