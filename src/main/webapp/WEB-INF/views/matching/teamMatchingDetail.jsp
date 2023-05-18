<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<meta charset="UTF-8">
<title>🏀 당근농장</title>
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8eccc3d59df46746494af9204ba90019"></script>

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
		margin : 5px;
	}
	
	table{
/* 		border : 1px solid black; */
		width:95%;
		height:70%;
		text-align:center;
	}

	#playerListPopup, #gameApplyListPopup,#gameInviteListPopup, #teamRegistPopup{
        display: none;
        position: fixed;
        top: 20%;
        left: 50%;
        width: 400px;
        height: 400px;
        background-color: #f8f9fa;
        border: 1px solid black;
        z-index: 9999;
        padding: 20px;
      }
      
   

	h3,p {
		text-align:center;
	}
	
	#closePlayerListBtn, #closeGameApplyListBtn, #closeGameInviteListBtn, #closeTeamRegistBtn{
		margin:auto;
        display:block;
	}
	
	
	div {
	  display: inline-block;
	}
	
	#scroll{
		width: 350px;
        height: 230px;
		overflow: auto;
	}
	
	li {
		margin : 2px;
	}

	
</style>
</head>
<body>
	<div style="float: right;">
		<%@ include file="../loginBox.jsp" %>
	</div> 
	<%@ include file="../GNB.jsp" %>
	
	</br>
	
	
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
	    <a href="/cf/matching/list.do">개인 모집글</a> 
	      <br/><br/>
	    <a href="/cf/matching/teamList.do" >팀 모집글</a>	    
	</div>
	
	<div id="content">
	<table>
		<tr style="height:15px;">
				<th style="text-align:left;"><h2>&nbsp; &nbsp; &nbsp; &nbsp; ${dto.subject}</h2></th>
				<th style="width: 28%;">${dto.gameDate} </th>
				<th style="width: 10%;">&#128100 ${dto.matchingNumforSure}/${dto.matchingNum}</th>
				<th style="width: 12%;"><a href="#" onclick="window.open('/cf/team/teamPagePop.go?teamIdx=${dto.teamIdx}', '팀페이지팝업창', 'width=1000px,height=600px');">${dto.teamName}</a></th>
		</tr>
		<tr style="height:1px;">
				<th colspan="4"><hr/></th>
		</tr>
		<tr>
	     	<th>
	     		<div id="map" style="width:90%;height:90%; border: 1px solid black;"></div>
	     	</th>
	     	<td colspan="3" style="text-align:left; padding-left:20px; border-left:1px solid gray;" >
	     		</br>🏀 경기 일시 : ${dto.gameDate} 
	     		</br>🏀 경기 장소 : ${dto.courtName}
	     		</br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 주소: ${dto.courtAddress}
	     		</br>🏀 모집 인원 :	 &#128100 ${dto.matchingNumforSure}/${dto.matchingNum} &nbsp; &nbsp; 
	     			<c:if test="${loginId != null }">
	     				<button class="btn btn-outline-dark" id="playerList">참가자</button>
	     				
	     				<c:if test="${myTeamDto.teamGrade eq 'leader'}">
	     					<c:forEach items="${playerList}" var="playerList">
		     					<c:if test="${playerList.userId eq loginId}">
		     						<button class="btn btn-outline-dark" id="teamRegist">팀원등록</button>
		     					</c:if>
	     					</c:forEach>
	     				
	     				</c:if>
	     			</c:if>
				    </br>🏀 경기 방식 : ${dto.gamePlay} : ${dto.gamePlay}
	     			</br>🏀 ${dto.content}
	     		</td>
	     	</tr>
	     	
	     	<c:if test="${loginId == null }">
	     	<tr>
	     		<th colspan="4"> 경기 참여는 로그인 후 가능 합니다.</th>
	     	</tr>
	     	</c:if>
   		
	     	
			
				    
	     	<tr>
	     		<!--matchigState가 matching 상태일 시  -->
	     		<c:if test="${dto.matchigState eq 'matching'}">
	     			<th>
	     				<c:if test="${loginId != null }">
		     				<button class="btn btn-outline-dark" id="gameApplyList">신청자</button>
		     				<c:if test="${dto.writerId eq loginId }">
		     					<button class="btn btn-outline-dark" id="gameInviteList">초대</button>
	     					</c:if>	
	     				</c:if>	
	     			</th>
	     		
		     		<c:if test="${dto.writerId eq loginId }">
			     		<th style="text-align:left;">
		     				<button class="btn btn-warning" id="matchingChk">모집종료</button>
		     			</th>
		     		</c:if>
		     		
		     		<c:if test="${dto.writerId ne loginId }">
			     		<th colspan="2" style="text-align:left;">
			     		<c:if test="${loginId != null }">
				     		<c:if test="${myTeamDto.teamGrade eq 'leader'}">
			     				<button class="btn btn-warning" id="applyChk" onclick="location.href='applyGame?matchingIdx=${dto.matchingIdx}'">신청</button>
			     			</c:if>
		     			</c:if>
		     			</th>
		     		</c:if>
	     		</c:if>
	     		
	     	
			 
	     		
