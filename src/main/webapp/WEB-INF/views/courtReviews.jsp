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
	<table>
			<c:forEach items="${courtReviews}" var="courtReviews">
			<tr>
				<th>${courtReviews.userId}</th>
				<th><input class="userCourtReview" type="text" disabled value="${courtReviews.courtOneLineReview}"/></th>				
				<th>☆${courtReviews.courtStar}</th>
				
				<c:if test="${courtReviews.photoName ne null}">
					<th><img width="100" src="/photo/${courtReviews.photoName}"/></th>
				</c:if>
				<c:if test="${courtReviews.userId == sessionScope.loginId}">
					<th><a href="#" onclick ="window.open('courtReviewUpdate.go?courtReviewIdx=${courtReviews.courtReviewIdx}&courtIdx=${courtIdx}','리뷰 수정','width=800px,height=400px')">수정</a></th>
					<th><a href="courtReviewDelete.do?courtReviewIdx=${courtReviews.courtReviewIdx}&courtIdx=${courtIdx}">삭제</a></th>
				</c:if>
				<c:if test="${courtReviews.userId != sessionScope.loginId && sessionScope.loginId ne null}">
					<th><a href="#" onclick="window.open('courtReviewReport.go?courtReviewIdx=${courtReview.courtReviewIdx}','리뷰 신고하기','width=600px,height=400px')">신고</a></th>
				</c:if>
			</tr>
		</c:forEach>
		</table>
		<button onclick="window.close()">닫기</button>
</body>
<script></script>
</html>

