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
		margin : 15px;
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
		border : 3px solid black;	
		border-collapse : collapse;
		padding : 20px 10px;
	}
	
	#gamePlay, #sort{
		width: 100px;
    	height: 30px;
    	margin : 5px;
	}
	
	#freeboardSearchInput{
		width: 200px;
    	height: 30px;
    	
	}
	
	#listButton, #saveButton {
		font-size: 15px;
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
	     <a href="/cf/noticeboardList.do" style="font-weight: bold; font-size: 18px; color: orange;">공지사항</a>
	   	 <br/><br/>
	     <a href="/cf/freeboardList.do" style="font-weight: bold; font-size: 18px ; color: black;">자유 게시판</a>
	     <br/><br/>
	     <a href="/cf/inquiryboardList.do" style="font-weight: bold; font-size: 18px; color: black;">문의</a>

	</div>
	
	<div id="content">
	<form action="noticeboardWrite.do" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
	<input type="hidden" name="categoryId" value="b002"/>
		<table>
			<tr>
				<th>제목</th>
				<td>
					<input type="text" name="subject" id="subjectInput" maxlength="60" style="width : 950px ; height : 30px"
					 	onfocus="hideMessage()" onblur="showMessage()" placeholder="제목은 60자까지 가능합니다"/>
        			<span id="message" style="color: red;"></span>
				</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td><input type="text" name="userId" value="${userId}" style="border:none; background-color: #f8f9fa ; text-align:center;"readonly/></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea name="content" id="contentInput" style="width : 950px; height : 500px; resize: none"/></textarea></td>
			</tr>
			<tr>
				<th>사진</th>
				<td>
					<input type="file" name="photo"/>
				</td>
			</tr>
			<tr>
				<th colspan="2">
					<input type = "button" onclick="location.href='./noticeboardList.do'" value="리스트" class="btn btn-outline-dark" id="listButton"/>
					<button class="btn btn-outline-dark" id="saveButton">저장</button>
				</th>
			</tr>
		</table>
	</form>
	</div>
</body>
<script>
function validateForm() {
	var subject = document.getElementById('subjectInput').value;
	var content = document.getElementById('contentInput').value;
	
	if (subject.trim() == '') {
		alert('제목을 입력해주세요.');
		return false;
	}
	
	if (content.trim() == '') {
		alert('내용을 입력해주세요.');
		return false;
	}
	
	return true;
}

function hideMessage() {
    document.getElementById("message").style.display = "none";
}

function showMessage() {
    document.getElementById("message").style.display = "inline";
}
</script>
</html>