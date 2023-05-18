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

			.photo-container {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
	}

  .photo-item {
    width: 400px;
    height: 200px;
    margin: 10px;

	}

  .photo-item img {
    max-width: 100%;
    max-height: 100%;
	}

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
		height:60%;
		text-align:center;
	
		border-collapse : collapse;
		padding : 20px 10px;
	}
	
	#gamePlay, #sort{
		width: 100px;
    	height: 30px;
    	margin : 5px;
	}
	
	#commentContent{
		width: 200px;
    	height: 30px;
    	
	}
	
	#registerBtn1, #registerBtn2, #listButton, #writeButton, #reportButton, #reportButtonn{
		font-size: 15px;
		height: 30px;
    	margin : 5px;
	
	}

	#writeButton{
		margin-left : 65px;
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
		<c:if test="${loginId eq null}">
			<img width="200" height="200" src="/photo/기본프로필.png">
		 </c:if>
		 <c:if test="${loginId ne null}">
			<img width="200" height="200" src="/photo/${loginPhotoName}"> 
			<br/> <h3 style="display:inline-block; margin-top:10px;">${loginId} </h3>님 <a href="/cf/userNoticeAlarm">🔔</a>
		 </c:if>
	      <br/><br/>
	        <a href="/cf/team/teamPage.go?teamIdx=${teamIdx}" style="font-weight: bold; font-size: 18px; color: black;">팀소개</a>
	      <br/><br/>
	        <a href="/cf/team/teamUserList.go?teamIdx=${teamIdx}" style="font-weight: bold; font-size: 18px; color: black;">팀원</a>
	      <br/><br/>
	        <a href="/cf/team/teamGame.go?teamIdx=${teamIdx}" style="font-weight: bold; font-size: 18px; color: black;">참여 경기</a>
	      <br/><br/>
	        <a href="/cf/teamnoticeboardList.do?teamIdx=${teamIdx}" style="font-weight: bold; font-size: 18px ; color: black;">팀 공지 사항</a>
	      <br/><br/>
	        <a href="/cf/teampictureboardList.do?teamIdx=${teamIdx}" style="font-weight: bold; font-size: 18px; color: orange;">팀 사진첩</a>
	</div>
	
	<div id="content">
		<table>
			<tr>
				<th>제목</th>
				<td>${dto.get(0).subject}</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>${dto.get(0).userId}</td>
			</tr>
			<tr>
				<th>작성일</th>
				<td>${dto.get(0).writeTime}</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>${dto.get(0).content}</td>
			</tr>
			<c:if test= "${dto.get(0).photoName ne null}">
			<tr>
				<th>사진</th>
         			<td>
            		<c:if test="${dto.size() == 0 }">
               			<div class="default">
                  			<span class="wrap">
                    			<img src="/photo/default.png">
                    		</span>
               			</div>
            		</c:if>
            <c:if test="${dto.size() > 0}">
<div class="container text-center d-flex flex-wrap photo-container">
    <c:forEach items="${dto}" var="i">
      <div class="photo-item">
        <img width = "80%" height = "80%"  src="/photo/${i.photoName}" alt="test">
      </div>
    </c:forEach>
  </div>
</c:if>
         </td>

			</tr>
			</c:if>
			<tr>
				<th colspan="111">
					<input type = "button" class="btn btn-outline-dark" id="listButton" onclick="location.href='./teampictureboardList.do?teamIdx=${teamIdx}'" value="리스트"/>
					&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
					<c:if test="${dto.get(0).userId eq loginId }">
						<input type = "button" class="btn btn-outline-dark" id="registerBtn1" value="수정" onclick="location.href='./teampictureboardUpdate.go?bidx=${dto.get(0).boardIdx}&teamIdx=${teamIdx}'" />				
						&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
						<input type = "button" class="btn btn-outline-dark" id="registerBtn2" value="삭제" onclick="if(confirm('정말로 삭제하시겠습니까?')){location.href='./teampictureboardDelete.do?bidx=${dto.get(0).boardIdx}&teamIdx=${teamIdx}';}">
					</c:if>
					
					<c:if test="${dto.get(0).userId ne loginId }">
						<button class="btn btn-outline-dark" id="reportButton" onclick="window.open('teampictureboardReport.go?bidx=${dto.get(0).boardIdx}','_blank','모집글 신고하기',)">신고</button>
					</c:if>
				</th>
			</tr>
			<tr>
	     		<th colspan="111">
		     		<table style="width: 100%;">
			     		<c:forEach items="${tpcommentList}" var="tpcommentList">
			     			<tr>
			     				<th style="width: 18%;">${tpcommentList.userId} </th>
			     				<td style="width: 47%;" >${tpcommentList.commentContent}</td>
			     				<td style="width: 18%;">${tpcommentList.commentWriteTime}</td>
			     				<td style="width: 17%;">
			     					<c:if test="${tpcommentList.userId eq loginId}">
			     						<a  href="teampictureboardcommentUpdate.go?commentIdx=${tpcommentList.commentIdx}&bidx=${dto.get(0).boardIdx}&teamIdx=${teamIdx}" >수정</a> 
			     						/ 
			     						<a href="teampictureboardcommentDelete.do?commentIdx=${tpcommentList.commentIdx}&bidx=${dto.get(0).boardIdx}&teamIdx=${teamIdx}">삭제</a>
			     					</c:if>
			     					<c:if test="${tpcommentList.userId ne loginId}">
			     						<button class="btn btn-outline-dark" id="reportButtonn" onclick="window.open('teampictureboardCReport.go?commentIdx=${tpcommentList.commentIdx}','_blank','댓글 신고하기')">신고</button>			     			
			     					</c:if>     					
			     				</td>
			     			</tr>
			     		</c:forEach>
		     		</table>
		     	</th>	     	
		     </tr>
		     <tr>
		     	<c:if test="${loginId != null }">
			     <form method="post" action="teampictureboardcommentWrite.do?categoryId=b011&comentId=${dto.get(0).boardIdx}">
			     <input type="hidden" name="teamIdx" value="${teamIdx}"/>
			     		<td>
			     			<input type="text" name="userId" value="${loginId}" style= "border:none; background-color: #f8f9fa ; text-align:center;" readonly;>
			     		</td>
			     
			     		<td colspan="111">
			     			<input type="text" name="commentContent" onclick="hideMessage()" onblur="showMessage()" oninput="limitText(this, 255)" placeholder="댓글을 입력하세요 (최대 255자)" style="width : 650px">
			     			<button class="btn btn-outline-dark" id="writeButton">작성</button>
			     		</td>
			     </form> 
			     </c:if>
		     </tr>
		</table>
		</div>
</body>
<script>
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
$(document).ready(function() {
	  $('#writeButton').css('margin-top', '+0.5px');
	});
</script>
</html>