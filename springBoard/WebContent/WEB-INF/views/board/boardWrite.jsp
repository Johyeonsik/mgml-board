<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardWrite</title>
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
button,input[type=button]{
	border: none;
	box-shadow: 2px 2px 5px gray;
	border-radius: 5px;
	height: 25px;
	background: #545454;
	color: white;
	font-size: 12px;
	cursor: pointer;
}

</style>
<script type="text/javascript">

	$j(document).ready(function(){
		//행 삭제버튼을 클릭한 경우
		$j("#boardTable").on("click", ".delRow", function(e){
			e.preventDefault();
			var target = $j(this).closest('tr');
			target.next().remove();
			target.prev().remove();
			target.remove();
			
		});
		//행추가 버튼을 클릭한 경우
		$j("#rowAdd").on("click",function(e){
			e.preventDefault();
			 // table element 찾기
			  var table = document.getElementById('boardTable');
			  
			  // 새 행(Row) 추가 (테이블 중간에)
			  var countRow = table.insertRow(3);
			  var selectRow = table.insertRow(4);
			  var titleRow = table.insertRow(5);
			  var commentRow = table.insertRow(6);
			  
			  // 새 행(Row)에 Cell 추가
			  var countCell1 = countRow.insertCell(0);
			  var selectCell1 = selectRow.insertCell(0);
			  var selectCell2 = selectRow.insertCell(1);
			  var titleCell1 = titleRow.insertCell(0);
			  var titleCell2 = titleRow.insertCell(1);
			  var commentCell1 = commentRow.insertCell(0);
			  var commentCell2 = commentRow.insertCell(1);
			  

			  
			  // Cell에 텍스트 추가
			 
			  titleCell1.innerText = 'Title';
			  titleCell2.innerHTML = "<input type='text' class='boardTitle' size='50' ><button class='delRow' style='margin-left:5px;'>삭제</button> ";
			  commentCell1.innerHTML = "Comment";
			  commentCell2.innerHTML = "<textarea rows='20'cols='55' class='boardComment'></textarea>";
			  selectCell1.innerHTML = "Type";
			  selectCell2.innerHTML = "<td width='400'><select id='type' class='boardType'><c:forEach var='list' items='${boardType}'><option value='${list.codeId}'>${list.codeName}</option></c:forEach></select></td>";
			  
			  //스타일 추가
			  selectCell1.style.cssText="text-align:center";
			  titleCell1.style.cssText="text-align:center";
			  commentCell1.style.cssText="text-align:center";
			  commentRow.style.cssText="border-bottom: 1px solid gray";
			  
			  //클래스 네임 추가
			  var length=$j(".boardTitle").length;
			  countCell1.innerHTML = "<span class='countRow'>"+length+"ROW"+"<span>";
			  //$j('.countRow').html(length+"행");
			  $j('.countRow').parent().attr("colspan",2);
			  $j('.countRow').parent().attr("align","center");
			  
			  var table=$j(this).closest(".boardWrite").find("#boardTable");
			  var titleRow = table.find('tr:eq(3)');
			  var title = titleRow.find('.boardTitle');
			  var commentRow = table.find('tr:eq(4)');
			  var comment = commentRow.find('.boardComment');
			  
				
			  title.addClass('AddTitle'+length);
			  //$j('.AddTitle').removeClass('AddTitle');
			  comment.addClass('AddComment'+length);
			  //$j('.AddComment').removeClass('AddComment');

		});

		//저장 버튼을 클릭한 경우
		$j(frm).on("submit",function(e){
			e.preventDefault();
			var i=0;
			$j(".boardType").each(function(){
				$j(this).attr("name","boardVoList["+i+"].boardType")
				i++;
			});
			i=0;
			$j(".boardTitle").each(function(){
				$j(this).attr("name","boardVoList["+i+"].boardTitle")
				alert("boardVoList["+i+"].boardTitle");
				i++;
			});
			i=0;
			$j(".boardComment").each(function(){
				$j(this).attr("name","boardVoList["+i+"].boardComment")
				i++;
			});
			
			var $frm = $j('.boardWrite :input');
			var param = $frm.serialize();
			//저장하기
			$j.ajax({
			    url : "/board/boardWriteAction.do",
			    dataType: "json",
			    type: "POST",
// 			    data : {boardTitle:titleArr, boardComment:commentArr},
			    data: param,
// 			    processData: false, //add this
// 			    contentType: false, //and this
			    success: function(data, textStatus, jqXHR)
			    {
					alert("작성완료");
					console.log(data)
					alert("메세지:"+data.success);
					
					location.href = "/board/boardList.do?pageNo=${pageNo}";
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
<form name="frm" class="boardWrite" id="formData" action="/board/boardWriteAction.do" method="post">
	<table align="center">
		<tr>
			<td align="right">
			<button id="rowAdd">rowAdd</button>
			<input type="submit" value="Write" cnt=${totalCnt}>
			</td>
		</tr>
		<tr>
			<td>
				<table id="boardTable"> 
					<tr>
						<td width="120" align="center">
						Type
						</td>
						<td width="400">
							<select id="type" class="boardType">
								<c:forEach var="list" items="${boardType}">
									<option value="${list.codeId}">${list.codeName}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<td width="120" align="center">
						Title
						</td>
						<td width="400">
						<input type="text" size="50" value="${board.boardTitle}" class="boardTitle">
						</td>
					</tr>
					<tr>
						<td height="300" align="center">
						Comment
						</td>
						<td valign="top">
						<textarea rows="20" cols="55" class="boardComment">${board.boardComment}</textarea>
						</td>
					</tr>
					<tr>
						<td align="center">
						Writer
						</td>
						<td>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td align="right">
				<a href="/board/boardList.do">List</a>
			</td>
		</tr>
	</table>
</form>	
</body>
</html>