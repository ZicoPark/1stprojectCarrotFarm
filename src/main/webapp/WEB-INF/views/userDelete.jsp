<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>
<script src = "https://code.jquery.com/jquery-3.6.4.min.js"></script>

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
		width:78%;
		background-color: #f8f9fa;
		padding: 10 30 10;
		margin : 5px;
		float:right;
		
	}
	
	#LNB {
		width:20%;
		height : 83%;
		background-color: #f8f9fa;
		float:left;
		margin : 5px;
		font-weight: bold;
        font-size: 18px;
		text-align:center;
		
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
<div style="float: right;">
	<jsp:include page="loginBox.jsp"></jsp:include>
</div>

<jsp:include page="GNB.jsp"></jsp:include>

<div id="LNB">
      <br/><br/>
	<img width="200" height="200" src="/photo/${loginPhotoName}">
	<br/><br/>
         <a href="/cf/userinfo.go">회원 정보</a>
         <br/><br/>
         <a href="/cf/userprofile.go">회원 프로필</a>
         <br/><br/>
         <a href="/cf/userNoticeAlarm">알림</a>
         <br/><br/>
         <a href="/cf/allgames">참여 경기</a>
         <br/><br/>
         <a href="/cf/mygames">리뷰</a>
         <br/><br/>
   </div>


<div id="content" >
<h3>회원 탈퇴 하시겠습니까?</h3>
<div>- 회원 탈퇴 후 3일 동안은 재가입이 불가능 합니다.</div>
<div>- 탈퇴 시 계정의 모든 정보는 삭제되며, 재가입 시에는 복귀되지 않습니다.</div>
<button class="btn btn-outline-dark" onclick="location.href='userdelete.do'">예</button>
<button class="btn btn-outline-dark" onclick="location.href='/cf/'">아니요</button>

</div>
</body>
<script></script>
</html>