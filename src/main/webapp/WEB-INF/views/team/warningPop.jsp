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
		
		<h2>경고</h2>
		<hr/>
		<p>팀 활동에 방해가 되는 회원이 있을 경우 경고를 부여할 수 있습니다.</p>
		<p>경고 사유가 잘못된 정보일 경우 취소 가능합니다.</p>
		<p>경고 5회 누적 시 팀원을 강퇴시킬 수 있습니다.</p>
		<br/>
		
		<h4>경고 대상자</h4>
		<span>${userId}</span>
		<br/>			
		<label>경고 사유 선택 </label>
			<select name="warning" id="warning" style=" width:300px; margin: 10px;">
				<option value="none">경고 사유 </option>
				<option value="욕설 및 비방">욕설 및 비방</option>
				<option value="경기 불참">경기 불참</option>
				<option value="잦은 경기 지각">잦은 경기 지각</option>
				<option value="사익을 위한 목적성 경기참여">사익을 위한 목적성 경기참여</option>
				<option value="기타">기타</option>
			</select>
			<br/>	
			<textarea name="content" id="content" style="width: 500px; height: 200px;" placeholder="기타 경고사유를 입력해 주세요." hidden="true"></textarea>
			<br/>	
		<input type="button" value="제출" onclick="subChk()" style="margin: 10px; font-size: 15;" class="btn btn-warning" />
	<!-- </form> -->
	
	
</body>
<script>	
	
	var teamIdx = ${teamIdx};
	var userId = "${userId}";

	$('#warning').change(function(){
		console.log($(this).val());
		if($('#warning').val() == '기타'){		
		    $('#content').attr('hidden',false);
		  } else {
		    $('#content').attr('hidden',true);
		  }
	});

	function subChk(){
		
		var warning = $('#warning').val();
		console.log(warning);
		var content = $('#content').val();
		console.log(content);
		
		if(warning == 'none'){
			alert('경고 사유를 선택해 주세요.');
			return false;
		}		
		
		if(warning == '기타'){
			
			if(content == ''){
				alert('경고 사유를 입력해 주세요.');
				return false;
			}			
		}		
		
		    $.ajax({
		        url: 'warning.ajax',
		        type: 'POST',
		        data: {
		            'teamIdx': teamIdx,
		            'userId':userId,
		            'warning':warning,
		            'content':content
		        },
				dataType:'json',
				success: function(data) {
					console.log("성공");
					if(data.success == 1){
						if (window.opener && !window.opener.closed) {
							  window.opener.location.reload(); // 부모창 새로고침
							  window.alert("경고처리 되었습니다.");
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