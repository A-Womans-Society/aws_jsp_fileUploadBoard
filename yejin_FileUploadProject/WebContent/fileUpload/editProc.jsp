<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="fileUpload.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
	request.setCharacterEncoding("UTF-8");
BoardDao dao = BoardDao.getInstance();
int num = Integer.parseInt(request.getParameter("num"));
pageContext.setAttribute("num", num);
String pwd = request.getParameter("pwd");
String newContent = request.getParameter("newContent");
if (dao.edit(num, pwd, newContent)) {
	// if문 안되는 이유.... 아돈노....
%>
<script>
	alert("수정하였습니다.");
	location.href = "detail.jsp?num=${num}";
</script>
<%
	} else {
%>
<script>
	alert("저장에 실패하였습니다.");
	location.href = "detail.jsp?num=${num}";
</script>
<%
	}
%>
