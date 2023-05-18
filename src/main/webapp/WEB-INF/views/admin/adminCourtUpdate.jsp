<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<style></style>
</head>
<body>
	<form action="adminCourtUpdate.do">
	<input type="hidden" name="courtIdx" value="${courtInfo.courtIdx}"/>
		<table>
			<tr>
				<th>경기장 이름</th>
				<th><input type="text" name="courtName" value="${courtInfo.courtName}" required/></th>
			</tr>
			<tr>
				<th>실내/외</th>
				<th>
					<select name="courtInOut" id="courtInOut" required>
						<option value="in" ${courtInfo.courtInOut == 'in' ? 'selected' : ''}>실내</option>
						<option value="out" ${courtInfo.courtInOut == 'out' ? 'selected' : ''}>실외</option>
					</select>
				</th>
			</tr>
			<tr>
				<th>사용 여부</th>
				<th>
					<select name="courtState" id="courtState" required>
						<option value="사용가능" ${courtInfo.courtState == '사용가능' ? 'selected' : ''}>사용가능</option>
						<option value="사용불가" ${courtInfo.courtState == '사용불가' ? 'selected' : ''}>사용불가</option>
					</select>
				</th>
			</tr>
			<tr>
				<th>지역</th>
				<th>
					<select name="gu" id="gu" required>
					<c:forEach items="${guList}" var="gu" varStatus="status">
						 <option value="${status.index+1}" ${(status.index+1) == courtInfo.locationIdx ? 'selected' : ''}>${gu.gu}</option>
					</c:forEach>
					</select>
				</th>
			</tr>
			<tr>
				<th>경기장 위도</th>
				<th><input type="text" name="courtLatitude" value="${courtInfo.courtLatitude}" required/></th>
			</tr>
			<tr>
				<th>경기장 경도</th>
				<th><input type="text" name="courtLongitude" value="${courtInfo.courtLongitude}" required/></th>
			</tr>
			<tr>
				<th>경기장 주소</th>
				<th><input type="text" name="courtAddress" value="${courtInfo.courtAddress}" required/></th>
			</tr>
		</table>
		<button>전송</button>
	</form>

</body>
<script></script>
</html>