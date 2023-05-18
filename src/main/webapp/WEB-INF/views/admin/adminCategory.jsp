<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>  
<script src="resources/js/jquery.twbsPagination.js" type="text/javascript"></script>
<style>
	table, th, td{
      border : 1px solid black;
      border-collapse: collapse;
      padding : 5px 10px;
   }
</style>
</head>
<body>
	<table>
		<tr>
			<th>
				<a href="adminTag">
					<h3>태그 관리</h3>
				</a>
			</th>
			<th>
				<a href="adminCategory">
					<h3>카테고리 수정</h3>
				</a>
			</th>
		</tr>
	</table>
	<input id="searchTag" type="text" name="searchTag" placeholder="카테고리 내용 검색">
	<button id="searchButton">검색</button>
	<button onclick="window.open('adminTagRegist.go','카테고리 추가','width=400px,height=400px')">카테고리 추가</button>
	<table>
		<thead>
			<tr>
				<th>no</th>
				<th>카테고리 ID</th>
				<th>카테고리 내용</th>
				<th>수정</th>	
			</tr>
		</thead>
		<tbody>
			<tbody id="list">			
			<!-- list 출력 위치 -->
			</tbody>
			<tr>
			  <th colspan="4" id="paging" style="text-align:center">  
			    <div class="container">                  
			      <nav aria-label="Page navigation">
			        <ul class="pagination justify-content-center" id="pagination"></ul>
			      </nav>
			    </div>
			  </th>
			</tr>
		</tbody>	
	</table>
</body>
<script>
	var showPage = 1;
	var searchText = 'default';
	listCall(showPage);
	$('#searchButton').click(function(){
		//검색어 확인 
		searchText = $('#searchTag').val();
		listCall(showPage);
		$('#pagination').twbsPagination('destroy');
	});
	
	function listCall(page){
		   $.ajax({
		      type:'post',
		      url:'adminTagList.ajax',
		      data:{
		    	  'page':page,
		    	  'searchText':searchText,
		      },
		      dataType:'json',           
		      success:function(data){
		         console.log(data);
		         listPrint(data.list);
		         console.log(data.totalList);
		         $('#pagination').twbsPagination({
					startPage:1, // 시작 페이지
					totalPages:Math.ceil(data.totalList/10),// 총 페이지 수 
					visiblePages:5,// 보여줄 페이지
					onPageClick:function(event,page){ // 페이지 클릭시 동작되는 (콜백)함수
						console.log(page,showPage);
						if(page != showPage){
							showPage=page;
							listCall(page);
						}
					}
		         });
		      }
		   });
		}
	
	function listPrint(list){
		var content ='';
		
		list.forEach(function(item,idx){
			
			
			content +='<tr>';
			content +='<td>'+item.tagIdx+'</td>';
			content +='<td>'+item.tagId+'</td>';
			content +='<td>'+item.tagContent+'</td>';
			content +='<td><button onclick="tagUpdate('+item.tagIdx+')">수정</button></td>';
			content +='</tr>';			
		});
		$('#list').empty();
		$('#list').append(content);
	}
function tagUpdate(tagIdx){
	console.log(tagIdx);
	window.open('adminTagUpdate.go?tagIdx='+tagIdx,'태그 수정','width=400px,height=400px');
}						
	
</script>
</html>
			
			
			
			
			
	