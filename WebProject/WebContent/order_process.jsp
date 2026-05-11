<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.sql.*, java.io.*"%>
<%@ page import="dto.Product"%>
<%@ page import="dto.ProductResponse"%>
<%@ page import="dao.dbconn"%>
<%
request.setCharacterEncoding("UTF-8");
String orderType = request.getParameter("type");
try {
	List<ProductResponse> list;

	dbconn db = new dbconn();

	list = db.PhotoList(orderType);
%>
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