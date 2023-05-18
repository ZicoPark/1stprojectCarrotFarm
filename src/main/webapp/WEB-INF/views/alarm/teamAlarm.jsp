<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<meta charset="UTF-8">
<title>🏀 당근농장</title>

	<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
	<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>    
	<script src="./resources/js/twbsPagination.js" type="text/javascript"></script>
	
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
	
	
	table, th, td{
		margin : 5px;
		padding : 3px;
	}
	
	table{
		width:95%;
		height:90%;
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
           <a href="/cf/userinfo.go">회원 정보</a>
           <br/><br/>
           <a href="/cf/userprofile.go?userId=${loginId}">회원 프로필</a>
           <br/><br/>
           <a href="/cf/userNoticeAlarm">알림</a>
           <br/><br/>
           <a href="/cf/allgames">참여 경기</a>
           <br/><br/>
           <a href="/cf/mygames">리뷰</a>
           <br/><br/>
   </div>
	
	
	<div id="content">
	<br/>
		<ul class="nav nav-tabs">
		  <li class="nav-item">
		    <a class="nav-link " href="/cf/userNoticeAlarm">공지사항</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link " href="/cf/userGameAlarm">경기알림</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" href="/cf/userWarningAlarm">경고알림</a>
		  </li>
		  <li class="nav-item">
		    <a style="font-size:17px; font-weight:700;" class="nav-link active" href="/cf/userTeamAlarm">팀 알림</a>
		  </li>
		</ul>
		<!-- </br>
		<h2 style="margin:10px;">경기 알림</h2>
		<hr/> -->
		<table>
			<thead>
					<tr>
						<th style="width:10%; text-align:left;"><input type="checkbox" id="all" /> &nbsp; <button style="font-size:15px;" class="btn btn-outline-dark" onclick="del()">삭제</button></th>
						<th style="width:10%; text-align:left;">No</th>
						<th style="width:20%;">팀</th>
						<th style="width:60%;">알림내역</th>
					</tr>
				</thead>
				<tr>
					<th colspan="4"> <hr/> </th>
				</tr>
				<tbody>
				
				
				<tbody id="list">			
				
				<!-- list 출력 위치 -->
				
				</tbody>
				
				
				
				
				<tr>
				  <th colspan="4" id="paging" style="text-align:center;">  
				    <div class="container" >    
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
var userId = '${loginId}';
console.log(userId);
listCall(showPage);

function listCall(page){
   $.ajax({
      type:'post',
      url:'userTeamAlarm.ajax',
      data:{
    	  'page':page,
    	  'userId':userId
      },
      dataType:'json',           
      success:function(data){
         console.log(data);
         listPrint(data.list);
         
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
	
	if(list.length==0){
		content +='<tr>';
		content +='<th colspan="4"> 확인할 알림이 없습니다. </th>';
		content +='</tr>';
	}else{
		list.forEach(function(item,idx){
		
		
		content +='<tr>';
		content +='<td style="text-align:left;"><input type="checkbox" value="'+item.alarmIdx+'">&nbsp&nbsp&nbsp&nbsp</td>';
		content +='<td>'+item.alarmIdx+'</td>';
		content +='<td> <a href="team/teamPage.go?teamIdx='+item.teamIdx+'">'+item.teamName+'</a></td>';
		content +='<td>'+item.alarmcontent+'</td>';
		content +='</tr>';
	});
}
	
	
	$('#list').empty();
	$('#list').append(content);
} 
	
$('#all').click(function(e){
	var $chk = $('input[type="checkbox"]');
	console.log($chk);
	if($(this).is(':checked')){
		$chk.prop('checked',true);
	}else{
		$chk.prop('checked',false);
	}
});	

function del(){
	 
	 var checkArr = [];
	 
	 // checkbox에 value를 지정하지 않으먄 스스로를 on으로 지정한다. 
	 $('input[type="checkbox"]:checked').each(function(idx,item){
		if($(this).val() != 'on'){
			checkArr.push($(this).val());
		}
		 
	 });
	 
	 console.log(checkArr);
	 
	$.ajax({
		type:'get',
		url:'deleteAlarm.ajax',
		data:{'delList':checkArr},
		dataType:'json',
		success:function(data){
			console.log(data);
			if(data.success){
				alert(data.msg);
				
				listCall(showPage);
			}
		},
		error:function(e){
			console.log(e);
		}
	});
	
}
</script>
</html>