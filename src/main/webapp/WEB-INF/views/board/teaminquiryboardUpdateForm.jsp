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
	        <a href="/cf/teamfreeboardList.do" style="font-weight: bold; font-size: 20px; color: black;">팀 자유 게시판</a>
	      </li>
	      
	      <li>
	        <a href="/cf/teampictureboardList.do" style="font-weight: bold; font-size: 20px; color: black;">팀 사진첩</a>
	      </li>
	      
	      <li>
	        <a href="/cf/teaminquiryboardList.do" style="font-weight: bold; font-size: 20px; color: orange;">팀 문의</a>
	      </li>

	    </ul>
	</div>
	
	<div id="content">
	<form action="teaminquiryboardUpdate.do" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
		<input type = "hidden" name="bidx" value="${dto.boardIdx}"/>
		<table>
			<tr>
				<th>제목</th>
				<td>
					<input type="text" name="subject" value = "${dto.subject}"id="subjectInput" maxlength="60" style="width : 950px ; height : 30px" 
					 	onfocus="hideMessage()" onblur="showMessage()" placeholder="제목은 60자까지 가능합니다"/>
        			<span id="message" style="color: red;"></span>
				</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td><input type="text" name="userId" value = "${dto.userId}" style="border:none; background-color: #f8f9fa ; text-align:center;"readonly/></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea name="content" id="contentInput" style="width : 950px; height : 500px; resize: none">${dto.content}</textarea></td>
			</tr>
			<tr>
				<th>사진</th>
				<td>
					<c:if test="${dto.photoName eq null}">
						<input type="file" name="photo"/>
					</c:if>
					<c:if test="${dto.photoName ne null}">
						<img src = "/photo/${dto.photoName}" style="width: 50%; height: 50%;"/>
					</c:if>
				</td>
			</tr>
			<tr>
				<th colspan="2">
					<button>저장</button>
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

</script>
</html>