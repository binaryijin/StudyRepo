<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부서등록</title>
</head>
<body>
	<form action="deptInsert" method="post">
		<div>
			<label>department_name : <input type="text" name="departmentName" required></label>
		</div>
		<div>
			<label>manager_id : <input type="number" name="managerId"></label>
		</div>
		<div>
			<label>location_id : <input type="number" name="locationId"></label>
		</div>
		<button type="submit">등록</button>
		<button type="button" onclick="location.href='deptList'">목록</button>
	</form>
</body>
</html>