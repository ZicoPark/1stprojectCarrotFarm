<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
		<input type="text" id="searchInput" placeholder="아이디 검색">
		<button id="searchButton" style="margin: 5px; font-size:15;" class="btn btn-outline-dark">검색</button>
		&nbsp;&nbsp;
		<br/><br/>
		<hr>
		<br/><br/>
		<table>
			<colgroup>
				<col width="20%"/>
				<col width="20%"/>
				<col width="10%"/>
				<col width="20%"/>
				<col width="20%"/>
				<col width="10%"/>
			</colgroup>
			<thead>
				<tr>
					<th>직급</th>
					<th>아이디</th>
					<th>경고</th>
					<th>경고취소</th>
					<th>경고횟수</th>
					<th>강퇴</th>
				</tr>
			</thead>
			<tbody id="list">
				<!-- list 출력 영역 -->
			</tbody>
			<tr>
				<td colspan="6" id="paging">	
					<!-- 	플러그인 사용	(twbsPagination)	-->
					<div class="container">									
						<nav aria-label="Page navigation" style="text-align:center">
							<ul class="pagination justify-content-center" id="pagination"></ul>
						</nav>					
					</div>
				</td>
			</tr>
		</table>
	</div>
</body>
<script>
	var showPage = 1;
	var searchText = 'default';
	var teamIdx = "${teamIdx}";
	listCall(showPage);

	// 검색어에 따른 출력 
	$('#searchButton').click(function(){
		//검색어 확인 
		searchText = $('#searchInput').val();
		console.log(searchText);
		listCall(showPage);
		$('#pagination').twbsPagination('destroy');
	});
		
	function listCall(page){
		$.ajax({
			type:'post',
			url:'warningList.ajax',
			data:{
				'page':page,
				'teamIdx':teamIdx,
				'searchText':searchText
			},
			dataType:'json',
			success:function(data){
				console.log(data);
				listPrint(data.list);			
				
				//paging plugin
				$('#pagination').twbsPagination({
					startPage:1,	//시작페이지
					totalPages:data.pages,//총 페이지 수
					visiblePages:5, //보여줄 페이지 [1][2][3][4][5]
					onPageClick:function(event,page){// 페이지 클릭시 동작되는 함수(콜백)
						console.log(page, showPage);
						if(page != showPage){
							showPage = page;	
							listCall(page);							
						}				
					}
				});	
			},
			error:function(e){
				console.log(e);
			}
		});
	}
	
	var loginId = $('#loginId').val();
	var teamGrade;
	console.log(loginId);
	
	function listPrint(list){
		var content = '';
		
		list.forEach(function(list){
			content +='<tr>';
			
			if(list.teamGrade == 'leader'){
				teamGrade = '팀장';
			}else if(list.teamGrade == 'deputyLeader'){
				teamGrade = '부팀장';
			}else if(list.teamGrade == 'temporaryLeader'){
				teamGrade = '임시팀장';
			}else{
				teamGrade = '팀원';
			}
			
			content +='<td>'+teamGrade+'</td>';
			content +='<td><a href="../userprofile.go?userId='+list.userId+'">'+list.userId+'</a></td>';
			content += '<td><button onclick="window.open(\'warning.go?userId='+list.userId+'&teamIdx='+teamIdx+'\',\'경고\',\'width=550px,height=530px\')" style="margin: 10px; font-size: 15;" class="btn btn-warning">경고</button></td>';
			if(list.warningCount < 1){
				content += '<td><button disabled="true" onclick="window.open(\'warningCancel.go?userId='+list.userId+'&teamIdx='+teamIdx+'\',\'경고 취소\',\'width=550px,height=280px\')" style="margin: 10px; font-size: 15;" class="btn btn-warning">취소</button></td>';
			}
			if(list.warningCount >= 1){
				content += '<td><button onclick="window.open(\'warningCancel.go?userId='+list.userId+'&teamIdx='+teamIdx+'\',\'경고 취소\',\'width=550px,height=280px\')" style="margin: 10px; font-size: 15;" class="btn btn-warning">취소</button></td>';
			}
			
			content +='<td><a href="./warningDetail.go?userId='+list.userId+'&teamIdx='+teamIdx+'">'+list.warningCount+'</a></td>';
			
			if(list.warningCount >= 5){
				content += '<td><button onclick="window.open(\'remove.go?userId='+list.userId+'&teamIdx='+teamIdx+'\',\'강퇴\',\'width=550px,height=280px\')" style="margin: 10px; font-size:15;" class="btn btn-danger">강퇴</button></td>';
			}
			if(list.warningCount < 5){
				content += '<td><button disabled="true" onclick="window.open(\'remove.go?userId='+list.userId+'&teamIdx='+teamIdx+'\',\'강퇴\',\'width=550px,height=280px\')" style="margin: 10px; font-size:15;" class="btn btn-danger">강퇴</button></td>';
			}
			
			content +='</tr>';
		}); 
		$('#list').empty();
		$('#list').append(content);

	}
	

		

	
	var msg = "${msg}";
	console.log(msg);
	if(msg != ''){
		alert(msg);
	}

</script>
</html>