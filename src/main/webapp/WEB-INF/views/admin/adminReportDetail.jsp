<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>🏀 당근농장</title>
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<style>
	th {
		padding: 10px;
		width:200px;
	}
	tbody td{
		height:100px;
	}
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
	
	
		th, td {
		margin : 10px;	
		padding : 10px 10px;
		border-collapse : collapse;
		border-left: none;
    	border-right: none;
	}
	
	table{
		width:95%;
		height:70%;
		
		border-collapse : collapse;
		margin : 30px 10px 10px 30px;
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
<h3>신고 처리</h3>

<div style="float: right;">
		<%@ include file="../loginBox.jsp" %>
	</div> 
	<%@ include file="../GNBA.jsp" %>
</hr>
<div id="content">
<form action="adminReportPro.do">
<input type="hidden" name="reportIdx" value="${reportInfo.reportIdx}"/>
<input type="hidden" name="reportId" value="${reportInfo.reportId}"/>
<input type="hidden" name="categoryId" value="${reportInfo.categoryId}"/>
<input type="hidden" name="reportUserId" value="${reportInfo.reportUserId}"/>
<table>
	<thead>
		<tr>
			<td style="width:14%; font-weight:bold;">작성자 아이디</td>
			<td style="width:14%;">${reportInfo.userId}</td>
			<td style="width:14%; font-weight:bold;">신고 대상자</td>
			<td style="width:14%;">${reportInfo.reportUserId}</td>
			<td style="width:14%; font-weight:bold;">누적경고</td>
			<c:if test="${warningCount ne null && warningCount ne ''}">
				<td style="width:14%;">${warningCount}</td>
			</c:if>
			<c:if test="${warningCount eq null || warningCount eq ''}">
				<td style="width:14%;">0</td>
			</c:if>
			<td style="width:14%;">
				<select name="reportResult" id="reportResult">
					<c:if test="${reportInfo.categoryId ne 'ru'}">
				 		<option value="블라인드">블라인드</option>
				 	</c:if>
		         	<option value="경고">경고</option>
		        	<option value="영구제한">영구제한</option>
		    	</select>
			</td>		
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>
				<h4>신고 내용</h4>
			</td>
			<td colspan="6" ><button style="float:right; margin-right:10px;" type="button" onclick="reportPro()" class="btn btn-outline-dark">처리완료</button></td>
		</tr>
		<tr style="border:1px solid black;">
			<td colspan="4" style="width:100%; text-align:left;">
				${reportInfo.reportContent}
			</td>
			<td style="text-align:right;" colspan="3">
				<c:if test="${reportInfo.address ne null && reportInfo.address ne ''}">
    				<a style="float:right;" href="${reportInfo.address}">신고 링크</a>
				</c:if>
				<c:if test="${reportInfo.commentContent ne null }">
					댓글 내용 : ${reportInfo.commentContent}
				</c:if>
				<c:if test="${reportInfo.msg ne null }">
					${reportInfo.msg}
				</c:if>
			</td>
		</tr>
		<tr>
			<td>
				<h4>신고 처리</h4>
			</td>
		</tr>
		<tr style="border:1px solid black;">
		<c:if test="${recordList eq '[]'}">
			<tr>
				<td>신고 처리 내역이 없습니다.</td>
			</tr>
		</c:if>
		<c:if test="${recordList ne '[]'}">
			<c:forEach items="${recordList}" var="item">
				<tr>
					<th colspan="3">${item.reportReason}</th>
					<th style="text-align: center;">${item.reportResult}</th>
					<th colspan="3" style="text-align: right;">${item.reportRecordDate}</th>
				</tr>
			</c:forEach>
		</c:if>
		<tr>
			<td colspan="7">
				<textarea  style="width: 100%; height: 200px;" name="reportReason" required></textarea>
			</td>
		</tr>
		<tr>
			<th style="text-align: center;" colspan="7">
				<button class="btn btn-outline-dark">처리</button>
				<button style="margin-left: 10px;" type="button" onclick="list()" class="btn btn-outline-dark">목록</button>
			</th>
			
		</tr>
	</tbody>
</table>
</form>
</div>
</body>
<script>
	function list(){
		location.href="adminReport";
	}
	
	function reportPro(){
		location.href="adminReportProcess.do?reportId=${reportInfo.reportId}&categoryId=${reportInfo.categoryId}&reportUserId=${reportInfo.reportUserId}";
	}
	
	var waringCount="${warningCount}";
	console.log(waringCount);
	var address="${reportInfo.address}";
	console.log(address);
	var recordList="${recordList}";
	console.log(recordList);
	console.log("${reportInfo.categoryId}");
</script>

</html>