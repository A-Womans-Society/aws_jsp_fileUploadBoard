<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="FileUpload.FileUploadDao"%>
<%@ page import="FileUpload.FileUploadDto"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>

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
	MultipartRequest multi = new MultipartRequest(request, //request 객체
	uploadFilePath, //서버 상의 실제 데이터
	uploadFileSizeLimit, //최대 업로드 파일크기
	encType, //인코딩 타입

	new DefaultFileRenamePolicy()); //똑같은 이름의 파일이 들어왔을 때 번호로 구분지어주는 것.
	String fileName = multi.getFilesystemName("uploadFile");
	// uploadFile 이름은 input태그의 name과 동일한 이름을 사용
	// 필요한게 뭐야? 제목, 작성자, 파일이름, 글내용, 작성일, 비밀번호, 조회수
	// 파일 이외 나머지 폼값 getParameter메서드로 받음.
	String num = multi.getParameter("num");
	String title = multi.getParameter("title");
	String writer = multi.getParameter("writer");
	//String filename = multi.getParameter("filename");
	String content = multi.getParameter("content");
	String pass = multi.getParameter("pass");
	String readcount = multi.getParameter("readcount");

	FileUploadDao upPro = FileUploadDao.getInstance();
	FileUploadDto dto = new FileUploadDto(num, title, writer, fileName, content, null, pass, readcount);
	upPro.insertFile(dto);

	//파일 목록 jsp로 리다이렉션 - 저장 성공이면 list로
	response.sendRedirect("mainlist.jsp");

} catch (Exception e) { // 실패하면 예외 발생 - main으로 포워드
	request.setAttribute("errorMessage", "파일 업로드 오류");
	//request.getRequestDispatcher("main.jsp").forward(request, response);
}
%>
