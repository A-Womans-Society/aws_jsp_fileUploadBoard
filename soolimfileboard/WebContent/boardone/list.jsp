<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "boardone.*" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.SimpleDateFormat" %>

<%!
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>
<%
	int count = 0;
	List<BoardDto> articleList = null;
	BoardDao dao = new BoardDao();
	count = dao.getArticleCount();
	
	if(count > 0){
		articleList = dao.getArticles();
	}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
</head>
<body>
<section>
<article>
<b>글목록(전체 글:<%= count %>)</b>
<hr color=grey>
<table class= "listwritebotton">
	<tr>
	<td><a href = "writeForm.jsp">글쓰기</a></td>
	<tr>
</table>
<%
	if(count == 0){
%>
<table border="1">
	<tr>
	<td>게시판에 저장된 글이 없습니다.</td>
</table>
<% } else { %>
<table border="1">
	<tr>
		<th id="num">번  호</th>
		<th id="subject">제  목</th>
		<th id="writer">작성자</th>
		<th id="regdate">작성일</th>
		<th id="readcount">조  회</th>
		<th id="filename">첨부파일</th>
	</tr>
<%
	for(int i=0; i < articleList.size(); i++){
		BoardDto dto = (BoardDto)articleList.get(i);
%>
	<tr> 
	<td><%= dto.getNum() %></td>
	<td class = "titled">
	<a href = "content.jsp?num=<%= dto.getNum() %>">
		<%= dto.getSubject() %></a>
		<% if(dto.getReadcount() >= 20){ %>
		<img src="images/hot.gif"><%} %></td>
	<td>
		<%= dto.getWriter() %></td>
	<td>
		<%= sdf.format(dto.getRegdate()) %></td>
	<td><%= dto.getReadcount() %></td>
	<td><% if(dto.getFilename() != null){ %>
		<img src="images/file.png" width="16" height="16" >
		<%= dto.getFilename() %>
		<% } %></td>
	</tr>
		<% } %>
</table>
</article>
<% } %>

</section>
</body>
</html>