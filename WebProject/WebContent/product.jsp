<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.sql.*, java.io.*" %>
<%@ page import="dto.Product" %>
<%@ page import="dto.ProductResponse" %>
<%@ page import="dao.dbconn" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>김동연 포토 카드 상세 정보</title>
</head>
<body>
	<jsp:include page="menu.jsp"/>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품 정보</h1>
		</div>
	</div>
	<%
		dbconn db = new dbconn();
		String id = request.getParameter("id");
		ProductResponse card = new ProductResponse();
		InputStream input = null;
		try {
			card = db.PhotoCard(id);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				db.dbclose();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
	%>
	<div class="container">
		<div class="row">
			<div class="col-md-6">
				<h3><%=card.getProductName() %></h3>
				<p><img src="data:image/jpeg;base64,<%=Base64.getEncoder().encodeToString(card.getImage())%>" alt="Product Image" class="img-thumbnail">
				<p><%=card.getDetailInfo() %>
				<p> <b>상품 코드 : </b><span class="badge badge-danger">
					<%=card.getProductCode() %></span>
					<p> <b>등록 날짜</b> : <%=card.getRegisterDate() %>
				<p> <a href="./download_process.jsp?id=<%=card.getProductCode() %>" class="btn btn-info"> 포토 카드 다운로드 &raquo;</a>
				<a href="./main.jsp" class="btn btn-secondary"> 김동연 포토 카드 목록 &raquo;</a>
				<%
					if(card.getUserId().equals(session.getAttribute("userID"))){
				%>
				<p> <a href="./delete_process.jsp?id=<%=card.getProductCode() %>" class="btn btn-info"> 포토 카드 삭제 &raquo;</a>
				<%
					}
				%>
			</div>
		</div>
	</div>
</body>
</html>