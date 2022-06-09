<%@ page import="member.*" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 로그인 폼으로부터 받은 아이디와 패스워드
	String userId = request.getParameter("userId");
	String userPwd = request.getParameter("userPwd");
	
	// 회원 테이블 DAO를 통해 회원 정보 DTO 획득
	MemberDAO mdao = new MemberDAO();
	MemberDTO mdto = mdao.getMemberDTO(userId, userPwd);
	mdao.close();
	
	// 로그인 성공 여부에 따른 처리
	if (mdto.getMemId() != null) {
		// 로그인 성공  -> session 영역에 아이디와 고유번호 저장 후, 마이페이지로 이동
		session.setAttribute("userId", mdto.getMemId());
		session.setAttribute("userNum", mdto.getMemNum());
		response.sendRedirect("../MyPage.jsp");
	} else {
		// 로그인 실패 -> request 영역에 오류 메시지 저장 후, 로그인 페이지로 포워드
		request.setAttribute("LoginErrMsg", "로그인 오류입니다.");
		request.getRequestDispatcher("LoginForm.jsp").forward(request, response);
	}
%>