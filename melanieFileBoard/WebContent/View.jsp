<%@ page import="board.BoardDTO"%>
<%@ page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	// 게시물 불러오기
	BoardDAO dao = new BoardDAO();
	String boardNum  = request.getParameter("boardNum");
	dao.updateVisitCount(boardNum);
	BoardDTO dto = dao.selectView(boardNum);
	dao.close();
	
	// 줄바꿈 처리
	dto.setContent(dto.getContent().replaceAll("\r\n", "<br/>"));
	
	// 게시물(dto) 저장 후 뷰로 포워드
	request.setAttribute("dto", dto);	
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원제 파일첨부 게시판 - 게시글 상세보기</title>
</head>
<body>
	<!-- 공통 링크 -->
	<jsp:include page="Link.jsp"/>
	<h2 align="center">${ dto.title }</h2>
	
	<table border="1" width="90%" align="center">
		<colgroup>
			<col width="15%"/> <col width="35%"/>
			<col width="15%"/> <col width="*"/>
		</colgroup>
		<!-- 게시글 정보 -->
		<tr>
			<td align="center">게시글 번호</td><td>${ dto.boardNum }</td>
			<td align="center">작성자 아이디</td><td>${ dto.memId }</td>
		</tr>
		<tr>
			<td align="center">작성일</td><td>${ dto.postdate }</td>
			<td align="center">조회수</td><td>${ dto.visitcount }</td>
		</tr>
		<tr>
			<td align="center">내용</td>
			<td colspan="3" height="100">${ dto.content }</td>
		</tr>
		
		<!--첨부파일 -->
		<tr>
			<td align="center">첨부파일</td>
			<td>
				<c:if test="${ not empty dto.ofile }">
					${ dto.ofile }
					<a href="Download.jsp?ofile=${ dto.ofile }&sfile=${ dto.sfile }&boardNum=${ dto.boardNum }">[다운로드]</a>
				</c:if>
			</td>
			<td align="center">다운로드수</td>
			<td>${ dto.downcount }</td>
		</tr>
		
		<!-- 하단 메뉴(버튼) -->
		<tr>
			<td colspan="4" align="center">
				<button type="button" onclick="location.href='EditForm.jsp?boardNum=${ param.boardNum }';">
					수정하기
				</button>
				<button type="button" onclick="location.href='DeleteProcess.jsp?boardNum=${ param.boardNum }';">
					삭제하기
				</button>
				<button type="button" onclick="location.href='List.jsp';">
					목록 바로가기
				</button>
			</td>
		</tr>
	</table>
</body>
</html>