<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="dao" uri="/WEB-INF/tlds/el-functions.tld"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자료실</title>
</head>
<body>
	<c:set var="list" value="${dao:list() }"></c:set>
	<c:choose>
		<!-- data가 없을 경우 출력 -->
		<c:when test="${empty list}">
			<h1>목록이 없음</h1>
		</c:when>
		<c:otherwise>
			<table>
				<th>No</th>
				<th>Writer</th>
				<th>Content</th>
				<th>File</th>
				<c:forEach var="dto" items="${dao:list() }" varStatus="status">
					<tr>
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