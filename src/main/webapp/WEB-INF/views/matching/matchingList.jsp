<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<meta charset="UTF-8">
<title>🏀 당근농장</title>


	<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
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
		height:83%;
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
		width:95%;
		height:90%;
		text-align:center;
	}
	
	#gamePlay, #sort{
		width: 100px;
    	height: 30px;
    	margin : 5px;
	}
	
	#searchInput{
		width: 200px;
    	height: 30px;
    	margin : 5px;
	}
	
	#searchButton, #writeButton {
		font-size: 15px;
		height: 30px;
    	margin : 5px;
	
	}
	
	#writeButton {
		float:right;
		margin-right : 50px;
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
	    <a href="/cf/matching/list.do">개인 모집글</a> 
	      <br/><br/>
	    <a href="/cf/matching/teamList.do" >팀 모집글</a>
	    
	</div>
	
	
	<div id="content">
		<div id="filter">
		<select id="gamePlay">
		  <option value="default">경기방식</option>
		  <option value="1">1:1</option>
		  <option value="3">3:3</option>
		  <option value="5">5:5</option>
		</select>
		
		<select id="sort">
		  <option value="default">지역</option>
		  <option value="${userData.locationIdx}">선호지역</option>
		  <c:forEach items="${locationList}" var="locationList">
		  	<option value="${locationList.locationIdx}">${locationList.gu}</option>	
		  </c:forEach>
		</select>
	
		
		<input type="text" id="searchInput" placeholder="제목 또는 작성자를 입력">
		<button id="searchButton" class="btn btn-outline-dark">검색</button>
		<c:if test="${loginId != null }">
			<button id="writeButton" class="btn btn-outline-dark" onclick="location.href='write.go?categoryId=m01'">글쓰기</button>
		</c:if>
		</div>
	
		<hr/>
		<table>
		<thead>
				<tr>
					<th style="width:10%;">경기방식</th>
					<th style="width:10%;">경기장위치</th>
					<th style="width:10%;">모집인원수</th>
					<th style="width:35%;">제목</th>
					<th style="width:20%;">경기 일시</th>
					<th style="width:10%;">글쓴이</th>
					<th style="width:5%;">조회수</th>
				</tr>
			</thead>
				
				<tr>
					<th colspan="7"> <hr/> </th>
				</tr>
				
			<tbody>
				
				
				<tbody id="list">			
				
				<!-- list 출력 위치 -->
				
				</tbody>
				
				
				
				
				<tr>
				  <th colspan="7" id="paging" style="text-align:center;">  
				    <div class="container">                 
				    <hr/> 
				      <nav aria-label="Page navigation">
				      	
				        <ul class="pagination justify-content-center" id="pagination"></ul>
				      </nav>
				    </div>
				  </th>
				</tr>
	
	
	
				
			</tbody>		
			
			
		</table>
	</div>
	
</body>

<script>
	
	
var showPage = 1;
var selectedGamePlay = 'default';
var selectedSort = 'default';
var categoryId = 'm01';
var searchText = 'default';
console.log(selectedGamePlay);
listCall(showPage);

//검색어에 따른 출력 
$('#searchButton').click(function(){
	//검색어 확인 
	searchText = $('#searchInput').val();
	listCall(showPage);
	searchText = 'default';
	$('#pagination').twbsPagination('destroy');
});

// 경기 방식 선택에 따른 출력
$('#gamePlay').change(function(){
	selectedGamePlay = $(this).val();
	listCall(showPage);
	$('#pagination').twbsPagination('destroy');
});

$('#sort').change(function(){
	selectedSort = $(this).val();
	console.log(selectedSort);
	listCall(showPage);
	$('#pagination').twbsPagination('destroy');
});



function listCall(page){
   $.ajax({
      type:'post',
      url:'list.ajax',
      data:{
    	  'page':page,
    	  'gamePlay':selectedGamePlay,
    	  'categoryId':categoryId,
    	  'locationIdx':selectedSort,
    	  'search':searchText
      },
      dataType:'json',           
      success:function(data){
         console.log(data);
         listPrint(data.list);
         
         // 페이징 처리를 위해 필요한 데이터
         // 1. 총 페이지의 수
         // 2. 현재 페이지
         
         // Paging Plugin (j-query의 기본기능을 가지고 만들었기 때문에  plugin)
         $('#pagination').twbsPagination({
			startPage:1, // 시작 페이지
			totalPages:data.pages,// 총 페이지 수 
			visiblePages:5,// 보여줄 페이지
			onPageClick:function(event,page){ // 페이지 클릭시 동작되는 (콜백)함수
				console.log(page,showPage);
				if(page != showPage){
					showPage=page;
					listCall(page);
					
				}
			}
         });
      }
   });
}

function listPrint(list){
	var content ='';
	
	list.forEach(function(item,idx){
		
		
		content +='<tr>';
		content +='<td id="gamePlay">'+item.gamePlay+':'+item.gamePlay+'</td>';
		content +='<td>'+item.gu +'</td>';
		content +='<td id="gamePlayer"> ' + item.matchingNumforSure +'/'+ item.matchingNum+ '</td>';
		content +='<td id="subject" style="text-align:left; padding-left:30px;"><a href="detail.go?matchingIdx='+ item.matchingIdx+'">'+item.subject+'</a></td>';
		content +='<td>'+item.gameDate+'</td>';
		content += '<td id="writerId"><a href="#" onclick="window.open(\'../userprofilepop.go?userId=' + item.writerId + '\',\'회원프로필\',\'width=400px,height=600px\')">' + item.writerId + '</a></td>';
		content +='<td>'+item.bHit+'</td>';
		content +='</tr>';
		
	});
	$('#list').empty();
	$('#list').append(content);
}
	



</script>
</html>