<%@ page import="member.MemberDTO"%>
<%@ page import="member.MemberDAO"%>
<%@ page import="utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if (session.getAttribute("userId") == null) {
		JSFunction.alertLocation("로그인하신 후 마이페이지를 이용하실 수 있습니다!", "./Login/LoginForm.jsp", out);
		return;
	}

	String memId = session.getAttribute("userId").toString();
	MemberDAO mdao = new MemberDAO();
	MemberDTO mdto = mdao.getMemberDTO(memId);
	mdao.close();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>마이페이지(MyPage)</title>
</head>
<body>
	<!-- 공통 링크 -->
	<jsp:include page="Link.jsp"/>
	<h1 align="center"><%= memId %>님의 마이페이지</h1>
	<table align="center">
		<tr>
			<td>회원 고유번호</td>	
			<td><%= mdto.getMemNum() %></td>
		</tr>
		<tr>
			<td>회원 아이디</td>	
			<td><%= mdto.getMemId() %></td>
		</tr>
		<tr>
			<td>회원 가입일자</td>	
			<td><%= mdto.getMemRegidate() %></td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				▼ 아래 메뉴 중에서 선택하세요!
			</td>
		</tr>
		<tr>
			<td align="center">
				<a href="List.jsp?searchField=memId&searchWord=<%= session.getAttribute("userId").toString() %>">[내가 쓴 글 보기]</a>
			</td>
		</tr>
	</table>
</body>
</html>