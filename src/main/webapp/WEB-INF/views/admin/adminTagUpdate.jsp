<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<style>
	table, th, td{
      border : 1px solid black;
      border-collapse: collapse;
      padding : 5px 10px;
   }
</style>
</head>
<body>
	<form action="adminTagUpdate.do">
		<h3>태그 수정</h3>
		<input type="hidden" name="tagIdx" value="${tagInfo.tagIdx}"/>
		<hr/>
		<table>
			<tr>
				<th>기존 태그내용</th>
				<td colspan="2">${tagInfo.tagContent}</td>
			</tr>
			<tr>
				<th>변경할 태그내용</th>
				<th><input type="text" id="tagContent" name="tagContent" oninput="myFunction()"/></th>
				<th><button type="button" onclick="tagContentChk()">중복체크</button></th>
			</tr>
			<tr>
				<td colspan="3" id="msg"></td>
			</tr>
			<tr>
				<th colspan="3"><button type="button" id="updateButton" onclick="tagUpdate()">수정</button></th>
			</tr>
		</table>
	</form>
	<button onclick="closeButton()">닫기</button>
</body>
<script>
	function closeButton(){
		console.log('함수 실행');
		window.opener.location.reload();
		window.close();
	}
	
	var overlayChk = false;
	
	function tagContentChk(){
		var tagContent= $('#tagContent').val();
		console.log(tagContent);
		 $.ajax({
		      type:'post',
		      url:'tagContentChk.ajax',
		      data:{"tagContent" : tagContent},
		      dataType:'json',           
		      success:function(data){
		         console.log(data.tagChk);
		         
		         if(data.msg==null){
		        	 console.log(data.msg);
			         if(data.tagChk==1){
			        	 $('#msg').css({'font-size':'8px', 'color':'darkgreen'});
				         $('#msg').html('이미 존재하는 태그내용 입니다.');
			         }else{
			        	 $('#msg').css({'font-size':'8px', 'color':'darkgreen'});
				         $('#msg').html('사용 가능한 태그내용 입니다.');
				         overlayChk=true;
			         }
		         }else{
		        	 alert(data.msg);
		         }
		        	 
		      }
		   });
	}
		
	function myFunction(){
		overlayChk = false;
		$('#msg').html('');
	}
	
	function tagUpdate(){
		if(overlayChk == true){
			$('#updateButton').attr('type','submit');
		}else{
			alert('태그내용 중복 확인 해주세요!');
		}
	}

		   	   
			  
			   
				
		      
		 
</script>
</html>