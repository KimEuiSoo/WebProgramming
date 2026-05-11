<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<link rel = "stylesheet"
	href = "https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>회원가입</title>
</head>
<style>
	.button-spacing{
		margin-bottom: 10px;
	}
	
	body, html{
		width: 100%;
		margin: 0;
		margin-top: 5%;
		padding: 0;
		background-color: #80A1D4;
	}
	#login-container{
		display: flex;
  		min-height: 100vh;
	}
</style>

<body>
	<div id="login-container" class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top: 20px;">
				<form method="post" name = "frm" action="register_process.jsp">
					<h3 style="text-align:center;">회원가입</h3>
					<div class = "form-group">
						<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20">
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="비밀번호" name="userPW" maxlength="20">
					</div>
					<input type="submit" class="btn btn-primary form-control" value="회원가입">
				</form>
			</div>
		</div>
		</div>
</body>
</html>