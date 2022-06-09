<%@ page import="utils.JSFunction"%>
<%@ page import="board.BoardDTO"%>
<%@ page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String boardNum = request.getParameter("boardNum");
	BoardDAO bdao = new BoardDAO();
	BoardDTO bdto = bdao.selectView(boardNum);
	request.setAttribute("bdto",bdto);
	if (!bdto.getMemId().equals(session.getAttribute("userId"))) { // 작성자 본인이 아니라면
		JSFunction.alertBack("작성자 본인만 삭제 가능합니다!", out);
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>파일 첨부평 게시판</title>
</head>
<body>
	<!-- 공통 링크 -->
	<jsp:include page="Link.jsp"/>
	<h1 align="center">게시물 수정하기</h1>
	<form name = "writeFrm" method="post" enctype="multipart/form-data" action="EditProcess.jsp">
		<input type="hidden" name="boardNum" value="${ bdto.boardNum }"/>
		<input type="hidden" name="prevOfile" value="${ bdto.ofile }" />
		<input type="hidden" name="prevSfile" value="${ bdto.sfile }" />
	
	<table border="1" width="90%" align="center">
		<tr>
			<td align="center">작성자</td>
			<td>${ bdto.memId }</td>
		</tr>
		<tr>
			<td align="center">제목</td>
			<td><input type="text" name="title" style="width:90%;" value="${ bdto.title }" required/></td>
		</tr>
		<tr>
			<td align="center">내용</td>
			<td><textarea name="content" style="width:90%;height:100px;" required>${ bdto.content }</textarea></td>
		</tr>
		<tr>
			<td align="center">첨부 파일</td>
			<td><input type="file" name="ofile"/></td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<button type="submit">작성 완료</button>
				<button type="reset">초기화</button>
				<button type="button" onclick="location.href ='List.jsp';">목록 바로가기</button>
			</td>
		</tr>
	</table>
	</form>
</body>
</html>