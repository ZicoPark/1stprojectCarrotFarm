<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<meta charset="UTF-8">
<title>🏀 당근농장</title>
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<style>
	body {
		text-align:center;
		margin:auto;
	}
	div {
		display:inline-block;
	}
</style>
</head>
<body>
	<br/>
	<h2>당근농장 리뷰</h2>
	<form action="teamReview.do" method="post" id="form">
		<input type="text" name="matchingIdx" value="${matchingIdx}" hidden />
		<input type="text" name="teamId" value="${teamIdx}" hidden />
		<h3>${yourTeamName} 팀에게 어울리는 리뷰를 골라 주세요</h3>
		<div style="border: 1px solid black; width:90%; height:50%; text-align:center; padding:10px;">
		</br>
		<div style="text-align:left; ">
			<c:forEach items="${tagList}" var="tagList" varStatus="status">
			<c:if test="${status.index % 2 == 0}"> 
				<input type="checkbox" name="${tagList.tagIdx}" value="${tagList.tagContent}"/>${tagList.tagContent} <br/>
			</c:if>
			</c:forEach>
		</div>
		<div style="text-align:left;">
			<c:forEach items="${tagList}" var="tagList" varStatus="status">
			<c:if test="${status.index % 2 == 1}"> 
				<input type="checkbox" name="${tagList.tagIdx}" value="${tagList.tagContent}"/>${tagList.tagContent} <br/>
			</c:if>
			</c:forEach>
		</div>
		</br></br>
		<button class="btn btn-outline-dark">제출</button>
		</div>
	</form>

</body>
<script>

</script>
</html>