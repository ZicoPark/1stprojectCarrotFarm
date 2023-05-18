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
	
	table{
		width:95%;
		height:90%;
		text-align:center;
		
		border-collapse : collapse;
		padding : 15px;
		margin : 30px 10px 10px 30px;
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
	
	</hr>
	<div id="content">
	<select style="float:right;" name="reportState" id="reportState">
		 <option value="default">신고상태</option>
         <option value="미처리">미처리</option>
         <option value="처리중">처리중</option>
         <option value="처리완료">처리완료</option>
      </select>
      
      <select style="float:right;" name="category" id="category">
		 <option value="default">카테고리 종류</option>
         <option value="rm">모집글</option>
         <option value="rb">게시판</option>
         <option value="rc">댓글</option>
         <option value="ru">유저</option>
         <option value="rr">경기장 리뷰</option>
      </select>
      
      <select name="searchCategory" id="searchCategory">
		 <option value="default">검색조건</option>
         <option value="userId">신고자 아이디</option>
         <option value="reportUserId">대상자 아이디</option>
      </select>
      
    <input type="text" id="searchInput">
   	<button id="searchButton" class="btn btn-outline-dark">검색</button>
	<table>
		<tr>
			<th>no</th>
			<th>신고자 ID</th>
			<th>신고 내용</th>
			<th>신고 대상자ID</th>
			<th>카테고리</th>
			<th>신고 상태</th>
		</tr>
		
		<tbody>
			
			
			<tbody id="list">			
			
			<!-- list 출력 위치 -->
			
			</tbody>
			
			<tr>
			  <th colspan="6" id="paging" style="text-align:center">  
			    <div class="container">                  
			      <nav aria-label="Page navigation">
			        <ul class="pagination justify-content-center" id="pagination"></ul>
			      </nav>
			    </div>
			  </th>
			</tr>
		</tbody>	
	
		</tbody>
	</table>
	</div>
</body>
<script>
	var showPage = 1;
	var reportState = 'default';
	var category = 'default';
	var searchCategory = 'default';
	var searchText = 'default';
	
	//검색어에 따른 출력 
	$('#searchButton').click(function(){
		//검색어 확인 
		searchText = $('#searchInput').val();
		searchCategory= $('#searchCategory').val();
		listCall(showPage);
		$('#pagination').twbsPagination('destroy');
	});

	// 신고 상태
	$('#reportState').change(function(){
		reportState = $(this).val();
		searchText = 'default';
		listCall(showPage);
		$('#pagination').twbsPagination('destroy');
	});
	
	// 카테고리
	$('#category').change(function(){
		category = $(this).val();
		searchText = 'default';
		listCall(showPage);
		$('#pagination').twbsPagination('destroy');
	});

	listCall(showPage);
	function listCall(page){
		   $.ajax({
		      type:'post',
		      url:'adminReportList.ajax',
		      data:{
		    	  'page':page,
		    	  'category':category,
		    	  'searchText':searchText,
		    	  'searchCategory':searchCategory,
		    	  'reportState':reportState
		      },
		      dataType:'json',           
		      success:function(data){
		         console.log(data);
		         listPrint(data.list);
		         $('#pagination').twbsPagination({
					startPage:1, // 시작 페이지
					totalPages:Math.ceil(data.totalList/10),// 총 페이지 수 
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
			content +='<td>'+item.reportIdx+'</td>';
			content +='<td>'+item.userId+'</td>';
			content +='<td><a href="adminReportDetail.go?reportIdx='+item.reportIdx+'&reportId='+item.reportId+'&categoryId='+item.categoryId+'&reportUserId='+item.reportUserId+'">'+item.reportContent+'</td>';                                           
			content +='<td>'+item.reportUserId+'</td>';
			if(item.categoryId=='rm'){
				content+='<td>모집글</td>';
			}else if(item.categoryId=='rb'){
				content+='<td>게시판</td>';
			}else if(item.categoryId=='rc'){
				content+='<td>댓글</td>';
			}else if(item.categoryId=='ru'){
				content+='<td>유저</td>';
			}else if(item.categoryId=='rr'){
				content+='<td>경기장 리뷰</td>';
			}
			content +='<td>'+item.reportState+'</td>';
			content +='</tr>';
				
			
		});
		$('#list').empty();
		$('#list').append(content);
	}
	var adminRight="${sessionScope.adminRight}";
	console.log("왜 안될까요?? "+adminRight);
	if(adminRight==''){
	   location.href="/cf/";
	}
</script>
</html>