<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardView</title>
</head>
<style>
.viewUpdate{
	display : none;
}
</style>
<body>
<table align="center">
	<tr style="display: none;">
		<td id="type">${board.boardType}</td>
		<td id="num">${board.boardNum}</td>
	</tr>
	<tr>
		<td>
			<table border ="1">
				<tr>
					<td width="120" align="center">
					Title
					</td>
					<td width="400" class="view">
					${board.boardTitle}
					</td>
					<td width="400" class="viewUpdate" >
					<input type="text" value="${board.boardTitle}" id="titleVal">
					</td>
				</tr>
				<tr>
					<td height="300" align="center">
					Comment
					</td>
					<td class = "view">
					${board.boardComment}
					</td>
					<td class = "viewUpdate">
					<textarea rows="20" cols="55" id="commentVal">${board.boardComment}</textarea> 
					</td>
				</tr>
				<tr>
					<td align="center">
					Writer
					</td>
					<td>
					${board.creator}
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align="right">
			<a href="/board/boardList.do">List</a>
			<button id="btnUpdate">����</button>
			<button id="btnDelete">����</button>
		</td>
	</tr>
</table>	
<script>

$j(document).ready(function(){
	var strTitle = $j("#titleVal").val().replace("||",",");
	var strComment = $j("#commentVal").text().replace("||",",");
	$j("#titleVal").html(strTitle);
	$j("#commentVal").html(strComment);
});
	
	$j("#btnDelete").on("click",function(){
		var boardNum = $j("#num").html();
		var boardType = $j("#type").html();
		alert(boardNum + boardType);
		
		if(!confirm("�����Ͻðڽ��ϱ�?")) return;
		$j.ajax({
			type:"post",
			url:"/board/boardDelete.do",
			data:{boardNum:boardNum, boardType:boardType},
			success: function(data, textStatus, jqXHR){
				alert("����"+data.success);
				console.log(data)
				alert("�޼���:"+data.success);
				location.href="/board/boardList.do";
			},
		    error: function (jqXHR, textStatus, errorThrown)
		    {
		    	alert("����");
		    }
		});
	});
	$j("#btnUpdate").on("click", function(){
		
		if($j(".viewUpdate").css("display") == "none"){
			if(!confirm("�����Ͻðڽ��ϱ�?")) return;
			$j(".view").hide();
			$j(".viewUpdate").show();
		}else{
			var title = $j("#titleVal").val();
			var comment = $j("#commentVal").val();
			var boardNum = $j("#num").html();
			var boardType = $j("#type").html();
			alert(title +"\n"+comment +"\n"+ boardNum +"\n"+ boardType)
			if(!confirm("�����Ͻðڽ��ϱ�?")) return;
			$j.ajax({
				type:"post",
				url:"/board/boardUpdate.do",
				data:{boardTitle:title, boardComment:comment, boardNum:boardNum, boardType:boardType},
				success: function(data, textStatus, jqXHR){
					alert("����Ϸ�");
					console.log(data)
					alert("�޼���:"+data.success);
					location.reload();
				}
			});
		}
	});
</script>
</body>
</html>