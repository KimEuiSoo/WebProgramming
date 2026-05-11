<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.dbconn" %>
<%@ page import="java.io.PrintWriter" %>

<%request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="dao.Account" scope="page"></jsp:useBean>

<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPW"/>
<html>
<head>
<meta charset="UTF-8">
<title>김동연 갤러리</title>
</head>
<body>
	<%
		String passwordRegex = "^(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[@#$%^&+=!])(?=\\S+$).{6,16}$";
		
		if(!user.getUserPW().matches(passwordRegex)){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호는 6~16자이며, 숫자, 영어, 특수문자(@#$%^&+=!)를 최소 하나씩 포함해야 합니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else{
			dbconn dbconn = new dbconn();
			int login_result = dbconn.login(user.getUserID(), user.getUserPW());
			
			PrintWriter script=response.getWriter();
			if(login_result == 1){
				session.setAttribute("userID",user.getUserID());
				script.println("<script>");
				script.println("location.href='main.jsp'");
				script.println("</script>");
			}
			else{
				script.println("<script>");
				script.println("alert('로그인에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}	
		}

	%>
</body>
</html>