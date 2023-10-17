<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#topMenu { 
	height:30px; 
	width:100%; 
	background-color:#2d2d2d;
}

#topMenu ul li { 
	list-style:none; 
	color:white; 
	background-color:#2d2d2d;
	float:left;
	line-height:30px;
	vertical-align:middle;
	text-align:center;
	
}

#topMenu .menuLink {
	text-decoration:none;
	color:white;
	display:block; 
	width:150px;
	font-size:12px;
	font-weight:bold;
	font-family:"Trebuchet MS", Dotum, Arial;
}

#topMenu .menuLink:hover {
	color:red;
	background-color:#4d4d4d;	
}
</style>
</head>
<body>
	<div>
		<nav id="topMenu">
			<ul>
				<li><a class="menuLink" href="main.do">Home</a></li>
				<li><a class="menuLink" href="noticeList.do">Notice</a></li>
				<c:if test="${empty id }">
					<li><a class="menuLink" href="memberJoin.do">MemberJoin</a></li>
				</c:if>	
				<li><a class="menuLink" href="memberList.do">Member</a></li>
				<li><a class="menuLink" href="productList.do">제품관리</a></li>
				<li><a class="menuLink" href="#">보류</a></li>
				<c:if test="${empty id }">
				<li><a class="menuLink" href="memberLoginForm.do">Login</a></li>
				</c:if>
				<c:if test="${not empty id }">
				<li><a class="menuLink" href="memberLogout.do">Logout</a></li>
				</c:if>
				<c:if test="${not empty name }">
				<li><a class="menuLink" href="#">${name }님 로그인</a></li>
				</c:if>
			</ul>
		</nav>
	</div>
</body>
</html>