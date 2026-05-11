<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head><link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>포토카드 등록</title>
<style>
.registerBtn{
	width: 100px;
	margin-right: 85px;
}
</style>
</head>
<body>
	<jsp:include page="menu.jsp"/>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">포토카드 등록</h1>
		</div>
	</div>
	<div class="container">
		<form name="newProduct" action="./processAddProducts.jsp"
		class="form-horizontal" method="post" enctype="multipart/form-data">
			<div class="form-group row">
				<label class="col-sm-2">상품 코드</label>
				<div class="col-sm-3">
					<input type="text" name="productCode" class="form-control">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">상품명</label>
				<div class="col-sm-3">
					<input type="text" name="productName" class="form-control">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">등록일</label>
				<div class="col-sm-3">
					<input type="text" name="registerDate" class="form-control">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">상세 정보</label>
				<div class="col-sm-3">
					<textarea name="detailInfo" rows="2" cols="100"
					class="form-control"></textarea>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">이미지 등록</label>
				<div class="col-sm-3">
					<input type="file" name="fileName" class="form-control">
				</div>
			</div>
			<div class="form-group row">
				<div class="col-sm-offset-2 col-sm-10">
					<input class="btn btn-info registerBtn" type="submit" name="btn btn-primary" value="등록 &raquo;"></input>
					<a href="./main.jsp" class="btn btn-secondary"> 김동연 포토 카드 목록 &raquo;</a>
				</div>
			</div>
		</form>
	</div>
</body>
</html>