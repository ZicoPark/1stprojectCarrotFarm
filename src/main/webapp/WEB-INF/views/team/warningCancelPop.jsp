<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<meta charset="UTF-8">
<title>🏀 당근농장</title>
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<style>
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
		
		<h2>경고취소</h2>
		<hr/>
		<p>특별한 사유가 발생하는 경우 경고를 취소할 수 있습니다.</p>
		<br/>
		
		<h4>취소 대상자</h4>
		<span>${userId}</span>
		<br/><br/>		
		<label>취소 사유</label>
			<input type="text" name="reason" id="reason" style="width: 450px;" placeholder="취소사유를 입력해 주세요."/>
		<br/>	
		<input type="button" value="제출" onclick="subChk()" style="margin: 10px; font-size: 15;" class="btn btn-warning"/>	
	
</body>
<script>	
	
	var teamIdx = ${teamIdx};
	var userId = "${userId}";

	function subChk(){

		var reason = $('#reason').val();
		console.log(reason);
		
		if(reason == '') {
			alert('취소 사유를 입력해주세요.');
			return false;
		}		

		    $.ajax({
		        url: 'warningCancel.ajax',
		        type: 'POST',
		        data: {
		            'teamIdx': teamIdx,
		            'userId':userId,
		            'reason':reason
		        },
				dataType:'json',
				success: function(data) {
					console.log("성공");
					if(data.success == 1){
						if (window.opener && !window.opener.closed) {
							  window.opener.location.reload(); // 부모창 새로고침
							  window.alert("경고 취소되었습니다.");
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