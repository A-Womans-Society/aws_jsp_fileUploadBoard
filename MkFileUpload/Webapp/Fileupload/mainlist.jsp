<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="FileUpload.FileUploadDao"%>
<%@ page import="FileUpload.FileUploadDto"%>
<%@ page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>자료실</title>
<style>
body {
	text-align: center;
}
table{
	border: 1px solid #333;
	width: 500px;
	margin: auto;
}

</style>
</head>
<body>
	<h2>자 료 실</h2>
	<!-- 글 목록 (조회수)  -->
	<%
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	FileUploadDao upPro = FileUploadDao.getInstance();
	List<FileUploadDto> fileList = upPro.selectAll();
	request.setAttribute("fileList", fileList);
	%>
	<article>
		<table border="1">
			<tr>
				<th>NO.</th>
				<th>제목</th>
				<th>작성자</th>
				<th>파일이름</th>
				<th>내용</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
			<c:forEach var="file" items="${fileList}" varStatus="status">
				<tr>
					<td>${file.getNum()}</td>
					<td><a href="content.jsp?num=${file.getNum()}">${file.getTitle()}</a></td>
					<td>${file.getWriter()}</td>
					<td>${file.getFilename()}</td>
					<td>${file.getContent()}</td>
					<td>${file.getPostdate()}</td>
					<td>${file.getReadcount()}</td>
				</tr>
				<%-- 				<tr>
					<td width="5%">${file.getNum()}</td>
					<a href="content.jsp?num=${file.getNum()}">
						<td width="20%" ${file.getTitle()}></td>
					</a>
					<td width="5%" ${file.getWriter()}></td>
					<td width="30%" ${file.getFilename()}></td>
					<td width="20%">${file.getContent()}</td>
					<td width="10%">${file.getPostdate()}</td>
					<td width="10%">${file.getReadcount()}</td>
				</tr> --%>

				<%-- <c:if test = "${param. }" isEmpty () 쓰고 싶으면?
			제목 클릭하면 내용보이게 설정하기 넓이 조절 다시 설정하기--%>
			</c:forEach>
			<tr colspan="7">
				<td colspan="8">
					<div style="display: flex; justify-content: space-around;">
						<input type="button" value="파일올리기"
							onclick="javascript:location.href = 'uploadForm.jsp'" />
					</div>
				</td>
			</tr>
		</table>

	</article>
</body>
</html>
