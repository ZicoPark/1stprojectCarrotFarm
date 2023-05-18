<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<style>
	.image-grid {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-between;
}

.image-grid img {
  width: calc(33.33% - 10px);
  margin-bottom: 10px;
}
</style>
</head>
<body>
		<c:if test="${courtReviewPhoto eq '[]'}">
			<p>등록된 사진이 없습니다.</p>
		</c:if>
		<div class="image-grid">
	  		<c:forEach items="${courtReviewPhoto}" var="courtReviewPhotos">
	    		<img src="/photo/${courtReviewPhotos.photoName}" alt="사진" />
	  		</c:forEach>
		</div>
		<button onclick="window.close()">닫기</button>
</body>
<script>
	console.log("${courtReviewPhoto}");
</script>
</html>