<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>🏀 당근농장</title>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
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
		width:100%;
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
	
	
	#gamePlay, #sort{
		width: 100px;
    	height: 30px;
    	margin : 5px;
	}
	
	#searchInput{
		width: 200px;
    	height: 25px;
    	
	}
	
	#searchButton, #writeButton {
		font-size: 15px;
		height: 25px;
		margin : 5px;
	
	}
	
	#writeButton {
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
	<%@ include file="../GNBA.jsp" %>
	
	<div id="content">
	<a style="font-size : 35px; color:orange;" href="adminCourt">경기장 리스트</a>
	<a style="font-size : 35px; margin-left:10px;" href="adminCourtTipOff">경기장 제보</a>

				
	
	<button style="float:right;" class="btn btn-outline-dark" onclick="window.open('adminCourtRegist.go','경기장 등록','width=400px,height=400px')">경기장 등록</button>
	<input style="margin-left: 50px;" id="searchCourt" type="text" name="searchCourt" placeholder="경기장 검색">
	<button id="searchButton" class="btn btn-outline-dark">검색</button>
	<table  style = "width:100%;, height:80%;, text-align:center;, margin : 15px;">
		<tr>

			<th>경기장 이름</th>
			<th>경기장 위치</th>
			<th>사용 여부</th>
			<th>실/내외</th>
			<th>등록/삭제</th>
			<th>수정</th>
			<th>삭제</th>			
		</tr>
	<tbody id="courtList">
		
	</tbody>
	<tbody>
		<tr>
				<th colspan="7" id="paging">	
					<!-- 	플러그인 사용	(twbsPagination)	-->
					<div class="container">									
						<nav aria-label="Page navigation" style="text-align:center">
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
var adminRight="${sessionScope.adminRight}";
console.log("왜 안될까요?? "+adminRight);
if(adminRight==''){
	location.href="/cf/";
}
var showPage = 1;
var courtSearch = 'default';
listCall(showPage);

//검색어에 따른 출력 
$('#searchButton').click(function(){
	//검색어 확인 
	courtSearch = $('#searchCourt').val();
	listCall(showPage);
	$('#pagination').twbsPagination('destroy');
});

function listCall(page){
	$.ajax({
		type:'post',
		url:'adminCourtPage.ajax',
		data:{
			'page':page,
			'courtSearch':courtSearch
		},
		dataType:'json',
		success:function(data){
			console.log(data);
			console.log(data.courtListCnt);
			courtListDraw(data.courtList);
			//paging plugin
			$('#pagination').twbsPagination({
				startPage:1,	//시작페이지
				totalPages:Math.ceil(data.courtListCnt/10),//총 페이지 수
				visiblePages:5, //보여줄 페이지 [1][2][3][4][5]
				onPageClick:function(event,page){// 페이지 클릭시 동작되는 함수(콜백)
					console.log(page, showPage);
					if(page != showPage){
						showPage = page;
						listCall(showPage);
						
					}				
				}
			});	
			
		},
		error:function(e){
			console.log(e);
		}
	});
}
function courtListDraw(list){
	var content = '';
	$('#courtList').empty();
	list.forEach(function(item,index){
		console.log(item.courtDelete);
		content += '<tr>';
		content += '<td>'+item.courtName+'</td>';
		content+='<td>'+item.courtAddress+'</td>';
		content+='<td>'+item.courtState+'</td>';
		if(item.courtInOut=='out'){
			content +='<td>실외</td>';
		}else{
			content +='<td>실내</td>';
		}
		if(item.courtDelete=='1'){
			content +='<td>등록</td>';
			content +='<th><button class="btn btn-outline-dark" onclick=location.href="adminCourtUpdate.go?courtIdx='+item.courtIdx+'">수정</button></th>';
			content +='<th><button class="btn btn-outline-dark" onclick=location.href="adminCourtDelete.do?courtIdx='+item.courtIdx+'">삭제</button></th>';
		}else{
			content +='<td>삭제</td>';
			content +='<th><button class="btn btn-outline-dark" onclick=location.href="adminCourtReRegist.do?courtIdx='+item.courtIdx+'">재등록</button></th>';
			content +='<td>삭제불가</td>';
		}
	});
	
	$('#courtList').append(content);
}

var adminRight="${sessionScope.adminRight}";
console.log("왜 안될까요?? "+adminRight);
if(adminRight==''){
   location.href="/cf/";
}



</script>
</html>