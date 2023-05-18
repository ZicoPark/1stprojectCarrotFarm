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
	}
	
	#content {
		width:82%;
		height : 85%;
		background-color: #f8f9fa;
		padding: 15 30 10;
		float:right;
	}
	
	#LNB {
		width:16%;
		height : 85%;
		background-color: #f8f9fa;
		float:left;
		margin : 0px 0px 5px 5px;
	}
	
	#LNB ul li {
	margin-top : 30px;
    margin-bottom: 40px; /* 원하는 줄간격 크기 */
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
		width:98%;
		height:60%;
		text-align:center;
		border : 3px solid black;	
		border-collapse : collapse;
		padding : 15px 10px;
	}
	
	#teamfreeboardSearchInput{
		width: 200px;
    	height: 30px;
	}
	
	#teamfreeboardSearchButton {
		height: 30px;
	}
</style>
</head>
<body>

	<%@ include file="../GNB.jsp" %>
	

	<div id="LNB">
		 <ul style="list-style-type: none;">
	      <li>
	        <div style="width: 180px; height: 150px; border : 1px solid black; border-collapse: collapse;">프로필</div>
	      </li>
	      
	      <li >
	        <a href="/cf/" style="font-weight: bold; font-size: 20px ; color: black;">팀소개</a>
	      </li>
	      
	      <li>
	        <a href="/cf/" style="font-weight: bold; font-size: 20px; color: black;">팀원</a>
	      </li>
	      
	      <li>
	        <a href="/cf/" style="font-weight: bold; font-size: 20px; color: black;">참여 경기</a>
	      </li>
	      
	      <li >
	        <a href="/cf/teamnoticeboardList.do" style="font-weight: bold; font-size: 20px ; color: black;">팀 공지 사항</a>
	      </li>
	      
	      <li>
	        <a href="/cf/teamfreeboardList.do" style="font-weight: bold; font-size: 20px; color: orange;">팀 자유 게시판</a>
	      </li>
	      
	      <li>
	        <a href="/cf/teampictureboardList.do" style="font-weight: bold; font-size: 20px; color: black;">팀 사진첩</a>
	      </li>
	      
	      <li>
	        <a href="/cf/teaminquiryboardList.do" style="font-weight: bold; font-size: 20px; color: black;">팀 문의</a>
	      </li>

	    </ul>
	</div>
	
	<div id="content">

	<br/>
	<input type ="text" id="teamfreeboardSearchInput" placeholder="제목 또는 닉네임을 입력">
	<button id ="teamfreeboardSearchButton">검색</button>

	<br/>
	<br/>
	<c:if test="${loginId != null }">
	<button onclick="location.href='teamfreeboardWrite.go'">글쓰기 등록</button>
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
var searchText = 'default';
var showPage = 1;
listCall(showPage);

$('#teamfreeboardSearchButton').click(function(){
	searchText = $('#teamfreeboardSearchInput').val();
	listCall(showPage);
	$('#pagination').twbsPagination('destroy');
});

function listCall(page){
	$.ajax({
		type:'post',
		url:'tflist.ajax',
		data:{
			'page':page,
			'search':searchText
		},
		dataType:'json',
		success:function(data){
			console.log(data);
			console.log(data.teamfreeboardList);
			listPrint(data.teamfreeboardList);
			
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

function listPrint(tfalist){
	var content = '';

	tfalist.forEach(function(item,idx){
		content +='<tr>';
		content +='<td>'+item.boardIdx+'</td>';
		content +='<td><a href="teamfreeboardDetail.do?bidx='+item.boardIdx+'">'+item.subject+'</a></td>';
		content +='<td>'+item.userId+'</td>';
		

		var date = new Date(item.writeTime);
		content +='<td>'+date.toLocaleDateString('ko-KR')+'</td>';
		content +='<td>'+item.bHit+'</td>';
		content +='<tr>';
	});
	$('#list').empty();
	$('#list').append(content);
}
</script>
</html>