<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부서전체조회</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<style type="text/css">
	table, th, td{
		border : 1px solid black;
	}
</style>
</head>
<body>
	<button type="button" onclick="location.href='deptInsert'">등록</button>
	<table>
		<thead>
			<tr>
				<th>department_id</th>
				<th>department_name</th>
				<th>manager_id</th>
				<th>location_id</th>
				<th>Del</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${deptList }" var="dept">
				<tr onclick="location.href='deptInfo?departmentId=${dept.departmentId}'">
					<td>${dept.departmentId }</td>
					<td>${dept.departmentName }</td>
					<td>${dept.managerId }</td>
					<td>${dept.locationId }</td>
					<td><button type="button">Del</button></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<script>
		let msg = `${message}`;
		if(msg != null && msg !='') alert(msg);
		
		/*
		printMessage(`${result}`);
		
		function printMessage(msg) {
			if(msg == null || msg == '') return;
			alert(msg);
		}
		*/
		$('tbody > tr button[type="button"]').on('click', ajaxDeptDelete);
		
		function ajaxDeptDelete(e) {
			let deptId = $(e.currentTarget).parent().siblings().eq(0).text();

			$.ajax({
				url : 'deptDelete',
				type : 'post',
				data : { deptId : deptId }
			})
			.done( data => {
				//console.log(data)
				if( data == 'Success'){
					$(e.currentTarget).parent().parent().remove();
				}else{
					alert('해당 정보는 삭제되지 않았습니다.');
				}
			})
			.fail( reject => console.log(reject));
			
			e.stopPropagation();
		}
	</script>
</body>
</html>