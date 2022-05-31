<%@ page import="java.io.File"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="board.BoardDAO" %>
<%@ page import="board.BoardDTO" %>
<%@ page import="utils.JSFunction" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./Login/IsLoggedIn.jsp" %>
<%

	//String boardNum = request.getParameter("boardNum");
	//BoardDAO bdao = new BoardDAO();
	//BoardDTO bdto = bdao.selectView(boardNum);
	//request.setAttribute("bdto", bdto);
	
	// 1. 파일 업로드 처리	// 업로드 디렉터리의 물리적 경로 확인
	String saveDirectory = request.getServletContext().getRealPath("/Uploads");
	System.out.println("saveDirectory : " + saveDirectory);

	// 초기화 매개변수로 설정한 첨부파일 최대용량 확인
	int maxPostsize = Integer.parseInt(application.getInitParameter("maxPostSize"));
	String encoding = "UTF-8"; // 인코딩 방식

	// 파일 업로드
	MultipartRequest mr = new MultipartRequest(request, saveDirectory, maxPostsize, encoding);
// 	if (mr == null) { // 파일 업로드 실패
// 		JSFunction.alertBack(response, "첨부 파일이 제한 용량을 초과합니다.");
// 		return;
// 	}
	
	// 2. 파일 업로드 외 처리
	// 수정 내용을 매개변수에서 얻어옴
	String boardNum = mr.getParameter("boardNum");
	System.out.println("boardNum : " + boardNum);

	String prevOfile = mr.getParameter("prevOfile");
	System.out.println("prevOfile : " + prevOfile);
	
	String prevSfile = mr.getParameter("prevSfile");
	System.out.println("prevSfile : " + prevSfile);

	String memId = session.getAttribute("userId").toString();
	System.out.println("memId : " + memId);

	String title = mr.getParameter("title");
	System.out.println("title : " + title);

	String content = mr.getParameter("content");
	System.out.println("content : " + content);
	
	// DTO에 저장
	BoardDAO bdao = new BoardDAO();
	BoardDTO bdto = bdao.selectView(boardNum);
	// bdto.setBoardNum(boardNum);
	System.out.println("bdto.getMemNum(); " + bdto.getMemNum());
	System.out.println("bdto.getMemId(); " + bdto.getMemId());

	// bdto.setMemId(memId);
	bdto.setTitle(title);
	System.out.println("bdto.getTitle() 수정후 : " + bdto.getTitle());

	bdto.setContent(content);
	System.out.println("bdto.getContent() 수정후 : " + bdto.getContent());

	
	// 원본 파일명과 저장된 파일 이름 설정
	String fileName = mr.getFilesystemName("ofile");
	if (fileName != null) {
		// 첨부 파일이 있을 경우 파일명 변경
		// 새로운 파일명 생성
		String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
		String ext = fileName.substring(fileName.lastIndexOf("."));
		String newFileName = session.getAttribute("userId").toString() + "_" + now + ext;
		
		// 파일명 변경
		File oldFile = new File(saveDirectory + File.separator + fileName);
		File newFile = new File(saveDirectory + File.separator + newFileName);
		oldFile.renameTo(newFile);
		
		// DTO에 저장
		bdto.setOfile(fileName); // 원래 파일 이름
		bdto.setSfile(newFileName); // 서버에 저장된 파일 이름
		
		// 기존 파일 삭제
		File file = new File(saveDirectory + File.separator + prevSfile);
		if (file.exists()) {
			file.delete();
			System.out.println("삭제완료!!!!!!!!!!!");
		} else {
			System.out.println("기존파일 없음");
		}
	} else {
		// 첨부파일이 없으면 기존 이름 유지
		bdto.setOfile(prevOfile);
		bdto.setSfile(prevSfile);
	}
	
	// DB에 수정내용 반영
	//BoardDAO bdao = new BoardDAO();
	int result = bdao.updatePost(bdto);
	System.out.println("result : " + result);
	bdao.close();
	
	// 성공 or 실패?
	if (result == 1) { // 수정 성공
		JSFunction.alertLocation("수정이 완료되었습니다!", "View.jsp?boardNum=" + boardNum, out);
	} else { // 수정 실패
		JSFunction.alertBack("수정에 실패했습니다!", out);
	}	
%>
