<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ȸ������</title>
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
				<button id="chkID">�ߺ�Ȯ��</button>
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
	//�����ȣ�� �Է��ϴ� ���
	$j("#postNo").on("propertychange change keyup paste input", function(){
		this.value = this.value.replace(/[^0-9]/g,'');   // �Է°��� ���ڰ� �ƴϸ� ����
		this.value = this.value.replace(/,/g,'');          // ,�� ����ó��
		this.value = this.value.replace(/\B(?=(\d{3})+(?!\d))/g, "-"); // ���Խ��� �̿��ؼ� 3�ڸ� ���� , �߰� 	
	}); 

	//�ߺ�Ȯ�� ��ư�� Ŭ���� ���
	$j("#chkID").on("click", function(){
		var id = $j("#id").val();
		if(id == ""){
			alert("���̵� �Է��ϼ���");
		}else{
			$j.ajax({
				type : "post",
				url : "/board/chkUser.do",
				data : {id:id},
				success : function(data){
					if(data > 0){
						alert("�ߺ��� ���̵� �Դϴ�.");
						$j("#id").focus();
					}else {
						alert("��� ������ ���̵� �Դϴ�.");
						chkID=1;
						$j("#chkID").attr("disabled",true);
					}
				}
			});
		}
	});
	//�н����� �ڸ��� �˻�
	$j("#pass").on("propertychange change keyup paste input", function(){
		var pass = $j(this).val();
		if(pass.length < 6){
			$j("#msg").html("6�ڸ� �̸��Դϴ�.");
			$j("#msg").css("color","red");
		}else if(pass.length > 5 && pass.length < 13){
			$j("#msg").html("������ ������ �н����� �Դϴ�.");
			$j("#msg").css("color","green");
		}else if(pass.length > 12){
			$j("#msg").html("�н����尡 �ʹ� ��ϴ�.");
			$j("#msg").css("color","red");
		}
	});
	//�н����� ��ġ���� Ȯ��
	$j("#passChk").on("propertychange change keyup paste input", function(){
		var pass = $j("#pass").val();
		var passchk = $j(this).val();
		if(pass != passchk){
			$j("#msgChk").html("�н����尡 ��ġ���� �ʽ��ϴ�");
			$j("#msgChk").css("color","red");
		}else if(pass == passchk){
			$j("#msgChk").html("�н����尡 ��ġ�մϴ�");
			$j("#msgChk").css("color","green");
		}
	});
</script>
</html>