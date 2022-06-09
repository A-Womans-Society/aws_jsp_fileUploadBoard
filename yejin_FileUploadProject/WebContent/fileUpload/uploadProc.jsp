<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%
	request.setCharacterEncoding("UTF-8");
String savePath = "/fileUpload/upload";
int uploadFileSizeLimit = 5 * 1024 * 1024;
String encType = "UTF-8";

ServletContext context = getServletContext();
String uploadFilePath = context.getRealPath(savePath);
System.out.println("서버상의 실제 디렉터리");
System.out.println(uploadFilePath);

try {
	MultipartRequest multi = new MultipartRequest(request, uploadFilePath, uploadFileSizeLimit, encType,
	new DefaultFileRenamePolicy());
	// name="file" 인 input file을 찾는다.
	String fileName = multi.getFilesystemName("file");
	if (fileName == null) {
		System.out.print("파일 업로드 실패");
	} else {
		// 경로 이동하면 될듯

	}
} catch (Exception e) {
	System.out.print("예외 발생 : " + e);
	e.printStackTrace();
}
%>