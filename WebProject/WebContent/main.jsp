<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.sql.*, java.io.*"%>
<%@ page import="dto.Product"%>
<%@ page import="dto.ProductResponse"%>
<%@ page import="dao.dbconn"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>동연이의 사진모음집</title>
<style>
.mainBanner {
	width: 100%;
	height: 500px;
	margin-bottom: 20px;
}

.img {
	width: 200px;
	height: 200px;
	object-fit: cover;
	padding: 0px;
}

.photoCard {
	margin-top: 15px;
}

.photoCardName {
	margin-top: 5px;
}

.orderBtn {
	margin-left: 30px;
}

.latestOrder {
	font-size: 14px;
	min-width: 80px;
	background-color: #5981BE;
	color: #ffffff;
	border-radius: 50px;
	padding: 5px 10px;
	min-width: 80px;
}

.popularOrder {
	font-size: 14px;
	margin-left: 5px;
	min-width: 80px;
	background-color: #717171;
	color: #ffffff;
	border-radius: 50px;
	padding: 5px 10px;
	min-width: 80px;
}
</style>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<div class="mainBanner">
			<jsp:include page="mainBanner.jsp" />
	</div>
	<div class="container">
		<%
		dbconn db = new dbconn();
		try {
			List<ProductResponse> list = db.PhotoList("");
		%>
		<div class="orderBtn" id="orderBtn">
			<script>
				$(document).ready(function() {
					// 최신순 또는 인기순을 클릭할 때의 이벤트 처리
					$(".latestOrder, .popularOrder").on("click", function(e) {
						e.preventDefault();

						// 클릭된 링크의 href 속성값 가져오기
						var orderType = $(this).attr("href");

						// AJAX를 통해 서버에 데이터 요청
						$.ajax({
							url : "./order_process.jsp", // 요청할 서버의 URL
							type : "GET", // HTTP 요청 방식 (GET 또는 POST)
							data : {
								type : orderType
							}, // 서버로 보낼 데이터 (파라미터)
							dataType : "html", // 서버로부터 받아올 데이터 타입 (html, json 등)
							success : function(data) {
								// 서버로부터 받아온 데이터를 페이지의 특정 부분에 업데이트
								$(".row").html(data);
							},
							error : function(error) {
								console.error("Error:", error);
							}
						});
					});
				});
			</script>
			<a class="latestOrder" href="./order_process.jsp?type=latest">최신순</a>
			<a class="popularOrder" href="./order_process.jsp?type=popular">인기순</a>
		</div>
		<div class="row" align="center">
			<%
			int i = 0;
			while (i < list.size()) {
				ProductResponse card = list.get(i);
				i++;
			%>
			<div class="col-md-3">
				<div class="photoCard">
					<a href="./product.jsp?id=<%=card.getProductCode()%>"> <img
						class="img"
						src="data:image/jpeg;base64,<%=Base64.getEncoder().encodeToString(card.getImage())%>"
						alt="Product Image">
					</a>
					<div class="photoCardName">
						<%=card.getProductName()%>
					</div>
				</div>
			</div>
			<%
			}
			} catch (Exception e) {
			e.printStackTrace();
			}
			%>
		</div>
	</div>
	<jsp:include page="footer.jsp" />	
</body>
</html>