<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부서조회</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
</head>
<body>
	<form>
		<div>
			<label>department_id : <input type="number" name="departmentId" value="${deptInfo.departmentId }" readonly></label>
		</div>
		<div>
			<label>department_name : <input type="text" name="departmentName" value="${deptInfo.departmentName }"></label>
		</div>
		<div>
			<label>manager_id : <input type="number" name="managerId" value="${deptInfo.managerId }"></label>
		</div>
		<div>
			<label>location_id : <input type="number" name="locationId" value="${deptInfo.locationId }"></label>
		</div>
		<button type="submit">수정</button>
		<button type="button" onclick="location.href='deptList'">목록</button>
	</form>
	<script>
		let msg = `${message}`;
		if(msg != null && msg !='') alert(msg);
		
		/*
		let inputList = document.querySelectorAll('form input');
		
		let formObj = {};
		inputList.forEach(tag => {
			formObj[tag.name] = tag.value;
		});
		console.log(formObj);
		*/
	
		$('form').on('submit', ajaxUpdateDept);
		
		function ajaxUpdateDept(event) {
			event.preventDefault();
			
			let obj = serializeObject();
			
			$.ajax({
				url : 'deptUpdate',
				type : 'post',
				contentType : 'application/json',
				data : JSON.stringify(obj)
			})	
			.done( data => {
				//console.log(data);
				if(data != null && data['결과'] == 'Success'){
					alert('부서번호 : ' + data['부서번호'] + '의 정보가 수정되었습니다.');
				}else {
					alert('해당 부서 정보가 정상적으로 수정되지 않았습니다.');
				}
			})
			.fail(reject => console.log(reject));
		};

		function serializeObject() {
			let formData = $('form').serializeArray();
			
			let formObj = {};
			$.each(formData, function(idx, obj){
				formObj[obj.name] = obj.value;
			});
			return formObj;
		};
	</script>
</body>
</html>