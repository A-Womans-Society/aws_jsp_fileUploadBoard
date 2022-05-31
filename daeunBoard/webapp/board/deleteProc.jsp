<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="daeunBoard.BoardDao" %>
<%@ page import="daeunBoard.BoardVo" %>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	BoardDao dbPro = BoardDao.getInstance();
	dbPro.delete(num);
	response.sendRedirect("list.jsp");
%>
