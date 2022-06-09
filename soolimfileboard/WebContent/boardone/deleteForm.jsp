<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>

<script>
	function deleteSave(){
		if(document.delForm.pass.value ==""){
			alert("비밀번호를 입력하세요");
			document.delForm.pass.focus();
			return false;
		}
	}
</script>
</head>
<body>
<section>
<b>글을 정말 삭제하시겠습니까?</b>
<hr color="grey">
<form method="post" name="delForm" action="deleteProc.jsp" onsubmit="return deleteSave()">
<table class="deletetable">
	<tr>
		<th><b>비밀번호를 입력 해주세요</b></th>
	</tr>
	<tr>
		<td>비밀번호 :
			<input type="password" name="pass">
			<input type="hidden" name="num" value="<%= num %>">
		</td>
	</tr>
	<tr>
		<td>
			<input type="submit" value="삭제">
			<input type="button" value="취소" onClick="document.location.href='list.jsp'">
		</td>
	</tr>
</table>
</form>
</section>

</body>
</html>