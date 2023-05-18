<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
<meta charset="UTF-8">
<title>회원 정보</title>
<script src = "https://code.jquery.com/jquery-3.6.4.min.js"></script>

<!-- 부트스트랩 JavaScript 파일 불러오기 -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<style>

	body{
		position:relative;
		font-size:15px;
		padding : 10px;
		min-width: 1200px;
	}
	
	#content {
		width:78%;
		height:83%;
		background-color: #f8f9fa;
		padding: 10 30 10;
		margin : 5px;
		float:right;
		
	}
	
	#LNB {
		width:20%;
		height : 83%;
		background-color: #f8f9fa;
		float:left;
		margin : 5px;
		font-weight: bold;
        font-size: 18px;
		text-align:center;
	}
	
	table {
	 margin-left: 300px;
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
	
	.pagination .page-link {
  		color: gray; /* 기본 글자색을 검정색으로 지정 */
	}

	.pagination .page-item.active .page-link {
 		background-color: #FFA500;
 		border:none;
	}
      
</style>
</head>
<body>

<div style="float: right;">
	<jsp:include page="loginBox.jsp"></jsp:include>
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
           <a href="/cf/userinfo.go">회원 정보</a>
           <br/><br/>
           <a href="/cf/userprofile.go?userId=${loginId}">회원 프로필</a>
           <br/><br/>
           <a href="/cf/userNoticeAlarm">알림</a>
           <br/><br/>
           <a href="/cf/allgames">참여 경기</a>
           <br/><br/>
           <a href="/cf/mygames">리뷰</a>
           <br/><br/>
   </div>
	<div id="content" >
   <h3>회원 정보</h3>
      <table>
      	<tr>
      		<td colspan="2">
      		&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
				<img width="200" src="/photo/${user.photoName}"/>
			</td>
			<td></td>
         </tr>
         <tr>
            <th>아이디</th>
            <td>
               <input type="text" id="userId" value="${user.userId}" readonly/>                           
            </td>
         </tr>
         <tr>
            <th>닉네임</th>
            <td>
               <input type="text" id="nickName" value="${user.nickName}" readonly/>                              
            </td>
         </tr>
         <tr>
            <th>비밀번호</th>
            <td><input type="text" id="userPw" value="${user.userPw}" readonly/></td>
         </tr>
         <tr>
            <th>키</th>
            <td><input type="text" id="height" value="${user.height}" readonly/></td>
         </tr>
         <tr>
            <th>이름</th>
            <td>
               <input type="text" id="userName" value="${user.userName}" readonly/>               
            </td>            
         </tr>
         <tr>
            <th>포지션</th>
            <td>
               <input type="text" id="position" value="${user.position}" readonly/>               
            </td>            
         </tr>
         <tr>
            <th>생년월일</th>               
            <td><input type="text" id ="birthday" value="${user.birthday}" readonly/></td>
         <tr> 
         <tr>
            <th>선호 경기 지역</th>
            <td><input type="text" id="locationIdx" value="${user.si} ${user.gu}" readonly/></td>
         </tr>
         <tr>
            <th>E-MAIL</th>
            <td><input type="email" id="email" value="${user.email}" readonly/></td>
         </tr>
         <tr>
            <th>선호 경기 시간</th>
            <td><input type="text" id="favTime" value="${user.favTime}" readonly/></td>
         </tr>
         <tr>      
            <th colspan="2">
               <button class="btn btn-outline-dark" onclick="location.href='userinfoupdate.go'">회원정보 수정</button>
               <button class="btn btn-outline-dark" onclick="location.href='./'">돌아가기</button>
               <button class="btn btn-outline-dark" onclick="location.href='userdelete.go'">회원탈퇴</button>
            </th>
            </tr>
      </table>
      </div>
</body>
<script>

</script>
</html>