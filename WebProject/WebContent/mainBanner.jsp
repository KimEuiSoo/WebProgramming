<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.sql.*, java.io.*"%>
<%@ page import="dto.Product"%>
<%@ page import="dto.ProductResponse"%>
<%@ page import="dao.dbconn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>Swiper demo</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1" />
<!-- Link Swiper's CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />

<!-- Demo styles -->
<style>
html, body {
	position: relative;
	height: 100%;
}

body {
	background: #eee;
	font-family: Helvetica Neue, Helvetica, Arial, sans-serif;
	font-size: 14px;
	color: #000;
	margin: 0;
	padding: 0;
}

.swiper {
	width: 100%;
	height: 100%;
}

.swiper-slide {
	text-align: center;
	font-size: 18px;
	background: #fff;
	display: flex;
	justify-content: center;
	align-items: center;
}

.swiper-slide img {
	display: block;
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.img-thumbnail{
  opacity: 0.7;
}

</style>
</head>

<body>

	<%
	dbconn db = new dbconn();
	try {
		List<ProductResponse> list = db.PhotoList("popular");
	%>
	<!-- Swiper -->
	<div class="swiper mySwiper">
		<div class="swiper-wrapper">

			<%
			int i = 0;
			while (i < 5) {
				ProductResponse card = list.get(i);
				i++;
			%>
			<div class="swiper-slide">
				<img src="data:image/jpeg;base64,<%=Base64.getEncoder().encodeToString(card.getImage())%>" alt="Product Image" class="img-thumbnail">
			</div>
			<%
			}
			} catch (Exception e) {
			e.printStackTrace();
			}
			%>
		</div>
		<div class="swiper-button-next"></div>
		<div class="swiper-button-prev"></div>
		<div class="swiper-pagination"></div>
	</div>

	<!-- Swiper JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>

	<!-- Initialize Swiper -->
	<script>
		var swiper = new Swiper(".mySwiper", {
			pagination : {
				el : ".swiper-pagination",
				type : "fraction",
			},
			navigation : {
				nextEl : ".swiper-button-next",
				prevEl : ".swiper-button-prev",
			},
		});
	</script>
</body>
</html>