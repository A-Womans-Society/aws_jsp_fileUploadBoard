<%@page import="java.util.Iterator"%>
<%@ page import="board.BoardDTO"%>
<%@ page import="board.BoardDAO"%>
<%@ page import="utils.BoardPage"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	// DAO를 생성해 DB에 연결
	BoardDAO dao = new BoardDAO();
	
	// 사용자가 입력한 검색 조건을 Map에 저장
	Map<String, Object> param = new HashMap<String, Object>();
	String searchField = request.getParameter("searchField");
	String searchWord = request.getParameter("searchWord");
	if (searchWord != null) {
		param.put("searchField", searchField);
		param.put("searchWord", searchWord);
	}
	
	int totalCount = dao.selectCount(param); // 게시물 수 확인
	System.out.println("totalCount : " + totalCount);
	
	/*** 페이징 처리 start ***/
	// 전체 페이지 수 계산
	int pageSize = Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
	int blockPage = Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));
	int totalPage = (int)Math.ceil((double)totalCount / pageSize); // 전체 페이지 수
	param.put("pageSize", pageSize);
	param.put("blockPage", blockPage);
	param.put("totalPage", totalPage);

	System.out.println("totalPage : " + totalPage);

	
	// 전체 페이지 확인
	int pageNum = 1; // 기본값
	String pageTemp = request.getParameter("pageNum");
	if (pageTemp != null && !pageTemp.equals("")) {
		System.out.println("pageTemp : " + pageTemp);
		pageNum = Integer.parseInt(pageTemp); // 요청받은 페이지로 수정
	}
	param.put("pageNum", pageNum);

	
	// 목록에 출력할 게시물 범위 계산
	int start = (pageNum - 1) * pageSize + 1; // 첫 게시물 번호
	System.out.println("start : " + start);
	int end = pageNum * pageSize; // 마지막 게시물 번호
	System.out.println("end : " + end);

	param.put("start", start);
	param.put("end", end);
	/*** 페이지 처리 end ***/
	
	pageContext.setAttribute("param", param);

	List<BoardDTO> boardLists = dao.selectListPage(param); // 게시물 목록 받기
	pageContext.setAttribute("boardLists", boardLists);
	

	dao.close(); // DB 연결 닫기
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원제 파일첨부 게시판 - 게시글 목록</title>
	<style>a{text-decoration:none;}</style>
</head>
<body>
	<!-- 공통 링크 -->
	<jsp:include page="Link.jsp"/>
	<h1 align="center">개발공부 질의응답 게시판(QnA)</h1>
	
	<table align="center">
		<tr>
			<td>
				더 이상 500을 그만 보고 싶으시다구요??
				왜 에러가 나는건지 도저히 모르시겠다구요?? <br/>
				그렇다면 잘 오셨어요! 여기서 고민들을 나눕시다~ <br/>
				모든 글은 자유롭게 보실 수 있지만, 글쓰기를 하려면 <strong>로그인</strong>하셔야 합니다!
			</td>
		</tr>
	</table>
	<hr>
	<!-- 검색 폼 -->
	<form method="get">
		<table border="1" width="90%" align="center">
			<tr>
				<td align="center">
					<select name="searchField">
						<option value="title">제목</option>
						<option value="content">내용</option>
						<option value="memId">작성자 아이디</option>
					</select>
					<input type="text" name="searchWord"/>
					<input type="submit" value="검색"/>
				</td>
			</tr>
		</table>
	</form>
	
	<!-- 목록 테이블 -->
	<table border="1" width="90%" align="center">
		<tr>
			<th width="10%">No.</th>
			<th width="*">제목</th>
			<th width="15%">작성자 아이디</th>
			<th width="10%">조회수</th>
			<th width="15%">작성일</th>
			<th width="20%">첨부파일 미리 다운로드</th>
		</tr>
		<c:choose>
			<c:when test="${ empty boardLists }"> <!-- 게시물이 없을 때 -->
				<tr>
					<td colspan="6" align="center">
						등록된 게시물이 없습니다ㅠ_ㅠ
					</td>
				</tr>
			</c:when>
			<c:otherwise> <!-- 게시물이 있을 때 -->
				<c:forEach items="${ boardLists }" var="row" varStatus="loop">
				<tr align="center">
					<td> <!-- No. -->
						${ (param.pageNum-1) * param.blockPage + loop.count }
					</td>
					<td align="left"> <!-- 제목(링크) -->
						<a href="${pageContext.request.contextPath}/View.jsp?boardNum=${ row.boardNum }">${ row.title }</a>
					</td>
					<td>${ row.memId }</td> <!--작성자 아이디-->
					<td>${ row.visitcount }</td> <!--조회수 -->
					<td>${ row.postdate }</td> <!--작성일 -->
					<td> <!--첨부파일 미리 다운로드 -->
						<c:if test="${ not empty row.ofile }">
							<a href="${pageContext.request.contextPath}/Download.jsp?ofile=${ row.ofile }&sfile=${ row.sfile }&boardNum=${ row.boardNum }">[Download]</a>
						</c:if>
					</td>
				</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</table>
	
	<!-- 하단메뉴(바로가기, 글쓰기) -->
	<table border="1" width="90%" align="center">
		<tr align="center">
			<td>
				<%= BoardPage.pagingStr(totalCount, pageSize, blockPage, pageNum, request.getRequestURI()) %>
			</td>
			<td width="100">
				<button type="button" onclick="location.href='<%= request.getContextPath() %>/WriteForm.jsp';">글쓰기</button>
			</td>
		</tr>
	</table>
</body>
</html>