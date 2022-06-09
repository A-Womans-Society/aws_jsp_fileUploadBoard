<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>로그인</title>
</head>
<body>
	<jsp:include page="../Link.jsp"/>
	<h1 align="center">로그인하세요.</h1> 
	<%-- 내장 객체 영역에 LoginErrMsg 속성이 있는지 확인 후 그 내용 출력 --%>
	<span style="color: red; font-size: 1.2em;">
		<%= request.getAttribute("LoginErrMsg") == null ?
				"" : request.getAttribute("LoginErrMsg") %>
	</span>
	<% // session 영역에 사용자 아이디가 저장되어 있는지 확인 (null이면 로그아웃상태)
		if (session.getAttribute("userId") == null) {
	%>
	<script> <!-- 유효성 검사 함수  -->
		function validateForm(form) {
			if (!form.userId.value) {
				alert("아이디를 입력하세요.");
				return false;
			}
			if (form.userPwd.value == "") {
				alert("패스워드를 입력하세요.");
				return false;
			}
		}
	</script>
	
	<form action="LoginProcess.jsp" method="post" name="loginForm" onsubmit="return validateForm(this)">
	<table align="center">
		<tr>
			<td>아이디</td>
			<td><input type="text" name="userId" placeholder="id"/></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><input type="password" name="userPwd" placeholder="password"/></td>
		</tr>
		<tr align="center">
			<td colspan="2" align="center">
				<input type="submit" value="로그인"/>
				<input type="reset" value="초기화"/>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<hr>
				아직 회원이 아니신가요?<br/><a href="<%= request.getContextPath() %>/Login/JoinForm.jsp">회원가입하러가기</a>
			</td>
		</tr>
	</table>
	</form>
	
	<%
		} else { // 이미 로그인 되어있는 경우 실행
			response.sendRedirect("../MyPage.jsp");
		}
	%>
</body>
</html>