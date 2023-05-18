<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>🏀 당근농장</title>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>    
<script src="resources/js/jquery.twbsPagination.js" type="text/javascript"></script>

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
		height : 87%;
		background-color: #f8f9fa;
		padding: 10 30 10;
		margin : 5px;
		float:right;
		
	}
	
	#LNB {
		width:20%;
		height : 87%;
		background-color: #f8f9fa;
		float:left;
		margin : 5px;
		font-weight: bold;
        font-size: 15px;
		text-align:center;
		
	}
	
	#LNB ul li {
	margin-top : 30px;
    margin-bottom: 90px; /* 원하는 줄간격 크기 */
	}
	
	
		th, td {
		margin : 15px;
		border : 1px solid black;	
		padding : 10px 10px;
		border-collapse : collapse;
		border-left: none;
    	border-right: none;
	}
	
	table{
		width:95%;
		height:70%;
		text-align:center;
		border : 3px solid black;	
		border-collapse : collapse;
		padding : 20px 10px;
	}
	
	#gamePlay, #sort{
		width: 100px;
    	height: 30px;
    	margin : 5px;
	}
	
	#freeboardSearchInput{
		width: 200px;
    	height: 30px;
    	
	}
	
	#listButton, #saveButton {
		font-size: 15px;
		height: 30px;
    	margin : 5px;
	
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
		<%@ include file="../loginBox.jsp" %>
	</div> 
	<%@ include file="../GNB.jsp" %>
	

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
	        <a href="/cf/team/teamPage.go?teamIdx=${teamIdx}" style="font-weight: bold; font-size: 18px; color: black;">팀소개</a>
	      <br/><br/>
	        <a href="/cf/team/teamUserList.go?teamIdx=${teamIdx}" style="font-weight: bold; font-size: 18px; color: black;">팀원</a>
	      <br/><br/>
	        <a href="/cf/team/teamGame.go?teamIdx=${teamIdx}" style="font-weight: bold; font-size: 18px; color: black;">참여 경기</a>
	      <br/><br/>
	        <a href="/cf/teamnoticeboardList.do?teamIdx=${teamIdx}" style="font-weight: bold; font-size: 18px ; color: black;">팀 공지 사항</a>
	      <br/><br/>
	        <a href="/cf/teampictureboardList.do?teamIdx=${teamIdx}" style="font-weight: bold; font-size: 18px; color: orange;">팀 사진첩</a>
	</div>
	
	<div id="content">
	<form action="teampictureboardWrite.do?teamIdx=${teamIdx}" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
	<input type="hidden" name="categoryId" value="b011"/>
	<input type="hidden" name="teamIdx" value="${teamIdx}"/>
		<table>
			<tr>
				<th>제목</th>
				<td>
					<input type="text" name="subject" id="subjectInput" maxlength="60" style="width : 950px ; height : 30px"
					 	onfocus="hideMessage()" onblur="showMessage()" placeholder="제목은 60자까지 가능합니다"/>
        			<span id="message" style="color: red;"></span>
				</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td><input type="text" name="userId" value="${userId}" style="border:none; background-color: #f8f9fa ; text-align:center;"readonly/> </td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea name="content" id="contentInput" style="width : 950px; height : 200px; resize: none"/></textarea></td>
			</tr>
			<tr>
				<th>사진 업로드</th>			
				<td>
					<div id='image_preview'>
   				 		<input type='file' name="photo" id='btnAtt' multiple='multiple' />
    				<div id='att_zone' data-placeholder='파일을 첨부 하려면 파일 선택 버튼을 클릭하거나 파일을 드래그앤드롭 하세요'></div>
  					</div>
				</td>
			</tr>
			<tr>
				<th colspan="2">
					<input type = "button" onclick="location.href='./teampictureboardList.do?teamIdx=${teamIdx}'" value="리스트" class="btn btn-outline-dark" id="listButton"/>
					<button class="btn btn-outline-dark" id="saveButton">저장</button>
				</th>
			</tr>
		</table>
	</form>
	</div>
