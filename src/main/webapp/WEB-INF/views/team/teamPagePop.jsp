<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>🏀 당근농장</title>
	<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
	<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>    
	<script src="resources/js/twbsPagination.js" type="text/javascript"></script>

	<!-- 부트스트랩 JavaScript 파일 불러오기 -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">	
<style>
	
	table, th, td{
		padding: 20px;
		margin : 5px;
		text-align: center;
	}
	
	table{
		width: 100%;
		margin : 5px;
	}
	
	button{
		margin: 5px;
	}
	
	#inline{
		float: left;
		margin:0 20 5 0;
	}
</style>
</head>
<body>

	<div><h3 style=margin:10;>${team.teamMatchState}</h3></div> 
	<hr/>
	<table>
		<colgroup>
	         <col width="50%"/>
	         <col width="25%"/>
	         <col width="25%"/>
	     </colgroup>
		<tr>
			<th rowspan="6">
				<c:if test="${team.photoName eq null}">
					<img width="600" height="300" src="/photo/팀이미지.png"/>
				</c:if>
				<c:if test="${team.photoName ne null}">
					<img width="600" height="300" src="/photo/${team.photoName}"/>
				</c:if>
			</th>
			<th colspan="2" style="border-bottom: 1px solid black">${team.teamName}</th>			
		</tr>
		<tr>
			<th>매너점수</th>
			<td>${team.teamManner}</td>			
		</tr>
		<tr>
			<th>팀원 수</th>
			<td>${team.teamUser}</td>
		</tr>
		<tr>
			<th>활동 지역</th>
			<td>${team.gu}</td>
		</tr>
		<tr>
			<th>주 활동 시간</th>
			<td>${team.teamFavTime}</td>
		</tr>
		<tr>
			<th>선호 경기종목</th>
			<td id="teamFavNum"></td>
		</tr>		
	</table>
	<br/>
	<br/>
	<div style="width: 45%; height: 30%; margin-left: 4%; float: left; text-align: center;">
			<table>
				<tr>
					<th style="border-bottom: 1px solid black;">팀 소개글</th>
				</tr>
				<tr>
					<td>${team.teamIntroduce}</td>
				</tr>
			</table>
		</div>
		<div style="width: 45%; height: 30%; float: left; text-align: center; margin-left: 3%;">
			<table>
				<tr>
					<th style="border-bottom: 1px solid black;">경기리뷰</th>
				</tr>
			</table>
			<br/>
			<c:forEach items="${list}" var="team">
				<div style="display: inline; font-size:15;" class="alert alert-warning" role="alert">
					${team.tagContent}&nbsp;&nbsp;${team.tagCount}
				</div>&nbsp;&nbsp;
			</c:forEach>
		</div>
</body>
<script>
	if("${team.teamFavNum}" == '0'){
		$('#teamFavNum').text("상관없음");
	}else if("${team.teamFavNum}" == '3'){
		$('#teamFavNum').text("3:3");
	}else if("${team.teamFavNum}" == '5'){
		$('#teamFavNum').text("5:5");
	}
</script>
</html>