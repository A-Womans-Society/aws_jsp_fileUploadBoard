<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="fileUpload.*"%>
<%
	BoardDao dao = BoardDao.getInstance();
pageContext.setAttribute("list", dao.list());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자료실</title>
</head>
<body>
	<c:choose>
		<c:when test="${empty list}">
			<h1>목록이 없음</h1>
		</c:when>
		<c:otherwise>
			<table border="1">
				<tr>
					<th>No</th>
					<th>Writer</th>
					<th>Content</th>
					<th>File</th>
				</tr>
				<c:forEach var="dto" items="${list}" varStatus="status">
					<tr style="cursor: pointer;"
						onClick="location.href='detail.jsp?num=${dto.getNo()}'">
						<td>${status.count}</td>
						<td>${dto.getWriter() }</td>
						<td>${dto.getContent() }</td>
						<td>${dto.getFile() }</td>
					</tr>
				</c:forEach>
			</table>
		</c:otherwise>
	</c:choose>
</body>
</html>
<%-- 						<a href="detail.jsp?num=${dto.getNo()}&pageNum=1">
		onclick="location.href='detail.jsp?num=13&pageNum=1'"
		onclick="location.href='detail.jsp?num=14&pageNum=1'"
						</a> --%>