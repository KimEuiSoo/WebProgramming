<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@ page import="dto.Product" %>
<%@ page import="dao.dbconn" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	
	String filename = "";
	String realFolder = "C:\\upload";
	int maxSize = 5*1024*1024;
	String encType = "utf-8";
	
	try{
		MultipartRequest multi = new MultipartRequest(request,realFolder,5*1024*1024,"utf-8",new DefaultFileRenamePolicy());
		
		String productCode = multi.getParameter("productCode");
		String productName = multi.getParameter("productName");
		String registerDate = multi.getParameter("registerDate");
		String detailInfo = multi.getParameter("detailInfo");
	
		Enumeration files = multi.getFileNames();
		String fname = (String) files.nextElement();
		String fileName = multi.getFilesystemName(fname);
		
		filename=realFolder+"\\"+fileName;
		
		Product photoCard = new Product();
		photoCard.setUserId((String)session.getAttribute("userID"));
		photoCard.setProductCode(productCode);
		photoCard.setProductName(productName);
		photoCard.setRegisterDate(registerDate);
		photoCard.setDetailInfo(detailInfo);
		photoCard.setFileName(filename);
		
		dbconn db = new dbconn();
		int insert = db.productRegister(photoCard);

		PrintWriter script=response.getWriter();
		if(insert == 1){
			script.println("<script>");
			script.println("location.href='main.jsp'");
			script.println("alert('등록에 성공했습니다.')");
			script.println("</script>");
		}
		else{
			script.println("<script>");
			script.println("alert('등록 실패했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
	}catch(Exception e){
		e.printStackTrace();
	}
%>
</body>
</html>