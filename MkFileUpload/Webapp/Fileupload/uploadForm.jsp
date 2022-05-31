<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>File Upload</title>
<style>
body {
	text-align: center;
}

section {
	margin: auto;
	text-align: center;
}

table {
	border: 2px solid #333;
	width: 500px;
	height: 100px;
	margin: auto;
	text-align: left;
}

.input {
	width: 200px;
	margin: auto;
	text-align: center;
}

.file {
	width: 150px;
	margin: auto;
}

.bt {
	width: 100px;
}
</style>
</head>
<body>
	<h3>FileUpload</h3>
	<section>
		<article>
			<form name="fileForm" method="post" enctype="multipart/form-data"
				action="uploadProc.jsp">
				<table>
					<tr>
						<td>작성자 : <input class="input" type="text" name="writer"
							placeholder="작성자 이름" required></td>
					</tr>
					<tr>
						<td>제목 : <input type="text" name="title"></td>
					</tr>
					<tr>
						<td>내용 :<textarea rows="3" class="input" name="content"
								placeholder="파일설명(100자이내)" maxlength="100" required></textarea></td>
					</tr>
					<tr>
						<td>첨부파일 : <input class="file" type="file" name="uploadFile"
							required></td>
					</tr>
					<tr>
					
						<td>비밀번호 : <input class="input" type="password" name="pass"
							placeholder="비밀번호(10자이내)"></td>
					</tr>
					
					<input type="hidden" name="readcount" value="0">
				
				</table>
				<br /> <input class="bt" type="submit" value="올리기" /> <input
					class="bt" type="button" value="목록"
					onclick='javascript:location.href="mainlist.jsp"'> <input
					type="hidden" name="postdate" value="">

			</form>
		</article>
	</section>
</body>
</html>