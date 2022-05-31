<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="fileUpload.*"%>
<%@ page import="java.io.*"%>

<%
	BoardDao dao = BoardDao.getInstance();
int i = Integer.parseInt(request.getParameter("num"));
BoardDto dto = dao.detail(i);
pageContext.setAttribute("dto", dto);

String savePath = getServletContext().getRealPath("/fileUpload/upload");
String path = savePath + "\\" + dto.getFile();
pageContext.setAttribute("path", path);
File dir = new File(savePath);
String[] fileList = dir.list();
pageContext.setAttribute("fileList", fileList);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor"
	crossorigin="anonymous">
<link href="style.css" rel="stylesheet" type="text/css" />
<title>자세히 보기</title>
</head>
<body>
	<div class="container-fluid vh-100 d-flex align-items-center">
		<div class="row h-75 w-100">
			<div class="col-3"></div>
			<div class="col-6">
				<h2 style="text-align: center; margin-bottom: 30px;">게시물 보기</h2>
				<table class="table table-striped-columns h-75">
					<tr class="h-25 align-middle">
						<th scope="col">작성자</th>
						<td>${dto.getWriter() }</td>
					</tr>
					<tr class="h-50">
						<th scope="col" class="align-middle">내&nbsp;용</th>
						<td><textarea class="h-100 w-100" readonly>${dto.getContent() }</textarea></td>
					</tr>
					<tr class="h-25 align-middle">
						<th scope="col">첨부파일</th>
						<td><a
							href="${pageContext.request.contextPath}/fileUpload/upload/${dto.getFile() }"
							download>${dto.getFile() }</a></td>
					</tr>
				</table>
				<div class="d-flex justify-content-around">
					<button type="button" class="btn btn-outline-secondary w-50"
						onClick="window.location='list.jsp'">목록가기</button>
					<button type="button" class="btn btn-outline-secondary w-50"
						onClick="location.href='editForm.jsp?num=${dto.getNo()}'">수정하기</button>
					<button type="button" class="btn btn-outline-danger w-50"
						onClick="location.href='deleteForm.jsp?num=${dto.getNo()}'">삭제하기</button>
				</div>
			</div>
			<div class="col-3"></div>
		</div>

	</div>
</body>
</html>