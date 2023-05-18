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
	
	#ilisti, #iupdatei, #ideletei, #iwritei{
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
	      <a href="/cf/noticeboardList.do" style="font-weight: bold; font-size: 18px; color: black;">공지사항</a>
	   	 <br/><br/>
	     <a href="/cf/freeboardList.do" style="font-weight: bold; font-size: 18px ; color: black;">자유 게시판</a>
	     <br/><br/>
	     <a href="/cf/inquiryboardList.do" style="font-weight: bold; font-size: 18px; color: orange;">문의</a>

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
					<input id = "ilisti" type = "button" class="btn btn-outline-dark" onclick="location.href='./inquiryboardList.do'" value="리스트"/>
					&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
						<c:if test="${dto.userId eq loginId || userRight eq 1}">
						<input id = "iupdatei" type = "button" class="btn btn-outline-dark" onclick="location.href='./inquiryboardUpdate.go?bidx=${dto.boardIdx}'" value="수정"/>
						&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
						<input id = "ideletei" type = "button" class="btn btn-outline-dark" value="삭제" onclick="if(confirm('정말로 삭제하시겠습니까?')){location.href='./inquiryboardDelete.do?bidx=${dto.boardIdx}';}">
					</c:if>
				</th>
			</tr>
			<tr>
	     		<th colspan="7">
		     		<table style="width: 100%;">
			     		<c:forEach items="${icommentList}" var="icommentList">
			     			<tr>
			     				<th style="width: 18%;">${icommentList.userId} </th>
			     				<td style="width: 47%;">${icommentList.commentContent}</td>
			     				<td style="width: 18%;">${icommentList.commentWriteTime}</td>
			     				<td style="width: 17%;">
			     					<c:if test="${icommentList.userId eq loginId || userRight eq 1}">
			     						<a  href="inquiryboardcommentUpdate.go?commentIdx=${icommentList.commentIdx}&bidx=${dto.boardIdx}">수정</a> 
			     						/ 
			     						<a href="inquiryboardcommentDelete.do?commentIdx=${icommentList.commentIdx}&bidx=${dto.boardIdx}">삭제</a>
			     					</c:if>    					
			     				</td>
			     			</tr>
			     		</c:forEach>
		     		</table>
		     	</th>	     	
		     </tr>
		     <tr>
		     	<c:if test="${loginId != null}">
			     	<form method="post" action="inquiryboardcommentWrite.do?categoryId=b003&comentId=${dto.boardIdx}" >
			     		<td id = "icommentContent">
			     			<input type="text" name="userId" value="${loginId}" style= "border:none; background-color: #f8f9fa ; text-align:center;" readonly>
			     		</td>
			     		<td colspan="5" id = "iicommentContent">
			     			<input type="text" name="commentContent" onclick="hideMessage()" onblur="showMessage()" oninput="limitText(this, 255)" placeholder="댓글을 입력하세요 (최대 255자)" style="width : 650px">

			     			&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
			     			<button id = "iwritei" class="btn btn-outline-dark">작성</button>
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
	url:'iuserRight.ajax',
	data:{},
	dataType:'json',
	success:function(data){
		console.log(data);
		if (data != "1") {
			document.getElementById("icommentContent").style.display = "none";
			document.getElementById("iicommentContent").style.display = "none";
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