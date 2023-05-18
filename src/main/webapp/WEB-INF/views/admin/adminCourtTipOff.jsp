<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>🏀 당근농장</title>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>  
<script src="resources/js/jquery.twbsPagination.js" type="text/javascript"></script>
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
	<a style="font-size : 35px;" href="adminCourt">경기장 리스트</a>
	<a style="font-size : 35px; color:orange; margin-left:10px;" href="adminCourtTipOff">경기장 제보</a>
	<table  style="width:100%;">
		<tr>
			<th>경기장 이름</th>
			<th>경기장 주소</th>
			<th>제보자 닉네임</th>
			<th>등록</th>
			<th>삭제</th>			
		</tr>
	<tbody id="courtTipOffList">
		
	</tbody>
	
	<tbody>
		<tr>
				<th colspan="5" id="paging">	
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
var showPage = 1;
listCall(showPage);


function listCall(page){
	$.ajax({
		type:'post',
		url:'adminCourtTipOff.ajax',
		data:{
			'page':page
		},
		dataType:'json',
		success:function(data){
			console.log(data);
			console.log(data.courtTipOffList);
			courtListDraw(data.courtTipOffList);
			//paging plugin
			$('#pagination').twbsPagination({
				startPage:page,	//시작페이지
				totalPages:Math.ceil(data.courtTipOffCnt/10),//총 페이지 수
				visiblePages:5, //보여줄 페이지 [1][2][3][4][5]
				onPageClick:function(event,page){// 페이지 클릭시 동작되는 함수(콜백)
					console.log(page, showPage);
					if(page != showPage){
						showPage = page;
						listCall(showPage,);
						
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
	$('#courtTipOffList').empty();
	list.forEach(function(item,index){
		content += '<tr>';
		content += '<td>'+item.courtName+'</td>';
		content+='<td>'+item.courtAddress+'</td>';
		content+='<td>'+item.userId+'</td>';
		content +='<th><button class="btn btn-outline-dark" onclick=location.href="adminCourtTIpOffRegist.go?courtTipOffIdx='+item.courtTipOffIdx+'">등록</button></th>';
		content +='<th><button class="btn btn-outline-dark" onclick=location.href="adminCourtTipOffDelete.do?courtTipOffIdx='+item.courtTipOffIdx+'">삭제</button></th>';
		
	});
	
	$('#courtTipOffList').append(content);
}
var adminRight="${sessionScope.adminRight}";
console.log("왜 안될까요?? "+adminRight);
if(adminRight==''){
   location.href="/cf/";
}



</script>
</html>