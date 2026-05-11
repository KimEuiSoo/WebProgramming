<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="dao.dbconn" %>

<%
	request.setCharacterEncoding("UTF-8");
	String code = request.getParameter("id");
	dbconn db = new dbconn();
	int res = db.PhotoCardDownload(code, response);
%>