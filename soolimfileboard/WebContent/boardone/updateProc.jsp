<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "boardone.*" %>

<% request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id="dto" scope="page" class="boardone.BoardDto">
	<jsp:setProperty name="dto" property="*"/>
</jsp:useBean>

<%
	BoardDao dao = BoardDao.getInstance();
	int check = dao.updateArticle(dto);
	
	if(check == 1){
%>
	<meta http-equiv="Refresh" content="0;url=list.jsp" >
<% } else {%>

<script>
	alert("비밀번호가 맞지 않습니다.");
	history.go(-1);
</script>
<%} %>
