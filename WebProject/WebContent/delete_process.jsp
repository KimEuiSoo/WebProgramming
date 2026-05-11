<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.dbconn"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		dbconn db = new dbconn();
		
		String code = request.getParameter("id");
		int delete_res = db.PhotoDelete(code);
		PrintWriter script = response.getWriter();
		if (delete_res == 1) {
			script.println("<script>");
			script.println("location.href='main.jsp'");
			script.println("</script>");
		} else {
			script.println("<script>");
			script.println("alert('삭제 실패했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
</body>
</html>