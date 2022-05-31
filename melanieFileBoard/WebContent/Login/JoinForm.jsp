<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원가입</title>
</head>
<body>
	<jsp:include page="../Link.jsp"/>
	<h1 align="center">회원가입</h1>
	
	<form action="JoinProcess.jsp" method="post">
		<table align="center" border="1">
		    <tr><td>아이디</td><td><input type="text" name="memId" required/> <input type="button" value="중복확인"/></td></tr>
		    <tr><td>암호(4자리 숫자)</td><td><input type="password" name="memPwd" required/></td></tr>
		</table>
		<table align="center">
		    <tr><td>
		    <input type="submit" value="가입하기"> 
		    <input type="reset" value="다시입력">
    		</td></tr>
		</table>
	</form>
</body>
</html>