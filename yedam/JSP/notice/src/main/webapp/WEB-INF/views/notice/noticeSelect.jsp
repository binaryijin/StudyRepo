<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div align="center">
	<div>
		<jsp:include page="../main/menu.jsp"/>
	</div>
	<div><h1>게시글 상세보기</h1></div>
	<div>
		<table border="1">
			<tr>
				<th width="70">순번</th>
				<td width="50" align="center">${notice.noticeId }</td>
				<th width="100">작성자</th>
				<td width="150" align="center">${notice.noticeWriter }</td>
				<th width="100">작성일자</th>
				<td width="150" align="center">${notice.noticeWdate }</td>
				<th width="100">조회수</th>
				<td width="70" align="center">${notice.noticeHit }</td>
			</tr>
			<tr>
				<th>제목</th>
				<td colspan="7">${notice.noticeTitle }</td>
			</tr>
			<tr>
				<th>내용</th>
				<td colspan="7">
					<textarea rows="10" cols="105">${notice.noticeSubject }</textarea>
				</td>
			</tr>
		</table>
	</div><br>
	<div>
		<c:if test="${name eq notice.noticeWriter}">
			<button type="button" onclick="callFunction('E')">수정</button>&nbsp;&nbsp;
			<button type="button" onclick="callFunction('D')">삭제</button>&nbsp;&nbsp;
		</c:if>
		<button type="button" onclick="location.href='noticeList.do'">목록</button>
	</div>
	<div>
		<jsp:include page="../main/footer.jsp"/>
	</div>
	<div>
		<form id="frm" method="post">
			<input type="hidden" id="noticeId" name="noticeId" value="${notice.noticeId }">
		</form>
	</div>
</div>
<script type="text/javascript">
	function callFunction(str){
		let frm = document.getElementById("frm");
		if(str == 'E'){
			frm.action = "noticeEdit.do";
		}else{
			frm.action = "noticeDelete.do";
		}
		frm.submit();
	}
</script>
</body>
</html>