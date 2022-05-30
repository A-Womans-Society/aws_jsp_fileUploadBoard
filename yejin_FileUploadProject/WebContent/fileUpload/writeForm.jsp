<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 올리기</title>
</head>
<body>
	<section>
		<form action="writeProc.jsp" method="post" name="writeForm"
			enctype="multipart/form-data">
			<table class="board">
				<tr>
					<td class="attr">작성자</td>
					<td><input type="text" name="writer" size="30" required /></td>
				</tr>
				<tr>
					<td class="attr">비밀번호</td>
					<td><input type="password" name="pwd" maxlength="10" size="30"
						placeholder="10자 이내의 비밀번호를 입력하세요." required /></td>
				</tr>
				<tr>
					<td class="attr">파일 설명</td>
					<td><textarea name="content" rows="13" cols="50" required></textarea></td>
				</tr>
				<tr>
					<td class="attr">파일 선택</td>
					<td><input type="file" name="file" required></td>
				</tr>
				<tr>
					<td colspan="2" class="attr"><input type="submit"
						value="upload" /> <input type="reset" value="reset" /> <input
						type="button" value="list" onClick="window.location='index.jsp'"></td>
				</tr>
			</table>
		</form>
	</section>
</body>
</html>