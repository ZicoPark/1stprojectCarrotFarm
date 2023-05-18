<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<meta charset="UTF-8">
<title>🏀 당근농장</title>
	<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
	<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8eccc3d59df46746494af9204ba90019"></script>

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
		height : 83%;
		/* background-color: #f8f9fa; */
		padding: 10 30 10;
		margin : 5px;
		float:right;
		
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
	
	#image{
		height:30%;
	}
	
	#listDiv{
		display:inline-block;
		width: 30%;
		height:50%;
		margin : 20px;
	}
	table, th, td{
		margin : 5px;
	}
	
	table{
 		/* border : 1px solid black;  */
		width:100%;
		height:95%;
		text-align:center;
	}


      

	
</style>
</head>
<body>

	<div style="float: right;">
		<%@ include file="./loginBox.jsp" %>
	</div> 
	<%@ include file="./GNB.jsp" %>
	

	<div id="content" style="text-align:center;">
		<hr/>
		<br/><br/>
		<img id="image"  src="/photo/mainLogo.png"/ >
		<br/><br/>
		<hr/>
		
		<div id="listDiv" >	
			<table>
				<tr>
					<th colspan="3"><h3 style="display:inline;">공지사항</h3></th>
				</tr>
				<tr style="height:5px; font-size:12px;">
					<td colspan="2"></td>
					<td><a href="noticeboardList.do">+더보기</a></td>
				</tr>
				<tr>
					<td colspan="3" style="height:1px;"><hr/><td>
				</tr>
				
				<c:forEach items="${noticeList}" var="noticeList">
					<tr> 
						<td colspan="2" style="text-align:left;"><a href="noticeboardDetail.do?bidx=${noticeList.boardIdx}"> 📢 &nbsp; &nbsp; &nbsp; ${noticeList.subject}</a></td>
						<td>${noticeList.writeTime}</td>
					</tr>
				</c:forEach>
				
			</table>
		</div>
		
		<div id="listDiv" >	
			<table>
				<tr>
					<th colspan="3"><h3 style="display:inline;">경기 모집</h3></th>
				</tr>
				<tr style="height:5px; font-size:12px;">
					<td colspan="2"></td>
					<td><a href="matching/list.do">+더보기</a></td>
				</tr>
				<tr>
					<td colspan="3" style="height:1px;"><hr/><td>
				</tr>
				
				<c:forEach items="${matchingList}" var="matchingList">
					<tr>
						<td style="text-align:left;">&#128100 ${matchingList.matchingNumforSure}/${matchingList.matchingNum}</td>
						<td id="subject"><a href="matching/detail.go?matchingIdx=${matchingList.matchingIdx}">${matchingList.subject}</a></td>
						<td>${matchingList.gameDate}</td>
					</tr>
				</c:forEach>
				
			</table>
		</div>
		<div id="listDiv" >	
			<table>
				<tr>
					<th colspan="3"><h3 style="display:inline;">팀 둘러보기</h3></th>
				</tr>
				<tr style="height:5px; font-size:12px;">
					<td colspan="2"></td>
					<td><a href="team">+더보기</a></td>
				</tr>
				<tr>
					<td colspan="3" style="height:1px;"><hr/><td>
				</tr>
				
				<c:forEach items="${teamList}" var="teamList">
					<tr>
						<td style="text-align:left;"> ${teamList.gu}</td>
						<td><a href="team/teamPage.go?teamIdx=${teamList.teamIdx}">${teamList.teamName}</a></td>
						<td>${teamList.teamMatchState}</td>
					</tr>
				</c:forEach>
				
			</table>
		</div>
		<br/>
		<hr/>
	</div>
	

</body>
<script>


</script>
</html>