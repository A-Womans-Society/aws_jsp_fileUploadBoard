<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "boardone.*" %>
<%@ page import = "java.io.File" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "com.oreilly.servlet.MultipartRequest" %>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>

<% request.setCharacterEncoding("UTF-8");%>
<% BoardDao dao = BoardDao.getInstance();
	BoardDto dto = new BoardDto(); 
%>

<%
	// 파일업로드 처리
	String uploadPath = "boardone/fileupload"; //다운받는 경로 설정
	int uploadFileSizeLimit = 5 * 1024 * 1024; //파일 최대크기 5M로 제한
	String encType = "UTF-8"; //char인코딩 방식
	
	//서버상의 실제 경로 설정
	ServletContext context = getServletContext();
	String uploadFilePath = context.getRealPath(uploadPath);
	//내가 확인해보고 싶은
	System.out.println("서버상의 실제 디렉터리");
	System.out.println(uploadFilePath);

	MultipartRequest multi = new MultipartRequest(request, uploadFilePath, uploadFileSizeLimit, encType, new DefaultFileRenamePolicy());
//	System.out.println(multi.getParameter("writer"));
	System.out.println("파일 업로드 완료");
	
	String writer = multi.getParameter("writer");
	String email = multi.getParameter("email");
	String subject = multi.getParameter("subject");	
	String pass = multi.getParameter("pass");	
	int readcount = 0;
	int ref = 1;
	int step = 0;
	int depth = 0;
	String content = multi.getParameter("content");	
	String filename = multi.getFilesystemName("uploadfile");
	
	dto.setWriter(writer);
	dto.setEmail(email);
	dto.setSubject(subject);
	dto.setPass(pass);
	dto.setReadcount(readcount);
	dto.setRef(ref);
	dto.setStep(step);
	dto.setDepth(depth);
	dto.setRegdate(new Timestamp(System.currentTimeMillis()));
	dto.setContent(content);
	dto.setFilename(filename);
	
	
	dao.insertArticle(dto);
	response.sendRedirect("list.jsp");
	
%>