</body>
<script>
function validateForm() {
	var subject = document.getElementById('subjectInput').value;
	var content = document.getElementById('contentInput').value;
	
	if (subject.trim() == '') {
		alert('제목을 입력해주세요.');
		return false;
	}
	
	if (content.trim() == '') {
		alert('내용을 입력해주세요.');
		return false;
	}
	
	return true;
}


function hideMessage() {
    document.getElementById("message").style.display = "none";
}

function showMessage() {
    document.getElementById("message").style.display = "inline";
}



( /* att_zone : 이미지들이 들어갈 위치 id, btn : file tag id */
		  imageView = function imageView(att_zone, btn){

		    var attZone = document.getElementById(att_zone);
		    var btnAtt = document.getElementById(btn)
		    var sel_files = [];
		    
		    // 이미지와 체크 박스를 감싸고 있는 div 속성
		    var div_style = 'display:inline-block;position:relative;'
		                  + 'width:150px;height:120px;margin:5px;border:1px solid #00f;z-index:1';
		    // 미리보기 이미지 속성
		    var img_style = 'width:100%;height:100%;z-index:none';
		    // 이미지안에 표시되는 체크박스의 속성
		    var chk_style = 'width:30px;height:30px;position:absolute;font-size:24px;'
		                  + 'right:0px;bottom:0px;z-index:999;background-color:rgba(255,255,255,0.1);color:#f00';
		  
		    btnAtt.onchange = function(e){
		      var files = e.target.files;
		      var fileArr = Array.prototype.slice.call(files)
		      for(f of fileArr){
		        imageLoader(f);
		      }
		    }  
		    
		  
		    // 탐색기에서 드래그앤 드롭 사용
		    attZone.addEventListener('dragenter', function(e){
		      e.preventDefault();
		      e.stopPropagation();
		    }, false)
		    
		    attZone.addEventListener('dragover', function(e){
		      e.preventDefault();
		      e.stopPropagation();
		      
		    }, false)
		  
		    attZone.addEventListener('drop', function(e){
		      var files = {};
		      e.preventDefault();
		      e.stopPropagation();
		      var dt = e.dataTransfer;
		      files = dt.files;
		      for(f of files){
		        imageLoader(f);
		      }
		      
		    }, false)
		    

		    
		    /*첨부된 이미리즐을 배열에 넣고 미리보기 */
		    imageLoader = function(file){
		      sel_files.push(file);
		      var reader = new FileReader();
		      reader.onload = function(ee){
		        let img = document.createElement('img')
		        img.setAttribute('style', img_style)
		        img.src = ee.target.result;
		        attZone.appendChild(makeDiv(img, file));
		      }
		      
		      reader.readAsDataURL(file);
		    }
		    
		    /*첨부된 파일이 있는 경우 checkbox와 함께 attZone에 추가할 div를 만들어 반환 */
		    makeDiv = function(img, file){
		      var div = document.createElement('div')
		      div.setAttribute('style', div_style)
		      
		      var btn = document.createElement('input')
		      btn.setAttribute('type', 'button')
		      btn.setAttribute('value', 'x')
		      btn.setAttribute('delFile', file.name);
		      btn.setAttribute('style', chk_style);
		      btn.onclick = function(ev){
		        var ele = ev.srcElement;
		        var delFile = ele.getAttribute('delFile');
		        for(var i=0 ;i<sel_files.length; i++){
		          if(delFile== sel_files[i].name){
		            sel_files.splice(i, 1);      
		          }
		        }
		        
		        dt = new DataTransfer();
		        for(f in sel_files) {
		          var file = sel_files[f];
		          dt.items.add(file);
		        }
		        btnAtt.files = dt.files;
		        var p = ele.parentNode;
		        attZone.removeChild(p)
		      }
		      div.appendChild(img)
		      div.appendChild(btn)
		      return div
		    }
		  }
		)('att_zone', 'btnAtt')

</script>
</html>