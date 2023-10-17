<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div align = "center">
	<div>
		<jsp:include page="menu.jsp"></jsp:include>
	</div>

		<h1>Welcome to My Web Site</h1>
		<div>
			<img alt="배경화면" src="img/flower.jpg" width="1024">
		</div>
		<!--frontController에 가서 등록해야함-->
		<!-- 
		<a href = "noticeList.do">게시글 목록</a><br>
		<a href = "memberList.do">멤버 목록 보기</a><br>
		<a href = "memberLoginForm.do">로그인</a><br> 
		 -->
		
		<div>
			<jsp:include page="footer.jsp"></jsp:include>
		</div>
	</div>
</body>
</html>