<!--matchigState가 finish 상태일 시  -->
	     		<c:if test="${dto.matchigState eq 'finish'}">
	     			<th>
	     			
	     			</th>
	     			<c:if test="${dto.writerId eq loginId }">
			     		<th>
			     			<button class="btn btn-warning" id="finishChk">경기종료</button>
		     			</th>
		     		</c:if>
		     		
		     		<c:if test="${dto.writerId ne loginId }">
			     		
		     		</c:if>
	     		</c:if>
	     		

<!--matchigState가 review 상태일 시  -->
	     		<c:if test="${dto.matchigState eq 'review'}">
	     			
	     			<th>
	     				
	     			</th>
	     			<th>
	     				<button class="btn btn-warning" id="review" onclick="window.open('review.go?matchingIdx=${dto.matchingIdx}','당근농장 리뷰','width=600px,height=400px')">리뷰 작성</button>
	     			</th>
	     		</c:if>
	     		
	     		<th colspan="2">
		     		<c:if test="${dto.writerId eq loginId }">
			     		
			     			<button class="btn btn-outline-dark" onclick="location.href='update.go?matchingIdx=${dto.matchingIdx}'">수정</button>
			     			<button class="btn btn-outline-dark" id="delChk" >삭제</button>
							<button class="btn btn-outline-dark" onclick="location.href='./list.do'">목록</button>
			     		
		     		</c:if>
		     		
	     		
		     		<c:if test="${dto.writerId ne loginId }">
			     		<c:if test="${loginId != null }">
			     			<button class="btn btn-outline-dark" onclick="window.open('matchingReport.go?matchingIdx=${dto.matchingIdx}','당근농장 신고','width=600px,height=400px')">신고</button>
			     		</c:if>
			     		<button class="btn btn-outline-dark" onclick="location.href='./list.do'">목록</button>
		     		</c:if>
	     		</th>
	     	</tr>
	     	
	     	<!-- 리뷰 결과 -->
	     	<c:if test="${dto.matchigState eq 'review'}">
		     	<tr style="height:1px;">
					<th colspan="4"><hr/></th>
				</tr>
		     	<tr >
		     		<th colspan="4">
		     		 	<p> 리뷰결과</p>
		     		</th>
		     	</tr>	
		     	<tr>
		     		<th colspan="1" >
		     		 	<p>${dto.teamName}</p>
		     		 	<p>팀페이지에서 확인해 주세요 </p>
		     		 	
		     		 	
		     		</th>
		     		<th colspan="3" style="border-left:1px solid gray;">
		     		 	<p>MVP</p>
		     		 	<p>${mvp}</p>
		     		</th>
		     	</tr>
	     	</c:if>

	     	
	     	
	     	</br>
