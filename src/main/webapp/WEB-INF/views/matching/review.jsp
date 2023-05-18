<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
	body {
		text-align:center;
		margin:auto;
	}
	div {
		display:inline-block;
	}
	
	a {
	  color : black;
	}
	
	a:link {
	  color : black;
	}
	a:visited {
	  color : black;
	}
	a:hover {
	 text-decoration-line: none;
	  color : #FFA500 ;
	}
	
</style>
</head>
<body>
 <br>
	<h2>당근농장 리뷰</h2>
	
		<form action="review.do?matchingIdx=${matchingIdx}" method="post" id="form" ">
			<input type="text" name="writerId" id="${loginId}" value="${loginId}" hidden> 
			<div style="border: 1px solid black; width:90%; height:70%;">
			<br/>
			<h3>MVP를 선택해주세요</h3>
			
			<select name="receiveId" id="receiveId">
				<option value="none">MVP</option>
				<c:forEach items="${playerList}" var="playerList">
					<option value="${playerList.userId}">${playerList.userId}</option>
				</c:forEach>
			</select>
			<br/><br/>
			<h3>경기 매너를 평가해주세요</h3>
			<div>
				<c:forEach items="${playerList}" var="playerList" varStatus="status">
				<c:if test="${playerList.userId ne loginId}">
					<c:if test="${status.index % 2 == 1}"> 
							<a href="#" onclick="window.open('../userprofilepop.go?userId=${playerList.userId}','회원프로필','width=400px,height=600px')">${playerList.userId}</a> 
							<input type="radio" name="${playerList.userId}" id="${playerList.userId}" value="0.1"> 👍
							<input type="radio" name="${playerList.userId}" id="${playerList.userId}" value="-0.1"> 👎
							</br>
					</c:if>
				</c:if>
				</c:forEach>
			</div>
			
			<div>
				<c:forEach items="${playerList}" var="playerList" varStatus="status">
				<c:if test="${playerList.userId ne loginId}">
					<c:if test="${status.index % 2 == 0}"> 
							| <a href="#" onclick="window.open('../userprofilepop.go?userId=${playerList.userId}','회원프로필','width=600px,height=400px')"> ${playerList.userId} </a>
							<input type="radio" name="${playerList.userId}" id="${playerList.userId}" value="0.1"> 👍
							<input type="radio" name="${playerList.userId}" id="${playerList.userId}" value="-0.1"> 👎
							</br>
					</c:if>
				</c:if>
				</c:forEach>
			</div>	
			</br>
			<button class="btn btn-outline-dark" onclick="subChk()" style="margin:10px;">제출</button>
	
		</div>	
		</form>
		
</body>
<script>
function subChk(){
	
	if($('#receiveId').val() == 'none'){
		alert('MVP를 선택해주세요.');
		return false;
	}else if($('#receiveId').val() == ''){
		alert('MVP를 선택해주세요.');
		return false;
	}
	
	if(!confirm('리뷰는 수정이 불가능합니다. \n리뷰를 제출하시겠습니까?')){
        return false;
    }

	$('#form').submit();
	
}
</script>
</html>