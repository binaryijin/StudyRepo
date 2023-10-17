<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div align="center">
	<jsp:include page="../main/menu.jsp"></jsp:include>
	<div><h1>제품 목록 보기</h1></div>	
	<div>
		<table border="1">
			<thead>
				<tr>
					<th width="100">제품코드</th>
					<th width="200">제품명</th>
					<th width="200">제품이미지</th>
					<th width="200">이미지경로</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${products }" var="p">
					<tr>
						<td align="center">${p.productId }</td>
						<td align="center">${p.productName }</td>
						<td align="center">${p.productImage }</td>
						<td align="center">${p.productDir }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div><br>
	<div>
		<c:if test="${not empty id }">
			<button type="button" onclick="location.href='productInsertForm.do'">제품등록</button>
		</c:if>
	</div>
	<jsp:include page="../main/footer.jsp"></jsp:include>
</div>
</body>
</html>