<!--matchigState : matching, finish, review  -->		     	     	
	     	
	     	<tr style="height:1px;">
				<th colspan="4"><hr/></th>
			</tr>
<!-- 댓글 -->
		<table style="width:90%; height:15%;">
	     	
				<c:forEach items="${commentList}" var="commentList">
					<tr>
				    	<th style="width:10%;"><a href="#" onclick="window.open('../userprofilepop.go?userId=${commentList.userId}','회원프로필','width=400px,height=600px')">${commentList.userId}</a></th>
				     	<td style="width:65%; padding-left:20px; text-align:left;">${commentList.commentContent}</td>
				     	<td style="width:15%;">${commentList.commentWriteTime}</td>
				     	<td style="width:10%;">
				     		<c:if test="${commentList.userId eq loginId}">
				     			<a  href="commentUpdate.go?commentIdx=${commentList.commentIdx}&matchingIdx=${dto.matchingIdx}" >수정</a> 
				     			/ 
				     			<a href="commentDelete.do?commentIdx=${commentList.commentIdx}&matchingIdx=${dto.matchingIdx}" id="delCommentChk" >삭제</a>
	
				     		</c:if>
				     		<c:if test="${commentList.userId ne loginId}">
					     		<c:if test="${loginId != null }">
					     			<a href="#" onclick="window.open('commentReport.go?commentIdx=${commentList.commentIdx}','당근농장 신고','width=600px,height=400px')">신고</a>				     			
					     		</c:if>	 
				     		</c:if>	     					
				     	</td>
				     </tr>
				</c:forEach>
		     
			     <tr>
	
				     <form method="post" action="commentWrite.do?categoryId=m01&comentId=${dto.matchingIdx}" id="commentForm">
				     		<th >
				     			<input type="text" name="userId" value="${loginId}" style= "border:none; width:100px; background-color: #f8f9fa;" readonly>
				     		</th>
				     		<c:if test="${loginId != null }">
					     		<th colspan="2">
					     			<input type="text" name="commentContent" id="commentContent" style="background-color: white; border: 1px solid black; width: 100%; padding-left:20px; text-align:left;">
					     		</th>
					     		<th>
					     			<input type="button" class="btn btn-outline-dark" value="작성" onclick="subCommentChk()" />
					     		</th>
				     		</c:if>
				     		<c:if test="${loginId == null }">
					     		<th colspan="3">
					     			<input type="text" name="commentContent" style= "border:none; width:400px; background-color: #f8f9fa;" placeholder="댓글 작성은 로그인 후 가능합니다. " readonly />
					     		</th>
				     		</c:if>
				     </form>
				     			     
			     </tr>
		     </table>
		   
		   
		   
		   <div id="playerListPopup">
				<h3>참가자 목록</h3>
				<hr>
				<div id="scroll" >
				<ul>
					<c:forEach items="${playerList}" var="playerList">
						<c:if test="${playerList.teamName eq dto.teamName}">
							<li> <a href="#" onclick="window.open('/cf/team/teamPagePop.go?teamIdx=${playerList.teamIdx}', '팀페이지팝업창', 'width=1000px,height=600px');">${playerList.teamName}</a>
<a href="#" onclick="window.open('../userprofilepop.go?userId=${playerList.userId}','회원프로필','width=400px,height=600px')">${playerList.userId}</a>
							<c:if test="${dto.writerId eq loginId }">
								<c:if test="${dto.writerId ne playerList.userId }">
									<button class="btn btn-outline-dark" onclick="location.href='playerDelete?userId=${playerList.userId}&matchingIdx=${dto.matchingIdx}'">취소</button>
								</c:if>
							</c:if>
							</br>
							</li>
						</c:if>
					</c:forEach>
					</br>
					<c:forEach items="${playerList}" var="playerList">
						<c:if test="${playerList.teamName ne dto.teamName}">
							<li> <a href="#" onclick="window.open('/cf/team/teamPagePop.go?teamIdx=${playerList.teamIdx}', '팀페이지팝업창', 'width=1000px,height=600px');">${playerList.teamName}</a>
