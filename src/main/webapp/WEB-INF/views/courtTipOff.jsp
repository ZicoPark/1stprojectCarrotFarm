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
	<h3>경기장 제보</h3>
	<form action="courtTipOff.do">
		<input type="hidden" name="userId" value="${sessionScope.loginId}"/>
		<table>
			<tr>
				<th>경기장 이름</th>
				<th><input type="text" name="courtName" required/></th>
			</tr>
			<tr>
				<th>경기장 주소</th>
				<th><input type="text" name="courtAddress" required/></th>
			</tr>
			<tr>
				<th colspan="2"><button>저장</button><button type="button" onclick="window.close()">닫기</button></th>
			
			</tr>
			
		</table>
		
	</form>
</body>
<script>

</script>
</html>