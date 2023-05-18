<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>

<!-- 부트스트랩 JavaScript 파일 불러오기 -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<style>
	body{
		position:relative;
		font-size:15px;
		padding : 10px;
		min-width: 1200px;
	}
	
	#content {
		width:50%;
		padding: 10 30 10;
		margin-left : 600px;
		margin-top : 200px;
		float:inherit;
		
	}
	
	
	a {
	  color : balck;
	}
	
	a:link {
	  color : balck;
	}
	a:visited {
	  color : black;
	}
	a:hover {
	 text-decoration-line: none;
	  color : #FFA500 ;
	}
	
	.pagination .page-link {
  		color: gray; /* 기본 글자색을 검정색으로 지정 */
	}

	.pagination .page-item.active .page-link {
 		background-color: #FFA500;
 		border:none;
	}
</style>
</head>
<body>
	<jsp:include page="GNB.jsp"></jsp:include>
	<br><br><br><br>
	<div class="text-center">
 <h2 class="h4 text-gray-900 mb-2">아이디 찾기</h2>
 <p class="mb-4">이메일을 입력해주세요!</p>
 </div>
<form class="user" action="/cf/findId" method="POST">
<div class="form-group">
<input type="email" class="form-control form-control-user"
id="email" aria-describedby="emailHelp" name="email"
 placeholder="Enter Email Address...">
</div>
<a href="/cf/login" style="display: inline;">[로그인 페이지]</a> <a href="/cf/" style="display: inline;">[메인페이지]</a>
<button style="float: right;" class="btn btn-outline-dark" type="submit">
Find ID
</button>
</form>


</body>
<script>
	var msg = "${msg}";
	
	if (msg != "") {
		alert(msg);
	}
</script>
</html>