<a href="#" onclick="window.open('../userprofilepop.go?userId=${playerList.userId}','회원프로필','width=400px,height=600px')">${playerList.userId}</a>
							<c:if test="${dto.writerId eq loginId }">
								<c:if test="${dto.writerId ne playerList.userId }">
									<button class="btn btn-outline-dark" onclick="location.href='playerDelete?userId=${playerList.userId}&matchingIdx=${dto.matchingIdx}'">취소</button>
								</c:if>
							</c:if>
							</br>
							</li>
						</c:if>
					</c:forEach>
				</ul>
				</div>
				<button class="btn btn-outline-dark" id="closePlayerListBtn">닫기</button>
			</div>
			
			<div id="teamRegistPopup">
					<h3>팀원등록</h3>
					<hr>
					<div  id="scroll">
						<c:if test="${teamMemberList ne null}">
							<c:forEach items="${teamMemberList}" var="teamMemberList">
								<c:if test="${teamMemberList.userId ne loginId}">
									<li> 
										<a href="#" onclick="window.open('../userprofilepop.go?userId=${teamMemberList.userId}','회원프로필','width=400px,height=600px')">${teamMemberList.userId}</a>
										<button class="btn btn-outline-dark" id="registBtn_${teamMemberList.userId}" onclick="teamRegist('${teamMemberList.userId}', '${dto.matchingIdx}')">등록</button>
									</li>
								</c:if>
							</c:forEach>
						</c:if>
						<c:if test="${teamMemberList eq null}">
							<li> 등록할 수 있는 팀원이 없습니다. </li>
						</c:if>
					</div>
					<button class="btn btn-outline-dark" id="closeTeamRegistBtn" onclick="location.href='teamDetail.go?matchingIdx='+${dto.matchingIdx}">닫기</button>
			</div>
			
	     		<div id="gameApplyListPopup">
					<h3>신청팀 목록</h3>
					<hr>
					<div id="scroll" >
					<ul>
						<c:forEach items="${teamApplyList}" var="gameApplyList">
							<li><a href="#" onclick="window.open('/cf/team/teamPagePop.go?teamIdx=${gameApplyList.teamIdx}', '팀페이지팝업창', 'width=1000px,height=600px');">${gameApplyList.teamName}</a>
							<c:if test="${dto.writerId eq loginId }">
								<button class="btn btn-outline-dark" onclick="location.href='gameApplyAccept?userId=${gameApplyList.userId}&matchingIdx=${dto.matchingIdx}'">수락</button> / 
								<button class="btn btn-outline-dark" onclick="location.href='gameApplyReject?userId=${gameApplyList.userId}&matchingIdx=${dto.matchingIdx}'">거절</button>
							</c:if>
							</br>
							</li>
						</c:forEach>
					</ul>
					</div>
					<button class="btn btn-outline-dark" id="closeGameApplyListBtn">닫기</button>
				</div>
				
				<div id="gameInviteListPopup">
					<h3>초대하기</h3>
					<hr>
					<div id="scroll" >
						<ul>
							<c:if test="${teamInviteList !=null}">
								<c:forEach items="${teamInviteList}" var="teamInviteList">
									<li> 
										<a href="#" onclick="window.open('/cf/team/teamPagePop.go?teamIdx=${teamInviteList.teamIdx}', '팀페이지팝업창', 'width=1000px,height=600px');">${teamInviteList.teamName}</a>
										<button class="btn btn-outline-dark" id="inviteBtn_${teamInviteList.userId}" onclick="cancelInvite('${teamInviteList.userId}', '${dto.matchingIdx}')">취소</button>
									</li>
								</c:forEach>
							</c:if> 
									
											
							<c:forEach items="${teamList}" var="teamList">
								<li> 
									<a href="#" onclick="window.open('/cf/team/teamPagePop.go?teamIdx=${teamList.teamIdx}', '팀페이지팝업창', 'width=1000px,height=600px');">${teamList.teamName}</a>
									<button class="btn btn-outline-dark" id="inviteBtn_${teamList.userId}" onclick="inviteTeam('${teamList.userId}', '${dto.matchingIdx}')">초대</button>
								</li>
							</c:forEach>
						</ul>
					</div>
					<button class="btn btn-outline-dark" id="closeGameInviteListBtn" onclick="location.href='teamDetail.go?matchingIdx='+${dto.matchingIdx}">닫기</button>
				</div>
		   
		   
		   
		   </div>
		  </body>
		  
		  
		  
	<script>
	
	var container = document.getElementById('map');
    var options = {
        center: new kakao.maps.LatLng(${dto.courtLatitude},${dto.courtLongitude}),
        level: 4
    };

    var map = new kakao.maps.Map(container, options);

    var markerPosition  = new kakao.maps.LatLng(${dto.courtLatitude},${dto.courtLongitude}); 

    var marker = new kakao.maps.Marker({
        position: markerPosition
    });

    marker.setMap(map);
    
    var iwContent = '<div style="padding:5px;">${dto.courtName} </br> ${dto.courtTel}</div>'; 
    var infowindow = new kakao.maps.InfoWindow({
        content : iwContent
    });

    kakao.maps.event.addListener(marker, 'click', function() {
        infowindow.open(map, marker);
    });
	
    
   
    
    
    
    
    
    function subCommentChk(){
		console.log($('#commentContent').val());
		
		if($('#commentContent').val() == ''){
			alert('댓글을 입력해주세요.');
			return false;
		}else{
			$('#commentForm').submit();
		}
		
		
	}
    
    //=============================================================
    // comfirm 창 모음
    //=============================================================
   $(function() {
	   $('#delChk').click(function(event) {
	     if (!confirm('삭제하시면 복구할수 없습니다. \n 정말로 삭제하시겠습니까??')) {
	       event.preventDefault(); // 기본 이벤트 처리 중단
	     } else {
	       location.href = 'delete.do?matchingIdx=${dto.matchingIdx}'; // onclick 이벤트 처리
	     }
	   });
	 });


   $(function() {
	   $('#matchingChk').click(function(event) {
	     var matchingNumforSure = parseInt('${dto.matchingNumforSure}');
	     var matchingNum = parseInt('${dto.matchingNum}');
	     if (matchingNumforSure > matchingNum) {
	       alert('모집 인원 수 보다 경기 참여 인원이 많습니다. 참가자 목록을 확인해 주세요');
	       event.preventDefault();
	     } else if (matchingNumforSure == 1) {
			 alert('경기는 최소 2명의 참가자가 존재할 때만 가능합니다. ');
			 event.preventDefault();
		}else if (!confirm('모집을 종료하면 경기 참가 신청은 자동으로 거절 됩니다.\n 정말로 종료하시겠습니까??')) {
	       event.preventDefault(); 
	     } else {
	       location.href='matchigStateUpdate?matchingIdx=${dto.matchingIdx}&matchigState=${dto.matchigState}';
	     }
	   });
	 });
   
   
   $(function() {
	   $('#finishChk').click(function(event) {
	     if (!confirm('경기를 종료하고 리뷰를 작성하시겠습니까?')) {
	       event.preventDefault(); // 기본 이벤트 처리 중단
	     } else {
	    	location.href='matchigStateUpdate?matchingIdx=${dto.matchingIdx}&matchigState=${dto.matchigState}';
	     }
	   });
	 });
   
   

  
 
    
    
	
 var playerListBtn = document.getElementById('playerList');
    var playerListPopup = document.getElementById('playerListPopup');
    var closePlayerListBtn = document.getElementById('closePlayerListBtn');

    playerListBtn.addEventListener('click', function() {
      playerListPopup.style.display = 'block';
    });

    closePlayerListBtn.addEventListener('click', function() {
      playerListPopup.style.display = 'none';
    });
	
     
    var gameApplyListBtn = document.getElementById('gameApplyList');
    var gameApplyListPopup = document.getElementById('gameApplyListPopup');
    var closeGameApplyListBtn = document.getElementById('closeGameApplyListBtn');

    gameApplyListBtn.addEventListener('click', function() {
    	gameApplyListPopup.style.display = 'block';
    });

    closeGameApplyListBtn.addEventListener('click', function() {
    	gameApplyListPopup.style.display = 'none';
    });
   
   
    
    var teamRegistBtn = document.getElementById('teamRegist');
    var teamRegistPopup = document.getElementById('teamRegistPopup');
    var closeTeamRegistBtn = document.getElementById('closeTeamRegistBtn');

    teamRegistBtn.addEventListener('click', function() {
    	teamRegistPopup.style.display = 'block';
    });

    closeTeamRegistBtn.addEventListener('click', function() {
    	teamRegistPopup.style.display = 'none';
    });
    
    
     var gameInviteListBtn = document.getElementById('gameInviteList');
    var gameInviteListPopup = document.getElementById('gameInviteListPopup');
    var closeGameInviteListBtn = document.getElementById('closeGameInviteListBtn');

    gameInviteListBtn.addEventListener('click', function() {
    	gameInviteListPopup.style.display = 'block';
    });

    closeGameInviteListBtn.addEventListener('click', function() {
    	gameInviteListPopup.style.display = 'none';
    });
