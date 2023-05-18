<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<meta charset="UTF-8">
<title>🏀 당근농장</title>
	<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
	<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>    
	<script src="../resources/js/twbsPagination.js" type="text/javascript"></script>
	
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
	h4{
		float: left;		
		margin: 0 10 0 0;
	}
	input[type="button"]{
		position: relative;
        top: 10px;
        left: 200;
	}
</style>
</head>
<body>

		<input type="text" value="${userId}" name="userId" hidden/>
		<input type="text" value="${teamIdx}" name="teamIdx" hidden/>
		
		<h2>강퇴</h2>
		<hr/>
		<p>강퇴된 팀원이 작성한 글을 제외한 팀원의 모든 정보가 삭제됩니다.</p>
		<p>강퇴된 회원은 재가입이 불가하니 신중하게 선택해주세요.</p>
		<br/>
		
		<h4>강퇴 대상자</h4>
		<span>${userId}</span>
		<br/>
		<br/>
		<input type="button" value="강퇴" onclick="subChk()" style="margin: 10px; font-size:15;" class="btn btn-danger" />	
	
</body>
<script>	
	
	var teamIdx = ${teamIdx};
	var userId = "${userId}";

	function subChk(){

		    $.ajax({
		        url: 'remove.ajax',
		        type: 'POST',
		        data: {
		            'teamIdx': teamIdx,
		            'userId':userId
		        },
				dataType:'json',
				success: function(data) {
					console.log("성공");
					if(data.success == 1){
						if (window.opener && !window.opener.closed) {
							  window.opener.location.reload(); // 부모창 새로고침
							  window.alert("강퇴되었습니다.");
							  window.close(); // 창 닫기
							}
					}					
		        },
				error:function(e){
					console.log(e);
				}
		    });
		}

</script>
</html>