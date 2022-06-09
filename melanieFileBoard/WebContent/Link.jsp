<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<style>a{text-decoration:none;}</style>
</head>
<body>
<table border="1" width="100%">
	<tr>
		<td align="center" width="20"> <!-- 로그인 여부에 따른 메뉴 변화 -->
		<% if (session.getAttribute("userId") == null) { %>
			<a href="<%= request.getContextPath() %>/Login/LoginForm.jsp">[로그인]</a>
		<% } else { %> 
			<%= session.getAttribute("userId") %> 님, 반갑습니다!
			<a href="<%= request.getContextPath() %>/Login/Logout.jsp">[로그아웃]</a>
		<% } %>
		</td>
		<td align="center" width="40%"> <!-- 게시판 홈으로 가기 -->
			<a href="<%= request.getContextPath() %>/List.jsp">게시판 홈(Board HOME)</a>
		</td>
		<td align="center" width="40%"> <!-- 마이페이지로 가기 -->
			<a href="<%= request.getContextPath() %>/MyPage.jsp">마이페이지(My Page)</a>
		</td>
	</tr>
</table>
</body>
</html>
