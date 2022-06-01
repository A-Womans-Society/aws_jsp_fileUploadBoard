<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="boardone.*" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
</head>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	
	try{
		BoardDto dto = new BoardDao().getArticle(num);
		
		//System.out.println(dto.getReadcount());
%>

<body>
<section>
<article>
<b>글 내용 보기</b>
<hr color="grey">
<form>
	<table class="contenttable" border="1">
	<tr>
		<th>글번호</th>
		<td><%= dto.getNum() %></td>
		<th>조회수</th>
		<td><%= dto.getReadcount() %></td>
	</tr>
	<tr>
		<th>작성자</th>
		<td><%=dto.getWriter() %></td>
		<th>작성일</th>
		<td><%=dto.getRegdate() %></td>
	</tr>
	<tr>
		<th>글제목</th>
		<td colspan="3" class="contenttitle"><pre><%=dto.getSubject() %></pre></td>
	</tr>
	<tr>
		<th>글내용</th>
		<td colspan="3" class="content"><pre><%=dto.getContent() %></pre></td>
	</tr>
	<tr>
		<th>첨부파일</th>
		<td colspan="3"><% if(dto.getFilename() != null) { %>
		<a href="/boardone/fileupload/<%=dto.getFilename() %>" target=blank><%=dto.getFilename() %></a>
		<%} else { %>
		첨부파일 없음.
		<% } %>
		</td>
	</tr>
	<tr>
		<td colspan="4">
			<input type="button" value="수정" 
			 onClick="document.location.href='updateForm.jsp?num=<%=dto.getNum() %>'">
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" value="삭제" 
			 onClick="document.location.href='deleteForm.jsp?num=<%=dto.getNum() %>'">
			 &nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" value="목록"
			 onClick="document.location.href='list.jsp'">
		</td>
	</tr>
	</table>
<%  
} catch(Exception e){}
%>
</form>
</article>
</section>
</body>
</html>