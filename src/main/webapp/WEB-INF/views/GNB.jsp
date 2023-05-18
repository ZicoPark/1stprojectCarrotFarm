<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<meta charset="UTF-8">
<title>🏀 당근농장</title>

   
   <style>

      /* 추가적인 스타일 시트 */
      .navbar-brand {
      
         width: 150px;
         height: 50px;
         background-image: url("/photo/mainLogo.png"); /* 로고 이미지 추가 */
         background-size: cover;
         background-position: center;
         background-repeat: no-repeat;
      }


      .navbar-light .navbar-nav .nav-link {
         color: #000000; /* 네비게이션 바 텍스트 색상 */
      }


      .navbar-light .navbar-nav .nav-link.active,
      .navbar-light .navbar-nav .nav-link:hover {
         color: #FFA500; /* 선택된 메뉴 텍스트 색상 */
      }
      
      .navbar-nav {
           padding-left: 100px;
      }
      
      .navbar-nav > li:first-child {
           margin-left: 0;
      }
      .navbar-nav > li > a {
          font-weight: bold;
           font-size: 18px;
      }   
      
      .navbar-brand {
           margin-left: 40px;
      }
      
      .navbar {
      
         width:100%;
         position:relative;
         
      }
   </style>

</head>
<body>

	</br>
	
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand mr-auto" href="/cf"></a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  
  <div class="collapse navbar-collapse" id="navbarNav">
    <ul class="navbar-nav flex-grow-1">
      <li class="nav-item active flex-grow-1">
        <a class="nav-link" href="/cf/matching/list.do">경기 모집</a>
      </li>
      <li class="nav-item flex-grow-1">
        <a class="nav-link" href="/cf/court">경기장</a>
      </li>
      <li class="nav-item flex-grow-1">
        <a class="nav-link" href="/cf/noticeboardList.do">게시판</a>
      </li>
      <li class="nav-item flex-grow-1">
        <a class="nav-link" href="/cf/team">팀페이지</a>
      </li>
      <li class="nav-item flex-grow-1">
        <a class="nav-link" href="/cf/userinfo.go">마이페이지</a>
      </li>
    </ul>
  </div>
</nav>

</body>
<script>

</script>
</html>