<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "boardone.*" %>   
<%
	int num = Integer.parseInt(request.getParameter("num"));
	
	try{
		BoardDto dto = new BoardDao().getArticle(num);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
<script src="script.js"></script>
</head>
<body>
<section>
<b>글 수정하기</b>
<hr color="grey">
<article>
<form method="post" name="writeForm" action="updateProc.jsp?num=<%=num %>" onsubmit="return writeSave()">
<input type="hidden" name="writer" value="<%=dto.getWriter() %>">
	<table class="board" border="1">
		<tr>
			<td class="attr">이름</td>
			<td><%= dto.getWriter() %></td>
		</tr>
		<tr>
			<td class="attr">이메일</td>
			<td><input type="email" name="email"
			  			value="<%=dto.getEmail()%>"/></td>
		</tr>
		<tr>
			<td class="attr">제목</td>
			<td>
			<input class="input" type="text" name="subject" value="<%=dto.getSubject() %>"/>
			</td>
		</tr>
		<tr>
			<td class="attr">내용</td>
			<td>
				<textarea name="content" rows="13" cols="50"><%=dto.getContent() %>
				</textarea>
			</td>
		</tr>
		<tr>
			<td class="attr">비밀번호</td>
			<td><input type="password" name="pass"/></td>
		</tr>
		<tr>
			<td class="arrt">첨부파일 :</td>
			<td><% if(dto.getFilename() != null){ %>
				<img src="images/file.png" width="16" height="16"/>
				<%= dto.getFilename() %>
				<%  } %>
				</td>
		</tr>
		<tr>
			<td colspan="2" class="attr">
				<input type="submit" value="수정"/>
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
