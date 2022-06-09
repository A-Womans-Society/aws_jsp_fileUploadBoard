<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Board</title>
<script src="script.js"></script>
</head>
<!-- 새글과 답글을 구분 / 새글의 경우 num=0 이라는 값이 넘어가고
답글일 경우 원본 글의 num 값을 받아온다. -->
<%
	int num = 0;
	int ref = 1;
	int step = 0;
	int depth = 0;
	try{
		if(request.getParameter("num") != null){
			num = Integer.parseInt(request.getParameter("num"));
			ref = Integer.parseInt(request.getParameter("ref"));
			step = Integer.parseInt(request.getParameter("step"));
			depth = Integer.parseInt(request.getParameter("depth"));
		}
%>
<body>
<section>
<b>글쓰기</b>
<article>
	<form method="post" name="writeForm" action="writeProc.jsp" onsubmit="return writeSave()"
	 enctype="multipart/form-data">
	<!-- wirteProc 페이지로 이동할 때 num,ref,step,depth의 값을 갖고 가야하므로
	hidden 형태로 넘겨준다 -->
	<input type="hidden" name="num" value="<%=num %>"/>
	<input type="hidden" name="ref" value="<%=ref %>"/>
	<input type="hidden" name="step" value="<%=step %>"/>
	<input type="hidden" name="depth" value="<%=depth %>"/>
	
	<table class="board">
		<tr>
			<td class="attr">이름</td>
			<td><input type="text" name="writer"/></td>
		</tr>
		<tr>
			<td class="attr">이메일</td>
			<td><input type="email" name="email"/></td>
		</tr>
		<tr>
			<td class="attr">제목</td>
			<td>
			<% if(request.getParameter("num") == null) { %>
				<input class="input" type="text" name="subject"/>
			<%} else { %>
				<input class="input" type="text" name="subject" value="[답변]"/>
			<%} %>
			</td>
		</tr>
		<tr>
			<td class="attr">내용</td>
			<td>
				<textarea name="content" rows="13" cols="50"></textarea>
			</td>
		</tr>
		<tr>
			<td class="attr">비밀번호</td>
			<td><input type="password" name="pass"/></td>
		</tr>
		<tr>
			<td class="arrt">파일선택 :</td>
			<td><input type="file" name="uploadfile"/></td>
		</tr>
		<tr>
			<td colspan="2" class="attr">
				<input type="submit" value="글쓰기"/>
				<input type="reset" value="다시 작성"/>
				<input type="button" value="목록" onClick="window.location='list.jsp'">
			</td>
		</tr>
	</table>
</form>
</article>
</section>
<%
	}catch(Exception e){
		e.printStackTrace();
	}
%>
</body>
</html>
