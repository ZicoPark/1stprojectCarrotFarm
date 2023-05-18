<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src = "https://code.jquery.com/jquery-3.6.4.min.js"></script>
<style></style>
</head>
<body>

<div style="float: right;">
	<jsp:include page="loginBox.jsp"></jsp:include>
</div>

<jsp:include page="GNB.jsp"></jsp:include>

<h3>회원 탈퇴 완료</h3>
<div>안녕하세요 당근농장 입니다.</div>
 <div>서비스를 이용하시면서 불편함을 드렸다면 죄송합니다.</div>
 <div>더 나은 서비스를 제공하기 위해 노력하는 당근농장이 되겠습니다.</div>
 <button class="btn btn-outline-dark" onclick="location.href='/cf/'">메인으로 돌아가기</button>

</body>
<script></script>
</html>