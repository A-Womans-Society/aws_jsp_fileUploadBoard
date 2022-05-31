<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="fileUpload.*"%>
<%
	BoardDao dao = BoardDao.getInstance();
int num = Integer.parseInt(request.getParameter("num"));
pageContext.setAttribute("dto", dao.detail(num));
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
<title>게시물 수정</title>
</head>
<body>
	<div class="container-fluid vh-100 d-flex align-items-center">
		<div class="row h-75 w-100">
			<div class="col-3"></div>
			<div class="col-6">
				<h2 style="text-align: center; margin-bottom: 20px;">게시물 수정</h2>
				<form class="h-75" action="editProc.jsp" method="post">
					<table class="table table-striped-columns h-100">
						<tr class="h-25 align-middle">
							<th scope="col">작성자</th>
							<td>${dto.getWriter() }</td>
						</tr>
						<tr class="h-25 align-middle">
							<th scope="col">비밀번호</th>
							<td><input type="password" name="pwd" class="w-100"
								placeholder="비밀번호를 입력하세요."></td>
						</tr>
						<tr class="h-50">
							<th scope="col" class="align-middle">내&nbsp;용</th>
							<td><textarea class="h-100 w-100" name="newContent">${dto.getContent() }</textarea></td>
						</tr>
						<tr class="align-middle">
							<th scope="col">첨부파일</th>
							<td>${dto.getFile() }</td>
						</tr>
					</table>
					<div class="d-flex justify-content-center">
						<input class="btn btn-outline-secondary w-50" type="submit"
							value="저장하기"> <input type="button"
							class="btn btn-outline-secondary w-50"
							onClick="window.location='list.jsp'" value="목록">
					</div>
					<input type="hidden" name="num" value="${dto.getNo() }">
				</form>
			</div>
			<div class="col-3"></div>
		</div>
	</div>
</body>
</html>