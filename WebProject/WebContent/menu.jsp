<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="font.css">
<title>Insert title here</title>
<style>
.header-box {
	width: 100%;
	height: 70px;
	background-color: #80A1D4;
	display: flex;
	justify-content: center;
	flex-direction: row;
	position: sticky;
	top: 0;
	left: 0;
	right: 0;
	z-index: 998;
}

.headerNav {
	display: flex;
	width: 1080px;
	align-items: center;
	justify-content: space-between;
}

.login {
	min-width: 10px;
	background-color: white;
	color: #80A1D4;
	height: fit-content;
	border-radius: 5px;
	padding: 5px 10px;
	margin-left: 15px;
}

.signUp {
	min-width: 10px;
	background-color: white;
	color: #80A1D4;
	height: fit-content;
	border-radius: 5px;
	padding: 5px 10px;
	margin-left: 5px;
}

body .headerTitle {
	font-size: 24px;
	color: #ffffff;
	font-family: "NanumSquareR", sans-serif;
	font-weight: 'bold';
}

.userHello {
	color: #ffffff;
}
</style>
</head>
<body>
	<nav class="header-box">
		<div class="headerNav">
			<a class="headerTitle" href="./main.jsp">DreamGallery</a>
			<%
			if (session.getAttribute("userID") == null) {
			%>
			<div>
				<a class="login" href="./login.jsp" role="button">로그인</a> <a
					class="signUp" href="./register.jsp" role="button">회원가입</a>
			</div>
			<%
			} else {
			%>
			<div>
			<span class="userHello"><%=session.getAttribute("userID")%>
				님
			</span> <a class="login" href="./AddProduct.jsp" role="button">사진 등록</a> <a
				class="signUp" href="./logout_process.jsp" role="button">로그아웃</a>
			</div>
			<%
			}
			%>
		</div>
	</nav>
</body>
</html>