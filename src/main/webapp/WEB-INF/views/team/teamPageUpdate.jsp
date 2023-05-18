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
		padding: 10px;
		margin : 5px;
	}
	
	th{		
		text-align: center;
	}
	
	table{
		width: 100%;
		height: 85%;
		margin : 5px;
	}
	
	button{
		margin: 5px;
		text-align: center;
	}
	
	#inline{
		float: left;
		margin:0 20 5 0;
	}

	input[type="text"]{
		width: 100%;
	}
	
	#location{
		width: 80%;
	}
	
	textarea{
		width: 100%;
		height: 100%;
		resize: none;
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
        <a href="/cf/team/teamJoinAppAlarm.go?teamIdx=${team.teamIdx}">알림</a>
      <br/><br/>
        <a href="/cf/team/teamPageUpdate.go?teamIdx=${team.teamIdx}">팀정보 수정</a>
      <br/><br/>
        <a href="/cf/team/teamUserListLeader.go?teamIdx=${team.teamIdx}">팀원</a>
      <br/><br/>
        <a href="/cf/team/writeMatchingList.go?teamIdx=${team.teamIdx}">모집중인 경기</a>
      <br/><br/>
        <a href="/cf/team/gameMatchingRequest.go?teamIdx=${team.teamIdx}" >참가신청한 경기</a>
        <br/><br/>
        <a href="/cf/team/warningTeamUser.go?teamIdx=${team.teamIdx}">경고/강퇴</a>
      <br/><br/>
        <a href="/cf/team/teamDisbanding.go?teamIdx=${team.teamIdx}" >팀 해체</a>
	</div>
	
	
	<div id="content">
		<form action="teamPageUpdate.do" method="post" enctype="multipart/form-data">	
			<input type="hidden" name="teamIdx" value="${team.teamIdx}"/>
			<button type="button" style="float: right; margin: 5px; font-size:15;" class="btn btn-outline-dark" onclick="update()">저장</button>
			<table>
				<thead>
					<colgroup>
						 <col width="20%"/>
						 <col width="80%"/>
					</colgroup>
				</thead>
				<tbody>
					<tr>
						<th>팀이름</th>
						<td>
							<input type="text" id="teamName" name="teamName" value="${team.teamName}"/>
							<span id="msg"></span>
							<div hidden="true"><span id="count">0</span>/<span id="max-count">0</span></div>
						</td>
					</tr>
					<tr>
						<th>팀 프로필 사진</th>
						<td>
							<c:if test="${team.photoName eq null}">
								<input type="file" name="teamProfilePhoto"/>
							</c:if>
							<c:if test="${team.photoName ne null}">
								<p>프로필 사진은 한장만 업로드 할 수 있습니다.</p>
								<input type="file" name="teamProfilePhoto"/>
								<img width="300" src="/photo/${team.photoName}"/>
								<div hidden="true"><input type="text" name="photoName" value="${team.photoName}"/></div>							
							</c:if>		
						</td>
					</tr>
					<tr>
						<th>팀원 모집여부</th>
						<td>
							<input type="radio" name="teamMatchState" name="teamMatchState" value="모집중" <c:if test="${team.teamMatchState eq '모집중'}">checked</c:if>/>모집 &nbsp;&nbsp;&nbsp;
							<input type="radio" name="teamMatchState" name="teamMatchState" value="모집종료"<c:if test="${team.teamMatchState eq '모집종료'}">checked</c:if>/>모집종료
						</td>
					</tr>
					<tr>
						<th>주 활동지역</th>
						<td>
							<input type="text" id="location" name="location" value="${team.gu}" readonly/> &nbsp;&nbsp;
							<input type="button" id="address_kakao" value="검색" style="margin: 5px; font-size:15;" class="btn btn-outline-dark"/>
							<div hidden="true"><input type="text" name="locationIdx" value="${team.locationIdx}"/></div>
						</td>
					</tr>
					<tr>
						<th>주 활동시간</th>
						<td>
							<select id="teamFavTime" name="teamFavTime">
						        <option id="평일오전" value="평일/오전">평일/오전</option>
						        <option id="평일오후" value="평일/오후">평일/오후</option>
						        <option id="평일저녁" value="평일/저녁">평일/저녁</option>
						        <option id="주말오전" value="주말/오전">주말/오전</option>
						        <option id="주말오후" value="주말/오후">주말/오후</option>
						        <option id="주말저녁" value="주말/저녁">주말/저녁</option>
						        <option id="상관없음" value="상관없음">상관없음</option>
						    </select>
		    			</td>
					</tr>
					<tr>
						<th>선호하는 경기종목</th>
						<td>
							<select name="teamFavNum">
						        <option value="3">3:3</option>
						        <option value="5">5:5</option>
						        <option value="0">상관없음</option>
						    </select>
						</td>
					</tr>
					<tr>
						<th>소개글</th>
						<td>
							<textarea id="teamIntroduce" name="teamIntroduce" placeholder="팀소개글 및 구하는 포지션 등을 자유롭게 작성해주세요.">${team.teamIntroduce}</textarea>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
</body>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	
	function gps(){
		var selectedTeamFavTime = '${team.teamFavTime}';
		// 선택한 요소 확인 okay
		console.log(selectedTeamFavTime);
		
		if (selectedTeamFavTime == '평일/오전') {
		    $('#평일오전').prop('selected',true);
		  }else if(selectedTeamFavTime == '평일/오후') {
		    $('#평일오후').prop('selected',true);
		  }else if(selectedTeamFavTime == '평일/저녁') {
		    $('#평일저녁').prop('selected',true);
		  }else if(selectedTeamFavTime == '주말/오전') {
		    $('#주말오전').prop('selected',true);
		  }else if(selectedTeamFavTime == '주말/오후') {
		    $('#주말오후').prop('selected',true);
		  }else if(selectedTeamFavTime == '주말/저녁') {
		    $('#주말저녁').prop('selected',true);
		  }else if(selectedTeamFavTime == '상관없음') {
		    $('#상관없음').prop('selected',true);
		  }
	};
	
	$(document).ready(function() {
		gps();
});

	document.getElementById('teamName').addEventListener('keyup',checkByte);
	var countSpan = document.getElementById('count');
	var message = '';
	var MAX_MESSAGE_BYTE = 20;
	document.getElementById('max-count').innerHTML = MAX_MESSAGE_BYTE.toString();
	
	function checkByte(event){
		const totalByte = count(event.target.value);
		
		if(totalByte <= MAX_MESSAGE_BYTE){
			countSpan.innerText = totalByte.toString();
			message = event.target.value;
		}else{
			alert("한글 10자, 영문 20자까지만 입력가능 합니다.")
			countSpan.innerText=count(message).toString();
			event.target.value = message;
		}
	}
	
	function count(message){
		var totalByte = 0;
		
		for(var i=0; i<message.length; i++){
			var currentByte = message.charCodeAt(i);
			(currentByte>128) ? totalByte += 2 : totalByte++;
		}
		return totalByte;
	}

    document.getElementById("address_kakao").addEventListener("click", function(){ 
    	//주소검색 버튼을 클릭하면 카카오 지도 발생
        new daum.Postcode({
            oncomplete: function(data) { //선택시 입력값 세팅
                var sigungu = data.sigungu; // '구' 주소 넣기
                document.getElementById("location").value = sigungu;
                console.log($('#location').val());
                console.log(sigungu);
            }
        }).open();
    });
	
	var overlayChk = false;	
	
	function update(){
		if($('#teamName').val() != '${team.teamName}'){
			if(overlayChk == true){
				if($('#teamName').val()==''){
					alert('팀이름을 입력해주세요!');
					$('#teamName').focus();
				}else if($('#teamIntroduce').val()==''){
					alert('팀 소개글을 입력해주세요!');
					$('#teamIntroduce').focus();
				}else if($('#location').val()==''){
					alert('주 활동지역을 입력해주세요!');
					$('#teamIntroduce').focus();
				}else{				
						$('button').attr('type','submit');				
				}
			}else{
				alert('이미 사용 중인 팀이름 입니다.');				
			}
		}else{
			if($('#teamName').val()==''){
				alert('팀이름을 입력해주세요!');
				$('#teamName').focus();
			}else if($('#teamIntroduce').val()==''){
				alert('팀 소개글을 입력해주세요!');
				$('#teamIntroduce').focus();
			}else if($('#location').val()==''){
				alert('주 활동지역을 입력해주세요!');
				$('#teamIntroduce').focus();
			}else{				
					$('button').attr('type','submit');				
			}
		}
	}

	
	$('#teamName').keyup(function(e){
		
		var teamName = $('#teamName').val();
		
		$.ajax({
			type:'post',
			url:'overlayTeamName.ajax',
			data:{'teamName':teamName},
			dataType:'json',
			success:function(data){
				if(data.overlay == 0){
					console.log('사용 가능한 이름');
					$('#msg').css({'font-size':'8px', 'color':'darkgreen'});
					$('#msg').html('사용 가능한 팀이름 입니다.');
					overlayChk = true;
				}else{
					console.log('이미 사용 중인 이름');
					$('#msg').css({'font-size':'8px', 'color':'red'});
					$('#msg').html('이미 사용 중인 팀이름 입니다.');
				}						
			},
			error:function(e){
				console.log(e);
			}
		});
	});
	
	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	}
	
	
	
	



</script>
</html>










