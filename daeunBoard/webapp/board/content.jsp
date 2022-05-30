<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="daeunBoard.BoardDao" %>
<%@ page import="daeunBoard.BoardVo" %>
<!DOCTYPE html>
<html>
<head>
<title>Content page</title>
</head>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	BoardDao dbPro = BoardDao.getInstance();
	BoardVo article = dbPro.listOne(num);
	request.setAttribute("article", article);
%>
<body>
<b>글 내용 보기</b>
<br/>
<form>
	<table>
		<tr>
			<th>글 번호</th>
			<td>${article.getNum()}</td>
			<th>작성자</th>
			<td>${article.writer }</td>
	</table>
</form>
</body>
</html>