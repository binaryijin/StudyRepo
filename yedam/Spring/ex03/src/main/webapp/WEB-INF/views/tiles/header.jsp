<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<link rel="canonical" href="https://getbootstrap.com/docs/5.3/examples/headers/">
<!-- Custom styles for this template -->
<link href="${pageContext.request.contextPath }/resources/headers.css" rel="stylesheet">
    
<div class="container">
    <header class="d-flex justify-content-center py-3">
      <ul class="nav nav-pills">
        <li class="nav-item"><a href="${pageContext.request.contextPath }/" class="nav-link active" aria-current="page">Home</a></li>
        <li class="nav-item"><a href="${pageContext.request.contextPath }/empList" class="nav-link">사원관리</a></li>
        <li class="nav-item"><a href="${pageContext.request.contextPath }/deptList" class="nav-link">부서관리</a></li>
      </ul>
    </header>
</div>