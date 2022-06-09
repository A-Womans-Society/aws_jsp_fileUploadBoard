<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="fileUpload.*"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<jsp:useBean id="dto" class="fileUpload.BoardDto"></jsp:useBean>

<%
	/* multipart file upload */
request.setCharacterEncoding("UTF-8");
String savePath = "/fileUpload/upload";
int uploadFileSizeLimit = 5 * 1024 * 1024;
String encType = "UTF-8";

ServletContext context = getServletContext();
String uploadFilePath = context.getRealPath(savePath);
System.out.println("file save path : " + uploadFilePath);
BoardDao dao = BoardDao.getInstance();
try {
	MultipartRequest multi = new MultipartRequest(request, uploadFilePath, uploadFileSizeLimit, encType,
	new DefaultFileRenamePolicy());
	// name="file" 인 input file을 찾는다.
	String fileName = multi.getFilesystemName("file");

	dto.setWriter(multi.getParameter("writer"));
	dto.setPwd(multi.getParameter("pwd"));
	dto.setContent(multi.getParameter("content"));
	dto.setFile(fileName);
	if (fileName == null) {
		System.out.print("파일 업로드 실패");
	} else {
		// post upload
		dao.upload(dto);
		// 경로 이동
		response.sendRedirect("list.jsp");
	}
} catch (Exception e) {
	System.out.print("예외 발생 : " + e);
	e.printStackTrace();
}
%>
