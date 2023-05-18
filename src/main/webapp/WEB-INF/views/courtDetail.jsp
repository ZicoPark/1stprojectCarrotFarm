<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>🏀 당근농장</title>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>  
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=77b263fb5e91c183b524a3d94385df7c&libraries=services"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
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

body{
      position:relative;
      font-size:15px;
      padding : 10px;
      min-width: 1200px;
   }
   
   #content {
      width:78%;
      height :83%;
      background-color: #f8f9fa;
      padding: 10 30 10;
      margin: 5px;
      float:right;
      
   }
   
   #LNB {
      width:20%;
      height :83%;
      background-color: #f8f9fa;
      float:left;
      margin: 5px;
      font-weight: bold;
        font-size: 15px;
      text-align:center;
      
   }
   a {
     color : black;
   }
   
   a:link {
     color : black;
   }
   a:visited {
     color : black;
   }
   a:hover {
    text-decoration-line: none;
     color : #FFA500 ;
   }
</style>
</head>
<body>
   <div style="float: right;">
      <%@ include file="loginBox.jsp" %>
   </div> 
   <jsp:include page="GNB.jsp"></jsp:include>
   <div id="LNB">
		<br/><br/>
		<c:if test="${loginId eq null}">
			<img width="200" height="200" src="/photo/기본프로필.png">
		</c:if>
		<c:if test="${loginId ne null}">
			<img width="200" height="200" src="/photo/${loginPhotoName}"> 
			<br/> <h3 style="display:inline-block; margin-top:10px;">${loginId} </h3>님 <a href="/cf/userNoticeAlarm">🔔</a>
		</c:if>
		<br/><br/>
	    <a href="/cf/court" style = "color: orange">경기장 리스트</a>
	    <br/><br/>
	    <a href="#" style = "color:black">경기장 상세보기</a>
	    
	</div>
   <div id="content">
   
   <div id="map" style="width:35%;height:84%;float:left; margin: 20px, 10px, 0px, 20px;"></div>
   <div>
      <table  style="width:60%; margin : 10px; float : right">
         <tr>
            <th style="font-size: 20pt; height:65px;">
               ${courtInfo.courtName}
               <c:if test="${courtInfo.courtInOut eq 'out'}">(실외)</c:if>
               <c:if test="${courtInfo.courtInOut eq 'in'}">(실내)</c:if>
            </th>
            <th id="courtStar" style="text-align: left; font-size: 20pt;">
               <%-- <c:if test="${courtInfo.courtStar eq ''}">0.0</c:if>
               <c:if test="${courtInfo.courtStar ne ''}">⭐${courtInfo.courtStar}</c:if> --%>
            </th>   
         </tr>
         <tr style="font-size: 13pt; height:65px;">
            <th>위치 : ${courtInfo.courtAddress}</th>
         </tr>
         <tr style="font-size: 13pt; height:65px;" >
            <th>사용 여부 : ${courtInfo.courtState}</th>
         </tr>
      </table>
   </br></br></br></br></br></br></br></br>
   </div>
   <div class="image-grid" style = "font-size : 13pt; font-weight: bold; margin : 10px;">
   <a style="margin:4%;" href="#" onclick="window.open('courtReviewPhoto.do?courtIdx=${courtInfo.courtIdx}','사진 모아보기','width=400px,height=400px')">사진 더보기</a>
      </br></br>
      <table style="margin-right : 20px; border : 1px solid black;" >
         <c:if test="${reviewPhotoList eq '[]'}">
         &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 등록된 사진이 없습니다.
         </c:if>
         <c:if test="${reviewPhotoList ne '[]'}">
             <div class="image-row">
         
            <c:forEach items="${reviewPhotoList}" var="reviewPhotos" end="3">
               &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <img width="100" src="/photo/${reviewPhotos.photoName}"/>         
            </c:forEach>
            </div>
         </c:if>
      </table>
   </div>
     <div style = "font-size : 13pt; font-weight: bold;">

          <a style="margin:4%;" href="#" onclick="window.open('courtReviews.do?courtIdx=${courtInfo.courtIdx}','리뷰 모아보기','width=600px,height=400px')">리뷰 더보기</a>
         <table style = " width : 55% ; float : left; margin-left:4%; ">
         <c:forEach items="${courtReviewList}" var="courtReview" end="3">
         <tr>
            <th>${courtReview.userId}</th>
            <th><input class="userCourtReview" type="text" disabled value="${courtReview.courtOneLineReview}"/></th>            
            <th>⭐${courtReview.courtStar}</th>
            
            <c:if test="${courtReview.photoName ne null}">
               <th><img width="100" src="/photo/${courtReview.photoName}"/></th>
            </c:if>
             <c:if test="${courtReview.photoName eq null}">
               <th></th>
            </c:if>
            <c:if test="${courtReview.userId eq sessionScope.loginId}">
            <th><a href="#" onclick ="window.open('courtReviewUpdate.go?courtReviewIdx=${courtReview.courtReviewIdx}&courtIdx=${courtInfo.courtIdx}','리뷰 모아보기','width=800px,height=400px')">수정</a></th>
            <th><a href="courtReviewDelete.do?courtReviewIdx=${courtReview.courtReviewIdx}&courtIdx=${courtInfo.courtIdx}">삭제</a></th>
            </c:if>
            <c:if test="${courtReview.userId ne sessionScope.loginId && sessionScope.loginId ne null}">
            <th><a href="#" onclick="window.open('courtReviewReport.go?courtReviewIdx=${courtReview.courtReviewIdx}&reportUserId=${courtReview.userId}','리뷰 신고하기','width=600px,height=400px')">신고</a></th>
            </c:if>
         </tr>
      </c:forEach>
      </table>
      
   </div>
   <c:if test="${sessionScope.loginId ne null}">
   <form action="courtReviewWrite.do" method="post" enctype="multipart/form-data" onsubmit="return validateForm();">
   <div style = "text-align: center;">
      
      <input type="hidden" name="courtIdx" value="${courtInfo.courtIdx}"/>
      <input type="hidden" name="courtName" value="${courtInfo.courtName}"/>
      <input type="hidden" name="userId" value="${sessionScope.loginId}"/>
      </br></br></br></br></br></br></br></br></br></br></br>
      
      <hr/>리뷰작성 &nbsp; &nbsp; <input id="courtOneLineReview" type="text" name="courtOneLineReview" style="display: inline-block;"/>
      &nbsp; &nbsp; &nbsp; &nbsp; 
      <input type="file" name="photo" style="display: inline-block;"/>
      <label>별점</label>
      <div class="rating" style="display: inline-block;">
        <input type="radio" id="star5" name="courtStar" value="5">
        <label for="star5"></label>
        <input type="radio" id="star4" name="courtStar" value="4">
        <label for="star4"></label>
        <input type="radio" id="star3" name="courtStar" value="3" checked>
        <label for="star3"></label>
        <input type="radio" id="star2" name="courtStar" value="2">
        <label for="star2"></label>
        <input type="radio" id="star1" name="courtStar" value="1">
        <label for="star1"></label>
   </div>
      &nbsp; &nbsp; &nbsp; &nbsp; 
      <button class="btn btn-outline-dark">작성</button> &nbsp; &nbsp; &nbsp;  <button class="btn btn-outline-dark" type="button" onclick="location.href='court'">목록</button>
   </div>
   </form>
   </c:if>
	</div>
