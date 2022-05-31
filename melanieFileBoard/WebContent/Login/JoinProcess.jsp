<%@page import="member.MemberDAO"%>
<%@page import="member.MemberDTO"%>
<%@page import="utils.JSFunction"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 폼값 받기
	String memId = request.getParameter("memId");
	String memPwd = request.getParameter("memPwd");
	
	// DTO 생성해서 폼값 세팅
	MemberDTO mdto = new MemberDTO();
	
	mdto.setMemId(memId);
	mdto.setMemPwd(memPwd);
	
	// DAO 생성해서 회원등록
	MemberDAO mdao = new MemberDAO();
	int iResult = mdao.insertMember(mdto);
	mdao.close();
	
	if (iResult == 1) { // 회원등록 성공 시
		session.setAttribute("memId", memId);
		JSFunction.alertLocation("가입이 완료되었습니다!", "../List.jsp", out);
	} else { // 회원등록 실패 시
		JSFunction.alertBack("회원가입에 실패하였습니다. 이미 계정이 있으신가요?", out);
	}
%>