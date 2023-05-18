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
	body{
		position:relative;
		font-size:15px;
		padding : 10px;
		min-width: 1200px;
	}
	
	#content {
		width:78%;
		height : 83%;
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
	
	<div style="float: right;">
		<%@ include file="../loginBox.jsp" %>
	</div> 
	
	<%@ include file="../GNB.jsp" %>
	
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
	        <a href="/cf/team/teamPage.go?teamIdx=${team.teamIdx}">팀소개</a>
	      <br/><br/>
	        <a href="/cf/team/teamUserList.go?teamIdx=${team.teamIdx}">팀원</a>
	      <br/><br/>
	        <a href="/cf/team/teamGame.go?teamIdx=${team.teamIdx}">참여 경기</a>
	      <br/><br/>
	        <a href="/cf/teamnoticeboardList.do?teamIdx=${team.teamIdx}">팀 공지 사항</a>
	      <br/><br/>
	        <a href="/cf/teampictureboardList.do?teamIdx=${team.teamIdx}">팀 사진첩</a>
	      <br/><br/>

	</div>
	
	<div id="content">
		<div id="inline"><button onclick="location.href='teamList.go'" style="margin: 5px; font-size:15;" class="btn btn-outline-dark">리스트로 돌아가기</button></div>
		<div id="teamMatchState" style="margin: 10px; display: flex; align-items: center; float:right; height: 40px;">
			<p>${team.teamMatchState}</p>
			<c:if test="${teamLeadersChk eq true}">
				<div style="float:right;"><button type="button" style="margin: 5px; font-size:15;" class="btn btn-outline-dark" onclick="location.href='teamJoinAppAlarm.go?teamIdx=${team.teamIdx}'">팀관리</button></div>
			</c:if>
		</div> 
		<c:if test="${team.teamMatchState == '모집중' && joinAppChk eq false && joinTeam eq false}">
			<div style="float:right; margin: 10px; "><button type="button" id="joinApp" style="margin: 5px; font-size:15;" class="btn btn-outline-dark" onclick="joinApp(${team.teamIdx})">가입신청</button></div>
		</c:if>
		<c:if test="${team.teamMatchState == '모집중' && joinAppChk eq true}">
			<div style="float:right; margin: 10px; "><button type="button" id="joinCancelApp" style="margin: 5px; font-size:15;" class="btn btn-outline-dark" onclick="joinCancel(${team.teamIdx})">가입신청 취소</button></div>
		</c:if>
		<br/>
		<br/>
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
				<td id="teamManner"></td>			
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
				<div style="display: inline;" class="alert alert-warning" role="alert">
					${team.tagContent}&nbsp;&nbsp;${team.tagCount}
				</div>&nbsp;&nbsp;
			</c:forEach>
		</div>
		<c:if test="${teamUserChk eq true}">
			<button type="button" id="leaveTeam" onclick="leaveTeam(${team.teamIdx})" class="btn btn-danger" style="margin: 5px; font-size:15;">팀 탈퇴</button>
		</c:if>		
	</div>		

</body>
<script>

	var teamUserManner = "${team.teamManner}";
	var teamUserCount = "${team.teamUser}";
	var teamManner = (teamUserManner / teamUserCount).toFixed(1);
	$('#teamManner').text(teamManner);

	function leaveTeam(teamIdx){
		console.log("팀탈퇴 시작");
		
		$.ajax({
	        url: 'leaveTeam.ajax',
	        type: 'POST',
	        data: {
	            'teamIdx': teamIdx
	        },
	        dataType:'json',
	        success: function(data) {
	        	 console.log(data);	  
            	alert("탈퇴 되었습니다.");
            	
            	var leaveButton = document.getElementById('leaveTeam');
            	leaveButton.style.display = 'none';
            	
	        },
			error:function(e){
				console.log(e);
			}
	    });
		
	}

	if("${team.teamFavNum}" == '0'){
		$('#teamFavNum').text("상관없음");
	}else if("${team.teamFavNum}" == '3'){
		$('#teamFavNum').text("3:3");
	}else if("${team.teamFavNum}" == '5'){
		$('#teamFavNum').text("5:5");
	}

	function joinApp(teamIdx) {
		console.log('joinApp start');
	    
	    $.ajax({
	        url: 'joinApp.ajax',
	        type: 'POST',
	        data: {
	            'teamIdx': teamIdx
	        },
	        dataType:'json',
	        success: function(data) {
	        	 console.log(data);
	        	 
	        	 if(data.removeChk == '1'){
	        		 alert("강퇴회원으로 재가입이 불가능합니다.");
	        	 }
	   
	    		if(data.joinChk == '0'){
		            // 버튼 변경	           
		            var joinAppBtn = document.getElementById('joinApp');
		            joinAppBtn.textContent = '가입신청 취소';
		            joinAppBtn.onclick = function() {
		            	joinCancel('${team.teamIdx}');	            	
		            }
		            alert("가입신청 되었습니다.");
	            }else if(data.joinChk == '1'){
	            	alert("하나의 팀에만 가입할 수 있습니다.");
	            }else if(data.joinChk == 'false'){
	            	alert("로그인 후 다시 시도해주세요.");
	            };
	        },
			error:function(e){
				console.log(e);
			}
	    });
	}

	function joinCancel(teamIdx) {
	    
	    $.ajax({
	        url: 'joinCancel.ajax',
	        type: 'POST',
	        data: {
	            'teamIdx': teamIdx
	        },
			dataType:'json',
	        success: function(data) {
	            // 버튼 변경
	            var joinCancelBtn = document.getElementById('joinApp');
	            joinCancelBtn.textContent = '가입신청';
	            joinCancelBtn.onclick = function() {
	            	joinApp('${team.teamIdx}');
	            };
	            alert("가입신청이 취소 되었습니다.");
	        },
			error:function(e){
				console.log(e);
			}
	    });
	}




	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	}
</script>
</html>