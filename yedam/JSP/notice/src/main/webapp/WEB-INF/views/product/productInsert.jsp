<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div align="center">
	<jsp:include page="../main/menu.jsp"></jsp:include>
	<div><h1>제 품 등 록</h1></div>
	<img src="c:/temp/튤립.jpg">
	<div>
		<form id="frm" action="productInsert.do" method="post" enctype="multipart/form-data">
			<div>
				<table border="1">
					<tr>
						<th width="100">제품ID</th>
						<td width="100">
							<input type="text" id="productId" name="productId" required="required">
						</td>
					</tr>
					<tr>
						<th>제품명</th>
						<td>
							<input type="text" id="productName" name="productName" required="required">
						</td>
					</tr>
					<tr>
						<th>제품이미지</th>
						<td>
							<input type="file" id="pfile" name="pfile">
						</td>
					</tr>
				</table>
			</div><br>
			<div>
				<input type="submit" value="등록">&nbsp;&nbsp;
				<input type="reset" value="취소">&nbsp;&nbsp;
				<input type="button" value="목록" onclick="location.href='productList.do'">
			</div>
		</form>
	</div>
	<jsp:include page="../main/footer.jsp"></jsp:include>
</div>
</body>
</html>