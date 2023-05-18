<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>🏀 당근농장</title>
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<style></style>
</head>
<body>
   <form action="userReport.do" method="post" id="form">
      <input name="reportId" type="text" value="${userIdx}" hidden />
      <input name="userId" type="text" value="${loginId}" hidden />
      <input name="reportUserId" type="text" value="${userId}" hidden />
      
      <h3>회원 신고</h3>
               
      <label>신고 사유 선택 </label>
         <select name="report" id="report" style=" width:300px; margin: 10px;">
            <option value="none">신고 사유 </option>
            <option value="부적절한 사진">부적절한 사진 사용</option>
            <option value="부적절한 닉네임">부적절한 닉네임 사용</option>
            <option value="기타">기타</option>
         </select>
         </br>
         <textarea name="content" id="content" style="width: 500px; height: 200px;" placeholder="기타 신고사유를 입력해 주세요." ></textarea>
         </br>
      <input type="button" value="제출" onclick="subChk()" style="margin: 10px;" />
      <input type="button" onclick="window.close()" id="closeBtn" value="닫기"/>
   </form>
</body>
<script>
function subChk(){
   console.log($('#report').val());
   
   if($('#report').val() == 'none'){
      alert('신고 사유를 선택해 주세요.');
      return false;
   }
   
   
   if($('#report').val() == '기타'){
      if($('#content').val() == ''){
         alert('신고 사유를 입력해 주세요.');
         return false;
      }         
   }
   
   if(!confirm('신고는 취소할 수 없습니다.  \n정말 신고하시겠습니까?')){
        return false;
    }
   
   $('#form').submit();
}
</script>
</html>