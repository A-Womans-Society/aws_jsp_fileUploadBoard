<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="FileUpload.FileUploadDao"%>
<%@ page import="FileUpload.FileUploadDto"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>upload process</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String savePath = "/Fileupload/upload"; //다운 받는 경로 설정
	int uploadFileSizeLimit = 5 * 1024 * 1024; // 파일 최대크기 5 로 제한
	String encType = "UTF-8"; //char 인코딩방식
	// 서버 상의 실제 경로 설정
	ServletContext context = getServletContext();
	String uploadFilePath = context.getRealPath(savePath);
	System.out.println("서버상의 실제 디렉터리");
	System.out.println(uploadFilePath);
	try {
		// 클래스 객체 생성
		MultipartRequest multi = new MultipartRequest(
				request, //request 객체
				uploadFilePath, //서버 상의 실제 데이터
				uploadFileSizeLimit, //최대 업로드 파일크기
				encType, //인코딩 타입
		new DefaultFileRenamePolicy()); //똑같은 이름의 파일이 들어왔을 때 번호로 구분지어주는 것.
		String fileName = multi.getFilesystemName("uploadFile");
		// uploadFile 이름은 input태그의 name과 동일한 이름을 사용한다.
		
		
	} catch (Exception e) {
		System.out.print("예외 발생 : " + e);
		e.printStackTrace();
	}
	%>
</body>
</html>