<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>  
<%@ page import="daeunBoard.BoardDao" %>    
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="article" class="daeunBoard.BoardVo" scope="page">
	<jsp:setProperty name="article" property="*"/>    
</jsp:useBean>  
<html>
<head>
<title>file Process</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String savePath = "/upload";
	int uploadFileSizeLimit = 5 * 1024 * 1024;
	String encType="UTF-8";
	String fileName=null;
	ServletContext context = getServletContext();
	String uploadFilePath = context.getRealPath(savePath);
	System.out.println("서버상의 실제 디렉터리");
	System.out.println(uploadFilePath);
	try {
		MultipartRequest multi = new MultipartRequest(
				request,
				uploadFilePath,
				uploadFileSizeLimit,
				encType,
				new DefaultFileRenamePolicy()
				);
        fileName = multi.getFilesystemName("uploadFile");

        String writer= multi.getParameter("writer");
		String content = multi.getParameter("content");
		String title = multi.getParameter("title");
		String uploadFile = fileName;
		
		//out.println(content+"<br>");
		//out.println(title+"<br>");
		//out.println(uploadFile+"<br>");
		//out.println(writer+"<br>");
		
		//insert
		BoardDao dbPro = BoardDao.getInstance();
		dbPro.insertArticle(title,content,uploadFile,writer);

		if(fileName == null) {
			System.out.println("파일 업로드 실패");
		}
		else {
		//send
			response.sendRedirect("list.jsp");
		}
	}catch(Exception e) {
		System.out.println("예외 발생 : " + e);
		e.printStackTrace();
	}
%>
</body>
</html>