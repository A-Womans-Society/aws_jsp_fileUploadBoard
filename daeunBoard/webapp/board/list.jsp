<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
		request.setAttribute("list", list);
	}
	request.setAttribute("count", count);
%>
<html>
<head>
<style>
body{ padding-top: 30px;
    width: 700px; 
    margin: auto;
    left:0; top:0; right:0; bottom:0;}
table{ width:700px;
    border-collapse:collapse;}
tr{ text-align:center;    
    border:1px solid #333;}
</style>
<title>list page</title>
</head>
<body>
	<h2 style="text-align: center">자 료 실</h2>
	<b>글 목록 (전체 글: ${count})</b>
	<table>
		<tr>
			<td  style="text-align:right;"><a href="writeForm.jsp">글쓰기</a></td>
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
			<th>작성일</th>
			<th>파일 이름</th>
			<th>조회수</th>
			

	<c:forEach var="article" items="${list}" varStatus="status">
			<tr style="cursor:pointer" onClick="location.href='content.jsp?num=${article.num}'">
			<td>${fn:length(list) - status.index}</td>
 			<td>${article.writer}</td>
			<td><a href="content.jsp?num=${article.num}">${article.title}</a></td>
			<td><fmt:formatDate value="${article.regDate}" pattern="yyyy-MM-dd HH:mm"/></td>
			<td>${article.file}</td>
			<td>${article.readCnt}</td>
			
		</tr>
	</c:forEach>
	</table>
	
	<%
		}
	
	%>
</body>
</html>