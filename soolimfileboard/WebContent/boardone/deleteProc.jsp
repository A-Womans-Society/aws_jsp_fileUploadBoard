<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "boardone.*" %>

<% request.setCharacterEncoding("UTF-8");%>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pass = request.getParameter("pass");
	BoardDao dao = BoardDao.getInstance();
	int check = dao.deleteArticle(num, pass);
	if(check == 1){

%>
	<meta http-equiv="Refresh" content="0;url=list.jsp" >
<% } else {%>

<script>
	alert("비밀번호가 맞지 않습니다.");
	history.go(-1);
</script>
<%} %>
