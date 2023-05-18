<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=77b263fb5e91c183b524a3d94385df7c&libraries=services"></script>
<style>
	rating {
  display: inline-block;
  position: relative;
  height: 25px;
  line-height: 25px;
  font-size: 25px;
}

.rating input {
  position: absolute;
  left: -9999px;
}

.rating label {
  float: right;
  padding-left: 10px;
  cursor: pointer;
  color: #ccc;
}

.rating label:before {
  content: '★';
}

.rating input:checked ~ label {
  color: #ffc700;
}

.rating:not(:checked) label:hover,
.rating:not(:checked) label:hover ~ label {
  color: #deb217;
}
}
</style>
</head>
<body>
	내가 쓴 리뷰
	<table>
		<tr>
			<th>${userCourtReview.courtOneLineReview}</th>
			<th>☆ ${userCourtReview.courtStar}</th>
			<c:if test="${userCourtReviewPhoto eq null}">
				<th>등록된 사진이 없습니다.</th>
			</c:if>
			<c:if test="${userCourtReviewPhoto ne null}">
				<th><img width="100" src="/photo/${userCourtReviewPhoto.photoName}"/></th>
			</c:if>
		</tr>
	</table>
	<form action="courtReviewUpdate.do" method="post" enctype="multipart/form-data" onsubmit="return validateForm();">
	<div>
		
		<input type="hidden" name="courtIdx" value="${userCourtReview.courtIdx}"/>
		<input type="hidden" name="courtReviewIdx" value="${userCourtReview.courtReviewIdx}"/>
		<input type="hidden" name="userId" value="${userCourtReview.userId}"/>
		리뷰작성<input id="courtOneLineReview" type="text" name="courtOneLineReview" value="${userCourtReview.courtOneLineReview}" style="display: inline-block;"/>
		<input type="file" name="photo" style="display: inline-block;"/>
		<label>별점</label>
		<div class="rating" style="display: inline-block;">
		  <input type="radio" id="star5" name="courtStar" value="5" ${userCourtReview.courtStar == '5' ? 'checked' : ''}>
		  <label for="star5"></label>
		  <input type="radio" id="star4" name="courtStar" value="4" ${userCourtReview.courtStar == '4' ? 'checked' : ''}>
		  <label for="star4"></label>
		  <input type="radio" id="star3" name="courtStar" value="3" ${userCourtReview.courtStar == '3' ? 'checked' : ''}>
		  <label for="star3"></label>
		  <input type="radio" id="star2" name="courtStar" value="2" ${userCourtReview.courtStar == '2' ? 'checked' : ''}>
		  <label for="star2"></label>
		  <input type="radio" id="star1" name="courtStar" value="1" ${userCourtReview.courtStar == '1' ? 'checked' : ''}>
		  <label for="star1"></label>
	</div>
		
		<button>저장</button>
	</div>
	</form>
	 <button onclick="closeButton()">닫기</button>
	
</body>
<script>
	function validateForm() {
		  var review = $("#courtOneLineReview").val();
		  console.log(review);
		  if (review == "") {
		    alert("리뷰를 작성해주세요.");
		    return false;
		  }
		}
	function closeButton(){
		console.log('함수 실행');
		window.opener.location.reload();
		window.close();
	}
</script>
</html>

