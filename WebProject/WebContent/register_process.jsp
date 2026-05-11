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
		PrintWriter script=response.getWriter();
	
		
		if(user.getUserID() == null || user.getUserPW() == null){
			script.println("<script>");
			script.println("alert('아이디나 패스워드는 비워둘 수 없습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else{
			String passwordRegex = "^(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[@#$%^&+=!])(?=\\S+$).{6,16}$";
			if(!user.getUserPW().matches(passwordRegex)){
				script.println("<script>");
				script.println("alert('비밀번호는 6~16자이며, 숫자, 영어, 특수문자(@#$%^&+=!)를 최소 하나씩 포함해야 합니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else{
				dbconn dbconn = new dbconn();
				int regi_result = dbconn.register(user);
				
				if(regi_result == -1){
					script.println("<script>");
					script.println("alert('이미 존재하는 아이디입니다. 아이디는 겹칠 수 없습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
				else{
					session.setAttribute("userID",user.getUserID());
					script.println("<script>");
					script.println("location.href='main.jsp'");
					script.println("</script>");
				}
			}
		}

	%>
</body>
</html>