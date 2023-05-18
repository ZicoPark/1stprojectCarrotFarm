<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<meta charset="UTF-8">
<title>🏀 당근농장</title>
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<!-- Datetimepicker 라이브러리 불러오기 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.full.min.js"></script>

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
	
	#dcontent {
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
	

	#gamePlay, #sort{
		width: 100px;
    	height: 30px;
    	margin : 5px;
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
	
	input[type=text],input[type=datetime], select {
    	height: 30px;
    	margin-left: 10px;
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
	
	<div id="dcontent">
		<br/>
		<h2 style="display:inline;">모집글 수정</h2> &nbsp; &nbsp; 수정시 경기 참가자, 신청자에게 수정 알림이 전송됩니다. 
		<hr/>
		
	<form method="post" action="update.do?matchingIdx=${dto.matchingIdx}" style="background-color:white; height:80%; margin: auto;">
		<br/>
		<div>		
		&nbsp; &nbsp; <input type="text" name="subject" id="subject" style="width:40%;" placeholder="제목을 입력해주세요" value="${dto.subject}">
		<input type="datetime" name="gameDate" id="date" style="width:20%;"  placeholder="경기 일시" value="${dto.gameDate}"> ${dto.teamName}
		<input type="text" name="writerId" value="${loginId}" style="border:none;" hidden readonly >


		<select name="gamePlay" id="gamePlay">
			<option value="none">경기방식</option>
			<option value="3" id="3">3:3</option>
			<option value="5" id="5">5:5</option>
		</select>
		👤<input type="text" name="matchingNum" id="matchingNum" style="width:5%;  border:none;" value ="${dto.matchingNum}" readonly><br>

		&nbsp; &nbsp; <select name="courtListType" id="courtListType">
		  <option value="none">경기장</option>
		  <option value="loc">선호지역</option>
		  <option value="searchLoc">위치 선택</option>
		  <option value="listAll">전체보기</option>
		</select>
		
		<select name="locationIdx" id="locationIdx">
		  <option value="none">지역구</option>
		</select>
		
		
		
		<select name="courtIdx" id="courtIdx">
			<option value="${dto.courtIdx}">${dto.courtName}</option>
			<c:forEach items="${courtList}" var="court">
				<c:if test="${court.locationIdx == teamData.locationIdx}">
					<option value="${court.courtIdx}">${court.courtName}</option>
				</c:if>
			</c:forEach>
		</select>
		</div>
		<hr/>

		<div style="text-align:center; margin:auto;">
			<textarea name="content" id ="content" style="width:95%; height:55%" placeholder="경기모집에 관련된 설명을 작성해주세요">${dto.content}</textarea><br>
			<br>
			<input type="button" value="작성" onclick="subChk()">
		</div>
	</form>
	</div>
</body>




<script>
	
	
	
	/* 경기장 선택 방법 선택(선호위치, 선택, 전체 보기) */
	
	var content='';
	var listType = '';
	
	$('#courtListType').on('change', function() {
		
	    listType = $(this).val();
	    
	    if(listType=='loc'){
	    	content += '<select name="locationList" id="locationIdx">';
    		content += '<option value="${teamData.locationIdx}">${teamData.gu}</option>';
	    	content += '</select>';	    	
	    	$('#locationIdx').replaceWith(content);
	    	content='';
	    	
	    	
	    }else if(listType=='searchLoc'){
	    	content += '<select name="locationList" id="locationIdx">';
	    	content += '<option value="none">지역구</option>';
	    	content += '<c:forEach items="${locationList}" var="list">';
    		content += '<option value="${list.locationIdx}">${list.gu}</option>';
    		content +=	'</c:forEach>';
	    	
    		$('#locationIdx').replaceWith(content);
	    	content='';
	    	
	    	
	    	
	    }else if(listType=='listAll'){
	    	content += '<select name="locationList" id="locationIdx">';
    		content += '<option value="none">전체</option>';
    		content += '</select>';	
    		$('#locationIdx').replaceWith(content);
	    	content='';
	    	
	    	content += '<select name="courtIdx" id="courtIdx">';
	        content += '<option value="none">경기장</option>';
	        content += '<c:forEach items="${courtList}" var="court">';
	        content += '<option value="${court.courtIdx}">${court.courtName}</option>';
	        content += '</c:forEach>';
	        content += '</select>';
	        $('#courtIdx').replaceWith(content);
	    	content='';
	    	
	    }
	    
	    $('#locationIdx').on('change', function(){
	    	
	    	var locIdx = $(this).val();
	       console.log(locIdx);

	       for(var i = 1; i<26; i++){
	    	    if(locIdx==i){
		    	content += '<select name="courtIdx" id="courtIdx">';
		        content += '<option value="none">경기장</option>';
		        content += '<c:forEach items="${courtList}" var="court">';
		        var locIdxchk = '${court.locationIdx}';
		        if(locIdx==locIdxchk){ 
		        	content += '<option value="${court.courtIdx}">${court.courtName}</option>';
		        }
		        content += '</c:forEach>';
		        content += '</select>';
		        $('#courtIdx').replaceWith(content);
		    	content='';
		       }
	    	}
	           
	    });
	    
	});

	function subChk(){
		console.log($('#subject').val());
		console.log($('#date').val());
		console.log($('#gamePlay').val());
		console.log($('#courtIdx').val());
	if($('#subject').val()==''){
		alert('제목을 입력해주세요.');
		return false;
	}else if($('#date').val()==''){
		alert('경기 날짜와 시간을 선택해주세요.');
		return false;
	}else if($('#gamePlay').val()=='none'){
		alert('경기 방식을 선택 해주세요.');
		return false;
	}else if($('#courtIdx').val()=='none'){
		alert('경기장을 선택해주세요.');
		return false;
	}else{
		$('form').submit();
	}

}
	
	
		var gamePlaySelected = document.getElementById("gamePlay");
		var matchingNum = document.getElementById("matchingNum");

		gamePlaySelected.addEventListener("change", function() {
			var selectedOption = gamePlaySelected.options[gamePlaySelected.selectedIndex];
			var recruitNum = selectedOption.value * 2;
			matchingNum.value = recruitNum.toString();
		});
		
		
		
		 $(function() {
			    $('#date').datetimepicker({
			      format: 'Y-m-d H:i',  // 입력값의 형식을 지정
			      lang: 'ko',  // 언어 설정
			      step: 30,  // 분 단위로 선택 가능한 간격을 지정
			      dayOfWeekStart: 1,  // 주의 시작일을 월요일로 설정
			      minDate: 0,  // 오늘 이후의 날짜만 선택 가능하도록 설정
			      allowTimes: [
			        '09:00', '10:00', '11:00', '12:00', '13:00',
			        '14:00', '15:00', '16:00', '17:00', '18:00',
			        '19:00', '20:00', '21:00', '22:00', '23:00'
			      ]  // 선택 가능한 시간을 지정
			    });
			  });
		
		 function gps(){
				var dto = '${dto.gamePlay}';
			 	console.log(dto);
			 	
			 	if(dto=='3'){
			 		$('#3').prop('selected',true);
			 	} else if(dto=='5'){
			 		$('#5').prop('selected',true);
			 	} else {
			 		
			 	}
			 };
			 
			 $(document).ready(function() {
					gps();
			});
		 
		 

		
	</script>
</html>