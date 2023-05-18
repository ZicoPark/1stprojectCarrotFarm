<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>🏀 당근농장</title>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>    
<script src="resources/js/jquery.twbsPagination.js" type="text/javascript"></script>

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
		height : 87%;
		background-color: #f8f9fa;
		padding: 10 30 10;
		margin : 5px;
		float:right;
		
	}
	
	#LNB {
		width:20%;
		height : 87%;
		background-color: #f8f9fa;
		float:left;
		margin : 5px;
		font-weight: bold;
        font-size: 15px;
		text-align:center;
		
	}
	
	#LNB ul li {
	margin-top : 30px;
    margin-bottom: 90px; /* 원하는 줄간격 크기 */
	}
	
	
		th, td {
		margin : 10px;
		border : 1px solid black;	
		padding : 10px 10px;
		border-collapse : collapse;
		border-left: none;
    	border-right: none;
	}
	
	table{
		width:95%;
		height:70%;
		text-align:center;

		border-collapse : collapse;
		padding : 15px 10px;
	}
	
	#gamePlay, #sort{
		width: 100px;
    	height: 30px;
    	margin : 5px;
	}
	
	#teamnoticeboardSearchInput{
		width: 200px;
    	height: 30px;
    	
	}
	
	#teamnoticeboardSearchButton, #registerBtn {
		font-size: 15px;
		height: 30px;
		margin : 5px;
	
	}
	
	#registerBtn {
		float:right;
		margin-right : 60px;
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
	        <a href="/cf/team/teamPage.go?teamIdx=${teamIdx}" style="font-weight: bold; font-size: 18px; color: black;">팀소개</a>
	      <br/><br/>
	        <a href="/cf/team/teamUserList.go?teamIdx=${teamIdx}" style="font-weight: bold; font-size: 18px; color: black;">팀원</a>
	      <br/><br/>
	        <a href="/cf/team/teamGame.go?teamIdx=${teamIdx}" style="font-weight: bold; font-size: 18px; color: black;">참여 경기</a>
	      <br/><br/>
	        <a href="/cf/teamnoticeboardList.do?teamIdx=${teamIdx}" style="font-weight: bold; font-size: 18px ; color: orange;">팀 공지 사항</a>
	      <br/><br/>
	        <a href="/cf/teampictureboardList.do?teamIdx=${teamIdx}" style="font-weight: bold; font-size: 18px; color: black;">팀 사진첩</a>
	</div>
	
	<div id="content">

	<br/>
	<input type ="text" id="teamnoticeboardSearchInput" placeholder="제목 또는 닉네임을 입력">
	<button class="btn btn-outline-dark" id ="teamnoticeboardSearchButton">검색</button>
	
	<br/>
	<br/>
	<c:if test="${loginId != null }"> <!-- teamIdx 써야할듯 -->	
	<button class="btn btn-outline-dark" id="registerBtn" onclick="location.href='teamnoticeboardWrite.go?teamIdx=${teamIdx}'">공지사항 등록</button>
	</c:if>
	<br/>
	<br/>
	<table>
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
		</thead>
		<tbody id="list">
			
		</tbody>
		<tr>
			<td colspan="5" id="paging" style="text-align:center">	
				<div class="container" style="text-align: center;">									
					<nav aria-label="Page navigation" style="display: inline-block;">
						<ul class="pagination" id="pagination"></ul>
					</nav>
				</div>
			</td>
		</tr>
	</table>
	</div>
</body>
<script>
gradeCheck();
var teamIdx="${teamIdx}";
console.log("받아온 팀idx :" +teamIdx);
var searchText = 'default';
var showPage = 1;
listCall(showPage);

$('#teamnoticeboardSearchButton').click(function(){
	searchText = $('#teamnoticeboardSearchInput').val();
	listCall(showPage);
	$('#pagination').twbsPagination('destroy');
});

function gradeCheck(){
	console.log("함수 실행");
	$.ajax({
		type:'post',
		url:'tnuserRight.ajax',
		data:{},
		dataType:'json',
		success:function(data){
			console.log("팀장 정보  :"+data);
			if (data != "leader") {
				
				document.getElementById("registerBtn").style.display = "none";
			}
		},
		error:function(e){
			console.log(e);
		}
	});
	
}


function listCall(page){
	$.ajax({
		type:'post',
		url:'tnlist.ajax',
		data:{
			'page':page,
			'search':searchText,
			'teamIdx':teamIdx
		},
		dataType:'json',
		success:function(data){
			console.log(data);
			console.log(data.teamnoticeboardList);
			listPrint(data.teamnoticeboardList);
			
			$('#pagination').twbsPagination({
				startPage:data.currPage, 
				totalPages:data.pages, 
				visiblePages:5,
				onPageClick:function(event,page){
					console.log(page,showPage);
					if (page != showPage) {
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

function listPrint(tnalist){
	var content = '';

	tnalist.forEach(function(item,idx){
		content +='<tr>';
		content +='<td>'+item.boardIdx+'</td>';
		content +='<td><a href="teamnoticeboardDetail.do?bidx='+item.boardIdx+'&teamIdx='+teamIdx+'">'+item.subject+'</a></td>';
		content +='<td>'+item.userId+'</td>';
		

		var date = new Date(item.writeTime);
		content +='<td>'+date.toLocaleDateString('ko-KR')+'</td>';
		content +='<td>'+item.bHit+'</td>';
		content +='<tr>';
	});
	$('#list').empty();
	$('#list').append(content);
}

$(document).ready(function() {
	  $('#teamnoticeboardSearchButton').css('margin-top', '+0.5px');
	});
</script>
</html>