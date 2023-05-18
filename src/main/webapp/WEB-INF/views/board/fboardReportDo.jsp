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
body{
		text-align:center;
	}
</style>
</head>
<body>

	<form action = "freeboardReport.do" method="post" id="form">
		<input type = "hidden" name = "boardIdx" value = "${dto.bidx}">
		<input type = "hidden" name = "userId" value = "${loginId}">
	
		<br/>
		<br/>
		<h1> 게시글 신고</h1>
		<br/>
		<br/>
			<label>신고 사유 선택 </label>
			<select name="report" id="report" style=" width:300px; margin: 10px;">
				<option value="none">신고 사유</option>
				<option value="부적절한 언어 사용">부적절한 언어 사용</option>
				<option value="광고">광고</option>
				<option value="중복글 게시">중복글 게시</option>
				<option value="기타">기타</option>
			</select>
			<br/>
			<br/>
			<br/>
			<br/>
			<br/>
			<br/>
			<textarea name = "content" id="content" style="width: 500px; height: 200px;"placeholder="기타 신고사유를 입력해 주세요."></textarea>
			<br/>
			<br/>
			<br/>
			<input type = "button" class="btn btn-warning" value = "제출" onclick = "submitclick()" style="margin: 10px;">
			<input type = "button" class="btn btn-outline-dark" onclick = "window.close()" id= "closeButton" value = "닫기">
	</form>

</body>
<script>
	function submitclick(){
		console.log($('#report').val());
		
		if($('#report').val() == 'none'){
			alert('신고 사유를 선택해 주세요');
			return false;
		}
		
		if($('#report').val() == '기타'){
			if($('#content').val() == ''){
				alert('신고 사유를 입력해 주세요.');
				return false;
			}			
		}
		
		$('#form').submit();	
	}
</script>
</html>