function inviteTeam(userId, matchingIdx) {
        
        $.ajax({
            url: 'gameInvite.ajax',
            type: 'POST',
            data: {
                userId: userId,
                matchingIdx: matchingIdx
            },
            success: function(data) {
                // 버튼 변경
                console.log(data);
                var inviteBtn = document.getElementById('inviteBtn_' + userId);
                inviteBtn.textContent = '취소';
                inviteBtn.onclick = function() {
                    cancelInvite(userId, '${dto.matchingIdx}');
                };
            }
        });
    }

    function cancelInvite(userId,matchingIdx) {
        
        $.ajax({
            url: 'cancelGameInvite.ajax',
            type: 'POST',
            data: {
                userId: userId,
                matchingIdx: matchingIdx
            },
            success: function(data) {
                // 버튼 변경
                console.log(data);
                var inviteBtn = document.getElementById('inviteBtn_' + userId);
                inviteBtn.textContent = '초대';
                inviteBtn.onclick = function() {
                    inviteUser('${gameInviteList.userId}', '${dto.matchingIdx}');
                };
            }
        });
    }
    

    
function teamRegist(userId, matchingIdx) {
        
        $.ajax({
            url: 'teamRegist.ajax',
            type: 'POST',
            data: {
                userId: userId,
                matchingIdx: matchingIdx
            },
            success: function(data) {
                // 버튼 변경
                console.log(data);
                var inviteBtn = document.getElementById('registBtn_' + userId);
                inviteBtn.textContent = '취소';
                inviteBtn.onclick = function() {
                	cancelRegist(userId,matchingIdx);
                };
            }
        });
}

function cancelRegist(userId,matchingIdx) {
    
    $.ajax({
        url: 'cancelRegist.ajax',
        type: 'POST',
        data: {
            userId: userId,
            matchingIdx: matchingIdx
        },
        success: function(data) {
            // 버튼 변경
            console.log(data);
            var inviteBtn = document.getElementById('registBtn_' + userId);
            inviteBtn.textContent = '등록';
            inviteBtn.onclick = function() {
            	teamRegist(userId, matchingIdx);
            };
        }
    });
}

        
    </script>
</html>