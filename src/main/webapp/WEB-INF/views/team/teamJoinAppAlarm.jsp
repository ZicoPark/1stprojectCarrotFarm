<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>🏀 당근농장</title>
	<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
	<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>    
	<script src="../resources/js/twbsPagination.js" type="text/javascript"></script>
	
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
	
	
	table, th, td{
		margin : 5px;
	}
	
	table{
		width:100%;
		height:40%;
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
        <a href="/cf/team/teamJoinAppAlarm.go?teamIdx=${teamIdx}">알림</a>
      <br/><br/>
        <a href="/cf/team/teamPageUpdate.go?teamIdx=${teamIdx}">팀정보 수정</a>
      <br/><br/>
        <a href="/cf/team/teamUserListLeader.go?teamIdx=${teamIdx}">팀원</a>
      <br/><br/>
        <a href="/cf/team/writeMatchingList.go?teamIdx=${teamIdx}">모집중인 경기</a>
      <br/><br/>
        <a href="/cf/team/gameMatchingRequest.go?teamIdx=${teamIdx}" >참가신청한 경기</a>
        <br/><br/>
        <a href="/cf/team/warningTeamUser.go?teamIdx=${teamIdx}">경고/강퇴</a>
      <br/><br/>
        <a href="/cf/team/teamDisbanding.go?teamIdx=${teamIdx}" >팀 해체</a>
	</div>
	
	
	<div id="content">
		<input type="hidden" name="teamIdx" value="${teamIdx}"/>
		<br/>
		<ul class="nav nav-tabs">
		  <li class="nav-item">
		    <a class="nav-link active" href="teamJoinAppAlarm.go?teamIdx=${teamIdx}">팀 가입신청 알림</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link"  href="gameMatchingAppAlarm.go?teamIdx=${teamIdx}">경기 참가신청 알림</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link"  href="appGameUpdateAlarm.go?teamIdx=${teamIdx}">경기 변경사항 알림</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link"  href="matchingInviteAlarm.go?teamIdx=${teamIdx}">경기 초대 알림</a>
		  </li>
		</ul>
		<br/><br/>
		<table>
			<colgroup>
				<col width="15%"/>
				<col width="10%"/>
				<col width="15%"/>
				<col width="15%"/>
				<col width="15%"/>
				<col width="10%"/>
				<col width="20%"/>
			</colgroup>
			<thead>
				<tr>
					<th>신청일</th>
					<th>아이디</th>
					<th>활동지역</th>
					<th>선호 포지션</th>
					<th>주 활동시간</th>
					<th>매너점수</th>
					<th>응답</th>
				</tr>
			</thead>
			<tbody id="list">
				<!-- list 출력 영역 -->
			</tbody>
		</table>
	</div>
</body>
<script>

	var teamIdx = ${teamIdx}
	console.log(teamIdx);
	listCall();

	function accept(teamIdx,userId) {
		console.log('accept start');
	    
	    $.ajax({
	        url: 'teamJoinAccept.ajax',
	        type: 'POST',
	        data: {
	            'teamIdx': teamIdx,
	            'userId':userId
	        },
			dataType:'json',
			success: function(data) {
	        	 console.log("수락 성공");
	             alert("수락되었습니다.");
	             listCall();
	        },
			error:function(e){
				console.log(e);
			}
	    });
	}	
	
	function reject(teamIdx,userId) {
		console.log('reject start');
	    
	    $.ajax({
	        url: 'teamJoinReject.ajax',
	        type: 'POST',
	        data: {
	            'teamIdx': teamIdx,
	            'userId':userId
	        },
			dataType:'json',
			success: function(data) {
	        	 console.log("거절 성공");
	             alert("거절되었습니다.");
	             listCall();
	        },
			error:function(e){
				console.log(e);
			}
	    });
	}	
	
	function listCall(){
		$.ajax({
			type:'post',
			url:'teamJoinAppList.ajax',
			data:{
				'teamIdx':teamIdx
			},
			dataType:'json',
			success:function(data){
				console.log(data);
				listPrint(data.list);				
			},
			error:function(e){
				console.log(e);
			}
		});
	}
	
	function listPrint(list){
		var content = '';		
		
		if(list.length==0){
			content +='<tr>';
			content +='<th colspan="7"> 확인할 알림이 없습니다. </th>';
			content +='</tr>';
		}else{
			list.forEach(function(list){		
				content +='<tr>';
				content +='<td>'+list.teamAppDate+'</td>';
				content +='<td><a href="회원프로필.go?userIdx='+list.userId+'">'+list.userId+'</a></td>';
				content +='<td>'+list.gu+'</td>';
				content +='<td>'+list.position+'</td>';
				content +='<td>'+list.favTime+'</td>';
				content +='<td>'+list.userManner+'</td>';
				content += '<td><button onclick="accept(' + "'" + list.teamIdx + "'" + ',' + "'" + list.userId + "'" + ')">수락</button> &nbsp; <button onclick="reject(' + "'" + list.teamIdx + "'" + ',' + "'" +  list.userId + "'" +  ')">거절</button></td>';
				content +='</tr>';
			});		
		}
		$('#list').empty();
		$('#list').append(content);
	}
	
</script>
</html>