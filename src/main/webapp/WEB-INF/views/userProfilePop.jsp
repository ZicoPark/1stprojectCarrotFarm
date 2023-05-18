<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>🏀 당근농장</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<style>
	
</style>
</head>
<body>
	<h3>회원 프로필</h3>
	
	<div id="inline">
		<img width="200" src="/photo/${profileInfo.photoName}"/>
	</div>
	
	<div class="tableGab">
		<table id="infoTable">
			<tr>
				<th>닉네임</th>
				<td>${profileInfo.nickName}</td>
			</tr>
			<tr>
				<th>키</th>
				<td>${profileInfo.height}</td>
			</tr>
			<tr>
				<th>포지션</th>
				<td>${profileInfo.position}</td>
			</tr>
			<tr>
				<th>선호 지역</th>
				<td>${profileInfo.gu}</td>
			</tr>
			<tr>
				<th>선호 시간</th>
				<td>${profileInfo.favTime}</td>
			</tr>
			<tr>
				<th>매너 점수</th>
				<td>${mannerPoint}</td>
			</tr>
	
			
		</table>
		</div>
		
		<div class="tableGab">
		<table style="width:65%;">
		<colgroup>
        <col style="width:15%;">
        <col style="width:50%;">
        <col style="width:20%;">
        <col style="width:15%;">
    </colgroup>
			<tr>
				<th colspan="4" style="text-align:center;">참여 경기 목록</th>
			</tr>
			<tr>
				<th style="text-align:center;">장소</th>
				<th style="text-align:center;">제목</th>
				<th style="text-align:center;">날짜</th>
				<th style="text-align:center;">경기방식</th>
			</tr>
			<c:if test="${profileGames eq '[]'}">
				<tr>
					<th colspan="4" style="text-align:center;">등록된 글이 없습니다.</th>
				</tr>
			</c:if>
			<c:forEach items="${profileGames}" var="bbs" end="4">
				<tr>
					<td style="text-align:center;">${bbs.gu}</td>
					<td style="text-align:center;"><a href="./matching/detail.go?matchingIdx=${bbs.matchingIdx}">${bbs.subject}</a></td>
					<td style="text-align:center;">${bbs.gameDate}</td>
					<td style="text-align:center;">${bbs.gamePlay}:${bbs.gamePlay} </td>
				</tr>
			</c:forEach>
		</table>
		
		</div>
		<c:set var="loginId" value="${sessionScope.loginId}" />
			<c:if test="${loginId != null}">
				<button class="btn btn-outline-dark" onclick="window.open('userReport.go?userId=${profileInfo.userId}&userIdx=${profileInfo.userIdx}','회원 신고','width=600px,height=400px')">신고</button>
			</c:if>
</body>
<script>
var profileGames ="${profileGames}";
console.log(profileGames);
</script>
</html>