</body>
<script>
   var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
   mapOption = { 
       center: new kakao.maps.LatLng(${courtInfo.courtLatitude},${courtInfo.courtLongitude}), // 지도의 중심좌표
       level: 3 // 지도의 확대 레벨
   };
   
   var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
   
   //마커가 표시될 위치입니다 
   var markerPosition  = new kakao.maps.LatLng(${courtInfo.courtLatitude},${courtInfo.courtLongitude}); 
   
   //마커를 생성합니다
   var marker = new kakao.maps.Marker({
   position: markerPosition
   });
   
   //마커가 지도 위에 표시되도록 설정합니다
   marker.setMap(map);

   //아래 코드는 지도 위의 마커를 제거하는 코드입니다
   //marker.setMap(null); 
   var msg = "${msg}";
   if(msg != ""){
      alert(msg);
   }
   function validateForm() {
        var review = $("#courtOneLineReview").val();
        console.log(review);
        if (review == "") {
          alert("리뷰를 작성해주세요.");
          return false;
        }
      }
   var star;
   var courtStar = "${courtInfo.courtStar}";
   if(courtStar==''){
	   star = 0;
   }else{
	   star = parseFloat(courtStar).toFixed(2);
   }
   console.log(star);
   $('#courtStar').text('⭐'+star);
</script>
</html>

