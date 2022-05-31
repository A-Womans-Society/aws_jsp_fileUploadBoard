<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="FileUpload.FileUploadDao"%>
<%@ page import="FileUpload.FileUploadDto"%>
<%@ page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	//<c:if test ="${param.">
int num = Integer.parseInt(request.getParameter("num"));
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
FileUploadDao upPro = FileUploadDao.getInstance();
FileUploadDto upDto = upPro.getArticle(num);
request.setAttribute("content", upDto); // pagecontext.setAttribute는?
// EL태그는 set설정 , "이름 ", 값
// private 경우 getnum() 으로 불러오기
// 이름으로 el 태그 이름.---으로 작성
System.out.println(upDto);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FileUpload content</title>
<style>

</style>
</head>
<body>
	<h2>파일 업로드 정보</h2>
	<article>
		<table border="1">
			<tr>
				<th>No.</th>
				<th>제목</th>
				<th>작성자</th>
			</tr>
			<tr>
				<td>${content.getNum() }</td>
				<td>${content.getTitle() }</td>
				<td>${content.getWriter() }</td>
			</tr>
			<tr>
				<th>파일 업로드 내용</th>
				<td>${content.getContent()}</td>
			</tr>
			<tr>
				<th>파일명</th>
				<th>조회수</th>
			</tr>
			<tr>
				<td>${content.getFilename()}</td>
				<td>${content.getReadcount() }</td>
			</tr>
			<%--${article.content} --%>
			<tr colspan="3">
				<td colspan="4">
					<div style="display: flex;justify-content: space-around;">
						<input type="button" value="글수정"
							onclick="document.location.href ='updateForm.jsp?num=${content.getNum() }">
						<input type="button" value="글삭제"
							onClick="document.location.href='deleteForm.jsp?num=${content.getNum() }">
						<input type="button" value="목록"
							onclick="document.location.href='mainlist.jsp'">
					</div>
				</td>
			</tr>
		</table>
	</article>

</body>
</html>