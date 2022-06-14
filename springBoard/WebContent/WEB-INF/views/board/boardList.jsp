<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>list</title>
</head>
<style>
#boardTable{
	box-shadow: 2px 2px 5px gray;
	border-radius: 10px;
	padding: 10px;
	border: none;
}
#title{
	font-size: 15px;
	font-weight: bold;
	text-align: center;
	padding: 10px;
}
tr{
	padding: 10px;
	margin: 10px;
}
td{
	padding-top: 5px;
	padding-bottom: 5px;
}
.row{
	font-size: 13px;
	text-align: center;
	padding: 10px;
	margin: 10px;
}
a {
	text-decoration: none;
	color: #323232;
}
a:hover{
	font-weight: bold;
	color: coral;
}
.btnDelete{
	border: none;
	box-shadow: 2px 2px 5px gray;
	border-radius: 5px;
	width: 40px;
	height: 35px;
	background: #545454;
	color: white;
	font-size: 12px;
	cursor: pointer;
}
</style>
<script type="text/javascript">
	var sort = [];
	
	$j(document).ready(function(){
		$j("#search").on("click", function(){
			$j(".chk").each(function(){
				if($j(this).prop("checked")){
					sort += $j(this).val();
				}
			});
			$j.ajax({
				type: "get",
				url: "/board/boardList.do",
				data: {sort:sort},
				success: function(data){
					
				}
			});
		});
		//전체 체크박스 클릭한 경우
		$j("#tbl").on("click","#allChk", function(){	
	 		if($j('#allChk').prop("checked")){
	 			$j("input[type=checkbox]").prop("checked",true);
	 		}else{
	 			$j("input[type=checkbox]").prop("checked",false);
	 		}
		});
		//개별 선택박스를 클릭한 경우
		$j("#tbl").on('click','.chk',function(){
		    if($j('input[class=chk]:checked').length==$j('.chk').length){
		        $j('#allChk').prop('checked',true);
		    }else{
		       $j('#allChk').prop('checked',false);
		    }
		});
		//삭제버튼을 클릭한 경우
		$j("#tbl").on("click", ".btnDelete", function(){
			var num = $j(this).closest(".row").find(".num").html();
			var type = $j(this).closest(".row").find(".type").html();

			if(!confirm("삭제하시겠습니까?")) return;
			$j.ajax({
				type:"post",
				url:"/board/boardDelete.do",
				data:{boardNum:num, boardType:type},
				success: function(data, textStatus, jqXHR){
					alert("삭제"+data.success);
					console.log(data)
					alert("메세지:"+data.success);
					location.reload();
				},
			    error: function (jqXHR, textStatus, errorThrown)
			    {
			    	alert("실패");
			    }
			});
			
			
		});
	});
	

</script>
<body>
	<form name="frm" action="/board/boardList.do" method="get">
		<table  align="center" id="tbl">
			<tr>
				<td>
					<span><a href="#">Login</a></span>
					<span><a href="/board/adduser.do">Join</a></span>
					<span style="float: right;">total : ${totalCnt}</span>
				</td>
			</tr>
			<tr>
				<td>
					<table id="boardTable" >
						<tr id="title">
							<td width="80">
								Type
							</td>
							<td width="40">
								No
							</td>
							<td width="300">
								Title
							</td>
							<td width="50">
								Delete
							</td>
						</tr>
						<c:forEach items="${boardList}" var="list">
							<tr class="row">
								<td align="center" >
									<span class="type" style="display:none;">${list.boardType}</span>
									<span class="name">${list.codeName}</span>
								</td>
								<td>
									<span class="num">${list.boardNum}</span>
								</td>
								<td>
									<a href = "/board/${list.boardType}/${list.boardNum}/boardView.do?pageNo=${pageNo}">${list.boardTitle}</a>
								</td>
								<td>
									<button class="btnDelete">삭제</button>
								</td>
							</tr>	
						</c:forEach>
					</table>
				</td>
			</tr>
			<tr>
				<td align="right">
					<a href ="/board/boardWrite.do?total=" + ${total}>글쓰기</a>
				</td>
			</tr>
			<tr>
				<td>
					<input type="checkbox" id="allChk" value="all" name = "all">전체
					<c:forEach items="${search}" var="list">
						<input type="checkbox" class="chk" value="${list.codeId}" name ="sort">${list.codeName}
					</c:forEach>
					<input type="submit" value="조회">
				</td>
			</tr>
		</table>
	</form>	
</body>
</html>