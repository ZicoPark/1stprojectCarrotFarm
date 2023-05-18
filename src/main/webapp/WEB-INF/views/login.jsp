<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>🏀 당근농장</title>
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
	
	#loginBack{
		background-image: url(/photo/로그인배경.jpg);
            background-repeat: no-repeat;
            background-size: cover;
	}
	
	#content {
		width:100%;
		padding: 10 30 10;
		margin-left : 780px;
		margin-top : 250px;
		float:inherit;
		
	}
	
	button {
		margin: 5px;
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
<div id="loginBack">
	<jsp:include page="GNB.jsp"></jsp:include>
	
	<div id="content" >
	<h3>로그인</h3>
	<table>
		<tr>
			<th>아이디</th>
			<td><input type="text" id="userId"/></td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td><input type="password" id="userPw"/></td>
		</tr>
		<tr>
			<th colspan="2">
				<button class="btn btn-outline-dark" onclick="login()">로그인</button>
				<button class="btn btn-outline-dark" onclick="location.href='join'">회원 가입</button>
				<button class="btn btn-outline-dark" onclick="location.href='findIdView'">ID 찾기</button>
				<button class="btn btn-outline-dark" onclick="location.href='findpw.go'">PW 찾기</button>
			</th>
		</tr>
	</table>
	</div>
	<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
	<div></div>
	</div>
</body>
<script>
function login(){
	
	console.log('id','pw');
	$.ajax({
		type:'post',
		url:'login.ajax',
		data:{
			id:$('#userId').val(),
			pw:$('#userPw').val()
		},
		dataType:'json',
		success:function(data){
			console.log(data);
			if(data.user != null){
				alert('로그인에 성공 했습니다.');
				location.href='/cf/';
			}else{
				alert('아이디 또는 비밀번호를 확인해 주세요!');
			}			
		},
		error:function(e){
			console.log(e);
			alert('아이디 또는 비밀번호를 확인해 주세요!');
		}		
	});

}

</script>
</html>