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
		height:70%;
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
	&nbsp; &nbsp; &nbsp; &nbsp;
	<div id="content">
	<select name="stateCategory" id="stateCategory">
		 <option value="default">회원상태</option>
         <option value="사용중">사용중</option>
         <option value="탈퇴">탈퇴</option>
         <option value="이용제한1일">이용제한(1일)</option>
         <option value="이용제한3일">이용제한(3일)</option>
         <option value="이용제한5일">이용제한(7일)</option>
         <option value="이용제한30일">이용제한(30일)</option>
         <option value="영구제한">영구제한</option>
      </select>
      &nbsp; &nbsp; 
      <select name="searchCategory" id="searchCategory">
		 <option value="default">검색조건</option>
         <option value="userId">아이디</option>
         <option value="nickname">닉네임</option>
         <option value="email">이메일</option>
      </select>
      &nbsp; &nbsp; 
    <input type="text" id="searchInput">
   	&nbsp; &nbsp; 
   	<button id="searchButton" class="btn btn-outline-dark">검색</button>
	<button onclick="nicknameChange()" style="margin-left : 80%;" class="btn btn-outline-dark">닉네임 변경</button>
	&nbsp; &nbsp; &nbsp; &nbsp; 		
	<button onclick="profileChange()" class="btn btn-outline-dark">프로필 변경</button>
	<table>
		<thead>
			<tr>
				<th><input type="checkbox" id="all"/></th>
				<th>NO</th>
				<th>회원분류</th>
				<th>아이디</th>
				<th>이름</th>
				<th>프로필</th>
				<th>닉네임</th>
				<th>이메일</th>
				<th>닉네임 변경</th>
				<th>사진 변경</th>
				<th>가입일</th>				
			</tr>
		</thead>
		<tbody>
			<tbody id="list">			
			
			<!-- list 출력 위치 -->
			
			</tbody>
			
			<tr>
			  <th colspan="11" id="paging" style="text-align:center">  
			    <div class="container">                  
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
var stateCategory = 'default';
var searchCategory = 'default';
var searchText = 'default';

listCall(showPage);

//검색어에 따른 출력 
$('#searchButton').click(function(){
	//검색어 확인 
	searchText = $('#searchInput').val();
	searchCategory = $('#searchCategory').val();
	listCall(showPage);
	$('#pagination').twbsPagination('destroy');
});

// 유저 상태 선택에 따른 출력
$('#stateCategory').change(function(){
	stateCategory = $(this).val();
	searchText="default";
	listCall(showPage);
	$('#pagination').twbsPagination('destroy');
});

function listCall(page){
   $.ajax({
      type:'post',
      url:'adminUserList.ajax',
      data:{
    	  'page':page,
    	  'stateCategory':stateCategory,
    	  'searchCategory':searchCategory,
    	  'searchText':searchText,
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
		content +='<td><input type="checkbox" value="'+item.userId+'"</td>';
		content +='<td>'+item.userIdx+'</td>';
		content +='<td>'+item.userState+'</td>';
		content +='<td><a href="#" onclick="window.open(\'userprofilepop.go?userId='+item.userId+'\',\'width=300px,height=200px\')"/>'+item.userId+'</td>';
		content +='<td>'+item.userName+'</td>';
		console.log(item.photoName);
		if(item.photoName==null){
			content+='<td>사진없음</td>';
		}else{
			content +='<td><img src="/photo/'+item.photoName+'" width="50px" alt="사진" /></td>';
			
		}
		content +='<td>'+item.nickname+'</td>';
		content +='<td>'+item.email+'</td>';
		content +='<td><button class="btn btn-outline-dark" onclick=location.href="adminNicknameChange.do?userIdx='+item.userIdx+'&userId='+item.userId+'">닉네임 변경</button></td>';
		content +='<td><button class="btn btn-outline-dark" onclick=location.href="adminprofileChange.do?userIdx='+item.userIdx+'&userId='+item.userId+'">프로필 변경</button></td>';
		content +='<td>'+item.userJoinDate+'</td>';
		content +='</tr>';
		
	});
	$('#list').empty();
	$('#list').append(content);
}

$('#all').click(function(e){
	var $chk = $('input[type="checkbox"]');
	if($(this).is(':checked')){
		$chk.prop('checked',true);
	}else{
		$chk.prop('checked',false);
	}
});

function nicknameChange(){
	var checkArr=[];
	$('input[type="checkbox"]:checked').each(function(idx,item){
		if($(this).val()!='on'){
			checkArr.push($(this).val());
		}
	});
	console.log(checkArr);
	$.ajax({
		type : 'get',
		url:'adminNicknamesChange.ajax',
		data:{
			'nickChangeList':checkArr
		},
		dataType:'json',
		success:function(data){
			console.log(data);
			location.reload();
		},
		error:function(e){
			console.log(e);
		}
	});
}

function profileChange(){
	var checkArr=[];
	$('input[type="checkbox"]:checked').each(function(idx,item){
		if($(this).val()!='on'){
			checkArr.push($(this).val());
		}
	});
	console.log(checkArr);
	$.ajax({
		type : 'get',
		url:'adminProfilesChange.ajax',
		data:{
			'profileChangeList':checkArr
		},
		dataType:'json',
		success:function(data){
			console.log(data);
			location.reload();
		},
		error:function(e){
			console.log(e);
		}
	});
}
$(document).ready(function() {
	  $('#searchButton').css('margin-top', '+0.5px');
	});
var adminRight="${sessionScope.adminRight}";
console.log("왜 안될까요?? "+adminRight);
if(adminRight==''){
   location.href="/cf/";
}

</script>
</html>