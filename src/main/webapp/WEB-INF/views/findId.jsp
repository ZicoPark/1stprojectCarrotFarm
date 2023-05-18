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
		width:100%;
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
	<div class="card o-hidden border-0 shadow-lg my-5">

<div class="jumbotron">
  <h3> 아이디는 : </h3><br/>
  		<ul>
  			<c:forEach items="${user}" var="user">
  		  		<li>${user.userId} </li><br/>
  			</c:forEach>
  		</ul>
  	<h2>입니다</h2>
  <button type="button" class="btn btn-primary" onclick="location.href='/cf/login'">로그인페이지</button>
  <button type="button" class="btn btn-primary" onclick="location.href='/cf/'">메인페이지</button>
  
</div>
</body>
<script></script>
</html>