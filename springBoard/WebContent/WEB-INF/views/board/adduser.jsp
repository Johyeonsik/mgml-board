<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원가입</title>
</head>
<style>
#page {
	margin: 0px auto;
}
#tbl {
	width: 600px;
	margin: 0px auto;
	margin-top: 20px;
	border: none;
	border-radius:10px;
	box-shadow: 2px 2px 5px gray;
	padding: 20px;
}
#list {
	margin-left: 167px;
	margin-top:20px;
	margin-bottom: 20px;
}
#join {
	margin-right: 167px;
	margin-top:20px;
	margin-bottom: 20px;
}
tr,td{
	margin: 10px;
	height: 40px;
}
#msg{
	font-size: 10px;
}
#msgChk{
	font-size: 10px;
}
</style>
<body>
<div id="page" width=600>
	<span id="list"><a href="/board/boardList.do">List</a></span>
	<table id="tbl">
		<tr>
			<td width=150px;>
				ID
			</td>
			<td width=450px;>
				<input type="text" id="id">
				<button id="chkID">중복확인</button>
			</td>
		</tr>
		<tr>
			<td>
				PW
			</td>
			<td>
				<input type="password" id="pass">
				<span id="msg"></span>
			</td>
		</tr>
		<tr>
			<td>
				PW check
			</td>
			<td>
				<input type="password" id="passChk">
				<span id="msgChk"></span>
			</td>
		</tr>
		<tr>
			<td>
				name
			</td>
			<td>
				<input type="text" id="name">
			</td>
		</tr>
		<tr>
			<td>
				phone
			</td>
			<td>
				<select id="tel1" size=3>
					<c:forEach items="${phone}" var="ph">
						<option><c:out value="${ph.phonetype}"></c:out> </option>
					</c:forEach>
				</select>
				<input type="text" id="tel2" size=3 maxlength='4'> -
				<input type="text" id="tel3" size=3 maxlength='4'>
			</td>
		</tr>
		<tr>
			<td>
				postNO
			</td>
			<td>
				<input type="text" id="postNo" maxlength='7' size=4>
			</td>
		</tr>
		<tr>
			<td>
				Address
			</td>
			<td>
				<input type="text" id="Address">
			</td>
		</tr>
		<tr>
			<td>
				Company
			</td>
			<td>
				<input type="text" id="Company">
			</td>
		</tr>
	</table>
	<span id="join" style="float: right;">Join</span>
</div>
</body>
<script>
	var chkID=0;
	//우편번호를 입력하는 경우
	$j("#postNo").on("propertychange change keyup paste input", function(){
		this.value = this.value.replace(/[^0-9]/g,'');   // 입력값이 숫자가 아니면 공백
		this.value = this.value.replace(/,/g,'');          // ,값 공백처리
		this.value = this.value.replace(/\B(?=(\d{3})+(?!\d))/g, "-"); // 정규식을 이용해서 3자리 마다 , 추가 	
	}); 

	//중복확인 버튼을 클릭한 경우
	$j("#chkID").on("click", function(){
		var id = $j("#id").val();
		if(id == ""){
			alert("아이디를 입력하세요");
		}else{
			$j.ajax({
				type : "post",
				url : "/board/chkUser.do",
				data : {id:id},
				success : function(data){
					if(data > 0){
						alert("중복된 아이디 입니다.");
						$j("#id").focus();
					}else {
						alert("등록 가능한 아이디 입니다.");
						chkID=1;
						$j("#chkID").attr("disabled",true);
					}
				}
			});
		}
	});
	//패스워드 자릿수 검사
	$j("#pass").on("propertychange change keyup paste input", function(){
		var pass = $j(this).val();
		if(pass.length < 6){
			$j("#msg").html("6자리 미만입니다.");
			$j("#msg").css("color","red");
		}else if(pass.length > 5 && pass.length < 13){
			$j("#msg").html("적정한 길이의 패스워드 입니다.");
			$j("#msg").css("color","green");
		}else if(pass.length > 12){
			$j("#msg").html("패스워드가 너무 깁니다.");
			$j("#msg").css("color","red");
		}
	});
	//패스워드 일치여부 확인
	$j("#passChk").on("propertychange change keyup paste input", function(){
		var pass = $j("#pass").val();
		var passchk = $j(this).val();
		if(pass != passchk){
			$j("#msgChk").html("패스워드가 일치하지 않습니다");
			$j("#msgChk").css("color","red");
		}else if(pass == passchk){
			$j("#msgChk").html("패스워드가 일치합니다");
			$j("#msgChk").css("color","green");
		}
	});
</script>
</html>