<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<meta charset="UTF-8">
<title>🏀 당근농장</title>
<style>

</style>
</head>
<body>
<div style="display: inline;" id="login"></div>
<div style="display: inline;" id="join"></div>
</body>
<script>
   var loginId = "${sessionScope.loginId}";
   if(loginId == ""){
      var content= '<a href="/cf/login">[로그인]</a>';
      $("#login").html(content);
      var content= '<a href="/cf/join">[회원가입]</a>';
      $("#join").html(content);
   }else{
      var adminRight = "${sessionScope.adminRight}";
      if(adminRight=="true"){
    	  var content='🏀 안녕하세요 ${sessionScope.loginId} 님! <a href="/cf/adminUser">관리자페이지</a> <a href="/cf/logout">[로그아웃]</a>';
          $("#login").html(content); 
      }else{
    	  var content='🏀 안녕하세요 ${sessionScope.loginId} 님! <a href="/cf/userNoticeAlarm">🔔</a> <a href="/cf/logout">[로그아웃]</a>';
          $("#login").html(content);
      }
	 
   }
   console.log("${sessionScope.adminRight}");
</script>
</html>