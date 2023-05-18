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
		border : 2px solid black;	
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
		<table>
			<tr>
				<th>제목</th>
				<td>${dto.subject}</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>${dto.userId}</td>
			</tr>
			<tr>
				<th>작성일</th>
				<td>${dto.writeTime}</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>${dto.content}</td>
			</tr>
			<c:if test= "${dto.photoName ne null}">
			<tr>
				<th>사진</th>
				<td><img width = "333" src="/photo/${dto.photoName}"/></td>
			</tr>
			</c:if>
			<tr>
				<th colspan="4">
					<input type = "button" onclick="location.href='./teaminquiryboardList.do'" value="리스트"/>
					&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
						<c:if test="${dto.userId eq loginId || userRight eq 1}">
						<input type = "button" onclick="location.href='./teaminquiryboardUpdate.go?bidx=${dto.boardIdx}'" value="수정"/>
						&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
						<input type = "button" value="삭제" onclick="if(confirm('정말로 삭제하시겠습니까?')){location.href='./teaminquiryboardDelete.do?bidx=${dto.boardIdx}';}">
					</c:if>
				</th>
			</tr>
			<tr>
	     		<th colspan="7">
		     		<table style="width: 100%;">
			     		<c:forEach items="${ticommentList}" var="ticommentList">
			     			<tr>
			     				<th style="width: 18%;">${ticommentList.userId} </th>
			     				<td style="width: 47%;">${ticommentList.commentContent}</td>
			     				<td style="width: 18%;">${ticommentList.commentWriteTime}</td>
			     				<td style="width: 17%;">
			     					<c:if test="${ticommentList.userId eq loginId || userRight eq 1}">
			     						<a  href="teaminquiryboardcommentUpdate.go?commentIdx=${ticommentList.commentIdx}&bidx=${dto.boardIdx}">수정</a> 
			     						/ 
			     						<a href="teaminquiryboardcommentDelete.do?commentIdx=${ticommentList.commentIdx}&bidx=${dto.boardIdx}">삭제</a>
			     					</c:if>    					
			     				</td>
			     			</tr>
			     		</c:forEach>
		     		</table>
		     	</th>	     	
		     </tr>
		     <tr>
		     	<c:if test="${loginId != null}">
			     	<form method="post" action="teaminquiryboardcommentWrite.do?categoryId=b014&comentId=${dto.boardIdx}" >
			     		<td id = "ticommentContent">
			     			<input type="text" name="userId" value="${loginId}" style= "border:none; background-color: #f8f9fa ; text-align:center;" readonly>
			     		</td>
			     		<td colspan="5" id = "tiicommentContent">
			     			<input type="text" name="commentContent" onclick="hideMessage()" onblur="showMessage()" oninput="limitText(this, 255)" placeholder="댓글을 입력하세요 (최대 255자)" style="width : 650px">

			     			&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
			     			<button >작성</button>
			     		</td>
			     	</form> 
			     </c:if>
		     </tr>
		</table>
		</div>
</body>
<script>
$.ajax({
	type:'post',
	url:'tiuserRight.ajax',
	data:{},
	dataType:'json',
	success:function(data){
		console.log(data);
		if (data != "1") {
			document.getElementById("ticommentContent").style.display = "none";
			document.getElementById("tiicommentContent").style.display = "none";
		}
	},
	error:function(e){
		console.log(e);
	}
});

function hideMessage() {
    var message = document.getElementById("message");
    if (message) {
        message.style.display = "none";
    }
}

function showMessage() {
    var commentContent = document.getElementsByName("commentContent")[0];
    var message = document.getElementById("message");
    if (commentContent.value.length == 0 && message) {
        message.style.display = "block";
    }
}

function limitText(element, maxLength) {
    if (element.value.length > maxLength) {
        element.value = element.value.slice(0, maxLength);
    }
}

</script>
</html>