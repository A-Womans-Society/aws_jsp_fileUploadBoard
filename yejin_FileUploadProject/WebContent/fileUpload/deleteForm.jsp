<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor"
	crossorigin="anonymous">
<title>게시물 삭제</title>
</head>
<body>
	<div class="container-fluid vh-100 d-flex align-items-center">
		<div class="row h-75 w-100">
			<div class="col-3"></div>
			<div class="col-6">
				<h2 style="text-align: center; margin-bottom: 20px;">게시물 삭제</h2>
				<form class="h-75" action="deleteProc.jsp" method="post">
					<table class="table">
						<tr class="w-100">
							<th class="text-center">비밀번호</th>
							<td><input type="text" class="w-100" name="pwd" placeholder="비밀번호를 입력하세요."></td>
						</tr>
					</table>
					<div class="d-flex justify-content-around">
						<input type="button" class="btn btn-outline-secondary w-25"
							onClick="window.location='list.jsp'" value="목록"> <input
							class="btn btn-outline-danger w-25" type="submit" value="삭제하기">
					</div>
				</form>
			</div>
			<div class="col-3"></div>
		</div>
	</div>
</body>
</html>