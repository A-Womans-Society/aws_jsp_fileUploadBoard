<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%	String savePath = getServletContext().getRealPath("/upload");
	File dir = new File(savePath);
	String[] fileList = dir.list();
	pageContext.setAttribute("fileList", fileList);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>업로드 파일 다운로드</title>
<body>
<%-- 
<c:forEach var="file" items="${fileList}">
		<li>
		${file}
		<a href="${pageContext.request.contextPath}/upload/${file}">다운로드</a>
		<a href="${pageContext.request.contextPath}/upload/${file}" download>다운로드(download 속성)</a>
		</li>
	</c:forEach>
</body>--%>