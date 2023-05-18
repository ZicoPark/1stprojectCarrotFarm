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
	
	#freeboardSearchInput{
		width: 200px;
    	height: 30px;
	}
	
	# freeboardSearchButton {
		height: 30px;
	}
	
	.hidden-row {
    display: none;
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
				<td colspan="111">${dto.subject}</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td colspan="111">${dto.userId}</td>
			</tr>
			<tr>
				<th>작성일</th>
				<td colspan="111">${dto.writeTime}</td>
			</tr>
			<tr>
				<th>내용</th>
				<td colspan="111">${dto.content}</td>
			</tr>
			<c:if test= "${dto.photoName ne null}">
			<tr>
				<th>사진</th>
				<td colspan="111"><img width = "333" src="/photo/${dto.photoName}"/></td>
			</tr>
			</c:if>
			<tr class="hidden-row">
				<th colspan="11">
					<input type = "button" onclick="location.href='./teaminquiryboardList.do'" value="리스트"/>
					&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
					<input type = "button" onclick="location.href='./teaminquiryboardUpdate.go?bidx=${dto.boardIdx}'" value="수정"/>
					&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
					<input type = "button" value="삭제" onclick="if(confirm('정말로 삭제하시겠습니까?')){location.href='./teaminquiryboardDelete.do?bidx=${dto.boardIdx}';}">
				</th>
			</tr>
			<tr style="display: none;">
	     		<th colspan="7">
		     		<table>
			     		<c:forEach items="${ticommentList}" var="ticommentList">
			     			<tr>
			     				<th>${ticommentList.userId} </th>
			     				<td >${ticommentList.commentContent}</td>
			     				<td>${ticommentList.commentWriteTime}</td>
			     				<td>
			     					<c:if test="${ticommentList.userId eq loginId}">
			     						<a  href="teaminquiryboardcommentUpdate.go?commentIdx=${ticommentList.commentIdx}&bidx=${dto.boardIdx}" >수정</a> 
			     						/ 
			     						<a href="teaminquiryboardcommentDelete.do?commentIdx=${ticommentList.commentIdx}&bidx=${dto.boardIdx}">삭제</a>
			     					</c:if>				
			     				</td>
			     			</tr>
			     		</c:forEach>
		     		</table>
		     	</th>	     	
		     </tr>
		     <tr style="display: none;">
			     <form method="post" action="teaminquiryboardcommentWrite.do?categoryId=b014&comentId=${dto.boardIdx}">
			     		<th>
			     			<input type="text" name="userId" value="${loginId}" style= "border:none;" readonly>
			     		</th>
			     		<th colspan="5">
			     			<input type="text" name="commentContent">
			     		</th>
			     		<th>
			     			<button>작성</button>
			     		</th>
			     </form> 
		     </tr>
		     
		     <c:forEach items="${ticommentList}" var="ticommentList">
				<tr >
			    	<th>${ticommentList.userId} </th>
			     	<td colspan="3">${ticommentList.commentContent}</td>
			     	<td>${ticommentList.commentWriteTime}</td>
			     	<td colspan="2">
			     		<c:if test="${ticommentList.userId eq loginId}">
			     			<a  href="ticommentUpdate.go?commentIdx=${ticommentList.commentIdx}&bidx=${dto.bidx}" ></a> 
			     			 
			     			<a href="ticommentDelete.do?commentIdx=${ticommentList.commentIdx}&bidx=${dto.bidx}"></a>
			     		</c:if>
			     	</td>
			     </tr>
			</c:forEach>
		     
		     <tr>

			     <form method="post" action="teaminquiryboardcommentUpdate.do?">
					<th>
						<input type="hidden" name="commentIdx" value="${ticommentDto.commentIdx}">
						<input type="hidden" name="bidx" value="${dto.boardIdx}" style= "border:none;">
						<input type="text" name="userId" value="${loginId}" style= "border:none; background-color: #f8f9fa ; text-align:center;" readonly; readonly>
					</th>
					<c:if test="${loginId != 'guest' }">
						<th colspan="5">
							<input type="text" name="commentContent" value="${ticommentDto.commentContent}"  style="width : 650px">
						</th>
						<th>
							<button>댓글 수정</button>
						</th>
					</c:if>
					<c:if test="${loginId == 'guest' }">
						<th colspan="6">
							<input type="text" name="commentContent" style= "border:none; width:400px;" placeholder="댓글 작성은 로그인 후 가능합니다. ">
						</th>
					</c:if>
				</form>  
		     </tr>
		</table>
		</div>
</body>
<script>

</script>
</html>