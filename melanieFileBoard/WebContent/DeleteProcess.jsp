<%@ page import="java.io.File"%>
<%@ page import="board.BoardDTO"%>
<%@ page import="board.BoardDAO"%>
<%@ page import="utils.JSFunction"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String memId = session.getAttribute("userId").toString();
	String boardNum = request.getParameter("boardNum");
	BoardDAO bdao = new BoardDAO();
	BoardDTO bdto = bdao.selectView(boardNum);
	request.setAttribute("bdto",bdto);
	if (!bdto.getMemId().equals(memId)) { // 작성자 본인이 아니라면
		JSFunction.alertBack("작성자 본인만 삭제 가능합니다!", out);
		return;
	}
	
	int result = bdao.deletePost(boardNum); // 게시물 삭제
	bdao.close();
	if (result == 1) { // 게시물 삭제 성공 시 첨부파일도 삭제
		String saveFileName = bdto.getSfile();
		System.out.println("saveFileName : " + saveFileName);
		String sDirectory = request.getServletContext().getRealPath("/Uploads");
		System.out.println("sDirectory : " + sDirectory);

		File file = new File(sDirectory + File.separator + saveFileName);
		if (file.exists()) {
			file.delete();
			System.out.println("진짜 삭제됨 30줄");
		} else {
			System.out.println("파일없는거 실화?");
		}
	} 
	JSFunction.alertLocation(response, "삭제되었습니다!", "List.jsp");

%>