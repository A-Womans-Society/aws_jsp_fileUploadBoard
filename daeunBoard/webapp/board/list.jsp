<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="daeunBoard.BoardDao"%>
<%@ page import="daeunBoard.BoardVo"%>
<%@ page import="java.util.List"%>
<%
	int count = 0;
	List<BoardVo> list = null;
	BoardDao dbPro = BoardDao.getInstance();
	count = dbPro.counter();
	if (count > 0) {
		list = dbPro.listAll();
		for (BoardVo tmp : list){
			System.out.println(tmp);
		}
		request.setAttribute("list", list);
	}
	request.setAttribute("count", count);
%>
<html>
<head>
<title>listForm page</title>
</head>
<body>
	<h2 style="text-align: center">자 료 실</h2>
	<b>글 목록 (전체 글: ${count})</b>
	<table>
		<tr>
			<td><a href="writeForm.jsp">글쓰기</a></td>
		</tr>
	</table>
	<%
		if (count == 0) {
	%>
	<table>
		<tr>
			<td>게시판에 저장된 글이 없습니다.</td>
		</tr>
	</table>
	<%
		} else {
	%>
	<table border="1">
			<th>번 호</th>
			<th>작성자</th>
			<th>제 목</th>
			<th>내 용</th>
			<th>파 일</th>

	<c:forEach var="article" items="${list}">
		<tr>
			<td>${article.num}</td>
			<td>${article.writer }</td>
			<td><a href="content.jsp?num=${article.num}">${article.title }</a></td>
			<td>${article.content }</td>
			<td>${article.file }</td>
		</tr>
	</c:forEach>
	</table>
	
	<%
		}
	%>
</body>
</html>