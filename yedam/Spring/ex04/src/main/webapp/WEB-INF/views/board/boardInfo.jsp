<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table>
		<tr>
			<th>번호</th>
			<td>${boardInfo.bno }</td>
		</tr>
		<tr>
			<th>제목</th>
			<td>${boardInfo.title }</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>${boardInfo.writer }</td>
		</tr>
		<tr>
			<th>내용</th>
			<td><textarea rows="3"
						  cols="2"
						  style="width: 100px;"
						  readonly>
				${boardInfo.contents }
				</textarea>
			</td>
		</tr>
		<tr>
			<th>첨부이미지</th>
			<!-- <td><img src='${pageContext.request.contextPath }/resources/${boardInfo.image }'></td> -->
			<c:choose>
				<c:when test="${not empty boardInfo.image }">
					<td><img src='<c:url value="/resources/${boardInfo.image }"/>' style="width: 200px;"></td>
				</c:when>
				<c:otherwise>
					<td>파일없음</td>
				</c:otherwise>
			</c:choose>
		</tr>
		<tr>
			<th>작성일</th>
			<td><fmt:formatDate value="${boardInfo.regdate }" pattern="yyyy/MM/dd" /></td>
		</tr>
	</table>
	<button type="button" onclick="location.href='boardUpdate?bno=${boardInfo.bno}'">수정</button>
	<button type="button" onclick="location.href='boardDelete?bno=${boardInfo.bno}'">삭제</button>
</body>
</html>