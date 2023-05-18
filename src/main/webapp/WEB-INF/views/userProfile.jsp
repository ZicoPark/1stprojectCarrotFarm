<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>

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
		height:83%;
		background-color: #f8f9fa;
		padding: 10 30 10;
		margin : 5px;
		float:right;
		font-size: 16pt;
		
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
	
	button {
		float : right;
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
	
	.pagination .page-link {
  		color: gray; /* 기본 글자색을 검정색으로 지정 */
	}

	.pagination .page-item.active .page-link {
 		background-color: #FFA500;
 		border:none;
	}
	
	

    .right-div {
        float: right;
        margin-right: 400px; /* 좌측과의 간격을 조정할 수 있습니다 */
        
    }
    
    
    th,td {
    	padding:5px;
    	
    }
    
    .tableGab {
        margin-bottom: 50px; /* 아래쪽 간격 설정 */
        
    }
    
    #infoTable th,td {
    	padding : 5px 10px;
    	
    }
    
    #btn {
    	float: bottom;
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
	<c:if test="${loginId eq null}">
			<img width="200" height="200" src="/photo/기본프로필.png">
		</c:if>
		<c:if test="${loginId ne null}">
			<img width="200" height="200" src="/photo/${loginPhotoName}"> 
			<br/> <h3 style="display:inline-block; margin-top:10px;">${loginId} </h3>님 <a href="/cf/userNoticeAlarm">🔔</a>
		</c:if>
	<br/><br/>
           <a href="/cf/userinfo.go">회원 정보</a>
           <br/><br/>
           <a href="/cf/userprofile.go?userId=${loginId}">회원 프로필</a>
           <br/><br/>
           <a href="/cf/userNoticeAlarm">알림</a>
           <br/><br/>
           <a href="/cf/allgames">참여 경기</a>
           <br/><br/>
           <a href="/cf/mygames">리뷰</a>
           <br/><br/>
   </div>
	<div id="content" >
	
	<h3>회원 프로필</h3>
	<br/>
	<div id="inline" style=" float:left; width :30%; height:40%;">
		<img width="100%" src="/photo/${profileInfo.photoName}"/>
	</div>

	
	<div  class="tableGab">
		<table  id="infoTable">
			<tr>
				<th style="font-size: 16pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;닉네임</th>

				<td style="font-size: 15pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${profileInfo.nickName}</td>
			</tr>
			<tr>
				<th style="font-size: 16pt;"><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;키</th>
				<td style="font-size: 16pt;"><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${profileInfo.height}</td>
			</tr>
			<tr>
				<th style="font-size: 16pt;"><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;포지션</th>
				<td style="font-size: 16pt;"><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${profileInfo.position}</td>
			</tr>
			<tr>
				<th style="font-size: 16pt;"><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;선호 지역</th>
				<td style="font-size: 16pt;"><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${profileInfo.gu}</td>
			</tr>
			<tr>
				<th style="font-size: 16pt;"><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;선호 시간</th>
				<td style="font-size: 16pt;"><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${profileInfo.favTime}</td>
			</tr>
			<tr>
				<th style="font-size: 16pt;"><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;매너 점수</th>
				<td style="font-size: 16pt;"><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${mannerPoint}</td>
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
				<th colspan="4" style="text-align:center; font-size: 16pt;"><br/>참여 경기 목록</th>
			</tr>
			<c:if test="${profileGames ne '[]'}">
			<tr>
				<th style="text-align:center;">장소</th>
				<th style="text-align:center;">제목</th>
				<th style="text-align:center;">날짜</th>
				<th style="text-align:center;">경기방식</th>
			</tr>
			</c:if>
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
		
		<div id="btn">
		<c:set var="loginId" value="${sessionScope.loginId}" />
			<c:if test="${profileInfo.userId ne sessionScope.loginId && sessionScope.loginId ne null}">
				<button style=";" class="btn btn-outline-dark" onclick="window.open('userReport.go?userId=${profileInfo.userId}&userIdx=${profileInfo.userIdx}','회원 신고','width=600px,height=400px')">신고</button>
			</c:if>
		</div>
	</div>
</body>
<script>
var profileGames ="${profileGames}";
console.log(profileGames);
</script>
</html>