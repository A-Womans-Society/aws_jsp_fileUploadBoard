<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="dao" uri="/WEB-INF/tlds/el-functions.tld"%>
<%@ page import="fileUpload.BoardDto"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%
	request.setCharacterEncoding("UTF-8");
String savePath = "/fileUpload/upload";
int uploadFileSizeLimit = 5 * 1024 * 1024;
String encType = "UTF-8";

ServletContext context = getServletContext();
String uploadFilePath = context.getRealPath(savePath);

try {
	MultipartRequest multi = new MultipartRequest(request, uploadFilePath, uploadFileSizeLimit, encType,
	new DefaultFileRenamePolicy());
	request.setAttribute("writer", multi.getParameter("writer"));
	request.setAttribute("pwd", multi.getParameter("pwd"));
	request.setAttribute("content", multi.getParameter("content"));
	// name="file" 인 input file을 찾는다.
	String fileName = multi.getFilesystemName("file");
	if (fileName == null) {
		System.out.print("파일 업로드 실패");
	} else {
		// 경로 이동하면 될듯
		request.setAttribute("file", fileName);
	}
} catch (Exception e) {
	System.out.print("예외 발생 : " + e);
	e.printStackTrace();
}
%>
<c:set var="dto" value="<%=new BoardDto()%>" />
<c:set target="${dto }" property="author" value="${writer }" />
<c:set target="${dto }" property="pwd" value="${pwd }" />
<c:set target="${dto }" property="content" value="${content }" />
<c:set target="${dto }" property="file" value="${file }" />
<!-- if문 안에 redirect를 넣으면 안되는 이유는??? -->
${dao:upload(dto) }
<c:redirect url="/fileUpload/list.jsp"></c:redirect>


<%-- <c:set var="flag" value="${dao:upload(dto)}"/>
<c:if test="flag == true">
		<c:redirect url="/fileUpload/list.jsp"></c:redirect> --%>
<%-- </c:if>
 --%>
<%-- <c:choose>
	<c:when test="${dao:upload(dto)} ">
	</c:when>
	<c:otherwise>
		<c:out value="<script type='text/javascript'>alert(저장 실패);</script>"
			escapeXml="false" />
	</c:otherwise>
</c:choose>
 --%>