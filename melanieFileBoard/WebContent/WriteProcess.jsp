<%@ page import="java.io.IOException"%>
<%@ page import="board.BoardDAO"%>
<%@ page import="board.BoardDTO"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.io.File"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="./Login/IsLoggedIn.jsp" %>

<%
	// 파일 업로드 관련 처리
	String saveDirectory = application.getRealPath("/Uploads"); // 저장할 디렉터리
	int maxPostSize = Integer.parseInt(application.getInitParameter("maxPostSize")); // 파일 최대 크기(5MB)
	String encoding = "UTF-8"; // 인코딩 방식

	try {
		MultipartRequest mr = new MultipartRequest(request, saveDirectory, maxPostSize, encoding);
		
		// 다른 폼값 먼저 받기
		String memNum = session.getAttribute("userNum").toString();
		String memId = session.getAttribute("userId").toString();
		String title = mr.getParameter("title");
		String content = mr.getParameter("content");
		
		// DTO 생성하고 값 채우기
		BoardDTO dto = new BoardDTO();
		dto.setMemNum(memNum);
		dto.setMemId(memId);
		dto.setTitle(title);
		dto.setContent(content);
		
		if (mr.getFilesystemName("attachedFile") != null) { // 첨부파일 있다면
			// 새로운 파일명 생성
			String fileName = mr.getFilesystemName("attachedFile"); // 현재 파일 이름
			System.out.println(fileName);
	
			String ext = fileName.substring(fileName.lastIndexOf(".")); // 파일 확장자(.txt)
			System.out.println(ext);
			String now = new SimpleDateFormat("yyMMdd_HmsS").format(new Date());
			System.out.println(now);
	
			String newFileName = session.getAttribute("userId").toString() + "_" + now + ext; // 새로운 파일 이름("작성자_업로드일시.확장자")
			
			// 파일명 변경
			File oldFile = new File(saveDirectory + File.separator + fileName);
			File newFile = new File(saveDirectory + File.separator + newFileName);
			oldFile.renameTo(newFile);
			
			// 파일 관련 값 채우기
			dto.setOfile(fileName);
			dto.setSfile(newFileName);
		}
			
		// DAO를 통해 DB에 반영
		BoardDAO dao = new BoardDAO();
		int iResult = dao.insertBoard(dto);
		dao.close();
		
		if (iResult != 1) { // 게시글 등록 실패 시 
			JSFunction.alertBack("파일 업로드에 실패했습니다!ㅠㅠ", out);
		} else { // 게시글 등록 성공 시 게시판 목록으로 리다이렉션
			response.sendRedirect("List.jsp");			
		}
		
	} catch (IOException e) {
		JSFunction.alertBack("파일이 제한용량을 초과합니다!ㅠㅠ", out);
		e.printStackTrace();
	} catch (Exception e) {
		JSFunction.alertBack("파일 업로드에 실패했습니다!ㅠㅠ", out);
		e.printStackTrace();
	}

%>
