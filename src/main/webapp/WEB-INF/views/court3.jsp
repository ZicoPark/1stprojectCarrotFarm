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

<script src="resources/js/twbsPagination.js" type="text/javascript"></script>
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
		height : 83%;
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
	#searchCourt, #gu, #inOut{
		width: 200px;
    	height: 30px;
    	margin : 5px;
    }
	
	
	
	table {
    border-collapse: collapse;
    width:60%; 
    height: 80%;
  }
  
  td, th {
    padding: 8px;
  }
</style>
</head>
<body>
	<div style="float: right;">
		<%@ include file="loginBox.jsp" %>
	</div> 
	<%@ include file="GNB.jsp" %>
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
	
	<div >
		<select name="gu" id="gu" onchange="courtSort('gu')" style = "margin-left : 30px">
			<option value="none">위치</option>
			<option value="서울특별시">서울</option>
			<c:forEach items="${guList}" var="gu">
				console.log(${gu.gu});
				<option value="${gu.gu}">${gu.gu}</option>
			</c:forEach>
	      </select>
	      <select name="inOut" id="inOut" onchange="courtSort('inOut')">
	      	<option value="none">실내/외</option>
	      	<option value="in">실내</option>
	      	<option value="out">실외</option>
	      </select>
	      <input id="searchCourt" type="text" name="searchCourt" placeholder="경기장 검색">
		<button type="button" style="font-size:15px;" onclick="courtSort('courtSearch')" class="btn btn-outline-dark" id = "ssearchbutton">검색</button>
		<button style="font-size:15px;" onclick="window.open('courtTipOff.go','경기장 제보','width=400px,height=400px')" class="btn btn-outline-dark" id = "courtjaebo">경기장 제보</button>
		
    </div> 
	<hr/>
	<br/><br/>
	<div id="map" style="width:35%; height:70%; float:left; margin: 20px, 10px, 0px, 20px;"></div>
	
	<table id="courtList" style="margin : 10px; float : right" >
		<thead>
			<tr>
				<th style="width:10%;">사용여부</th>
				<th style="width:10%;">지역</th>				
				<th style="width:10%;">실내/외</th>
				<th style="width:30%;" id="courtName"><a href="courtDetail.do?courtIdx=${court.courtIdx}">경기장 이름</a></th>
				<th style="width:30%;">경기장 주소</th>
				<th style="width:10%;">평점</th>
			</tr>
		</thead>
			<tr>
				<th colspan="6"> <hr/> </th>
			</tr>
		<tbody id="list">			
			<c:forEach items="${courtList}" var="court" varStatus="status" end="9">
				<tr>
					<td style="width:10%;">${court.courtState}</td>
					<td style="width:10%;">${court.gu}</td>				
					<td style="width:10%;">
						<c:if test="${court.courtInOut eq 'out'}">실외</c:if>
						<c:if test="${court.courtInOut eq 'in'}">실내</c:if>
					</td>
					<td style="width:30%;" id="courtName"><a href="courtDetail.do?courtIdx=${court.courtIdx}">${court.courtName}</a></td>
					<td style="width:30%;">${court.courtAddress}</td>
					<td style="width:10%;">☆${court.courtStar}</td>
				</tr>
			</c:forEach>
		</tbody>
		
		
			<tr>
				  <th colspan="6" id="paging" style="text-align:center;">  
				    <div class="container">                 
				   
				      <nav aria-label="Page navigation">
				      	
				        <ul class="pagination justify-content-center" id="pagination"></ul>
				      </nav>
				    </div>
				  </th>
				</tr>
	</table>
	
	</div>
</body>
<script>
	paging("${totalPages}");
	var showPage = 1;
	var address="${address}";
	
	function courtSort(type,page1=1){
		// 위치 , 실내 , 검색어 + type -> gu inout search -> if(type != 'search') {search=""}
		address = $('#gu').val();
		var inOut = $('#inOut').val();
		var searchCourt =$('#searchCourt').val();
		showPage=page1;
		console.log(address);
		console.log(inOut);
		
		$.ajax({
			type:'get',
			url:'courtList.ajax',
			data:{"gu":address,
				  "inOut":inOut,
				  "searchCourt":searchCourt,
				  "type":type,
				  "page":showPage
			},
			dataType:'json',
			success:function(data){
				console.log(data);
				console.log(data.courtList.length);
				for(var i=0;i<markers.length;i++){
					markers[i].setMap(null);
				}
				console.log(data.courtList);
				markerDraw(data.courtList);
				courtListDraw(data.courtList);
				mapGeocoder(address);
			    infowindow.close();
			    
			    $('#pagination').twbsPagination('destroy');
			    //데이터가 없을 때
			    if(data.totalList==0){
			    	alert("검색결과가 없습니다.");
			    	return;
			    }
			    
			    $('#pagination').twbsPagination({
					startPage:showPage,	//시작페이지
					totalPages:Math.ceil(data.totalList/10),//총 페이지 수
					visiblePages:5, //보여줄 페이지 [1][2][3][4][5]
					onPageClick:function(event,page){// 페이지 클릭시 동작되는 함수(콜백)
						if(page != showPage){
							showPage = page;	
							courtSort(type,showPage);
						}	
					}
				});
			    
			    
			    
			},
			error:function(e){
				console.log(e);
			}
		});	
	};
	
	//paging plugin
	function paging(totalList, type = ""){
		$('#pagination').twbsPagination({
			startPage:showPage,	//시작페이지
			totalPages:Math.ceil(totalList/10),//총 페이지 수
			visiblePages:5, //보여줄 페이지 [1][2][3][4][5]
			onPageClick:function(event,page){// 페이지 클릭시 동작되는 함수(콜백)
			console.log(page);
				if(page != showPage){
					showPage = page;	
					
					if(type == "") {
						// 리스트 + 페이징 함수 변경
						$.ajax({
							type:'get',
							url:'courtPage.ajax',
							data:{"page":page
							},
							dataType:'json',
							success:function(data){
								console.log(data.courtList);
								courtListDraw(data.courtList);
							},
							error:function(e){
								console.log(e);
							}
						});				
						
					}else{
						
					}
					
					
					
				}	
			}
		});	
	}
										
		
		
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = {
	    center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	    level: 6 // 지도의 확대 레벨
	};  

	//지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 

	//주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();
	
	//주소로 좌표를 검색합니다
	geocoder.addressSearch(address, function(result, status) {
	
	// 정상적으로 검색이 완료됐으면 
	 if (status === kakao.maps.services.Status.OK) {
	
	    var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

    // 결과값으로 받은 위치를 마커로 표시합니다
    var marker = new kakao.maps.Marker({
        map: map,
        position: coords
    });
    markers.push(marker);

    // 인포윈도우로 장소에 대한 설명을 표시합니다
    	infowindow = new kakao.maps.InfoWindow({
        content: '<div class="test" style="width:150px;text-align:center;padding:6px 0;">선택지역</div>'
    });
    infowindow.open(map, marker);

    // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
    map.setCenter(coords);
} 
});
	var markers=[];
	var position=[];
	var infowindow='';
	<c:forEach items="${courtList}" var="item">
		position.push({
			 content :'${item.courtName}', latlng: new kakao.maps.LatLng(${item.courtLatitude}, ${item.courtLongitude})});
	</c:forEach>
	for(var i=0; i<position.length;i++){
		

		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
		     map: map, // 마커를 표시할 지도
		     position: position[i].latlng, // 마커를 표시할 위치 
		});
		markers.push(marker);
		console.log(markers[i]);
	       
	    var infowindow = new kakao.maps.InfoWindow({
	        content: position[i].content // 인포윈도우에 표시할 내용
	    });
	    kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
	    kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
	}
	function makeOverListener(map, marker, infowindow) {
	    return function() {
	        infowindow.open(map, marker);
	    };
	}
	function makeOutListener(infowindow) {
	    return function() {
	        infowindow.close();
	    };
	}
	
	function markerDraw(list){
		markers=[];
		position=[];
		list.forEach(function(item,idx){
			console.log(item.courtLatitude);
		position.push({
			 content :item.courtName, 
			 latlng: new kakao.maps.LatLng(item.courtLatitude, item.courtLongitude)
			 });
		});
		for(var i=0; i<position.length;i++){
			// 마커를 생성합니다
			var marker = new kakao.maps.Marker({
		    	map: map, // 마커를 표시할 지도
		     	position: position[i].latlng, // 마커를 표시할 위치 
			});
			markers.push(marker);
			console.log(markers[i]);
	    var infowindow = new kakao.maps.InfoWindow({
	        content: position[i].content // 인포윈도우에 표시할 내용
	    });
	    kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
	    kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
		}
		function makeOverListener(map, marker, infowindow) {
	    	return function() {
	        	infowindow.open(map, marker);
	    	};
		}
		function makeOutListener(infowindow) {
	    	return function() {
	        	infowindow.close();
	    	};
		}
	}
	function courtListDraw(list){
		$('#list').empty();
		var content = '';
		list.forEach(function(item,index){
			content += '<tr>';
			content += '<td>'+item.courtState+'</td>';
			content+='<td>'+item.gu+'</td>';
			if(item.courtInOut=='out'){
				content +='<td>실외</td>';
			}else{
				content +='<td>실내</td>';
			}
			content +='<td id="courtName"><a href="courtDetail.do?courtIdx='+item.courtIdx+'">'+item.courtName+'</a></td>';
			content +='<td>'+item.courtAddress+'</td>';
			content +='<td>⭐'+item.courtStar.toFixed(2)+'</td>';
		});
		$('#list').append(content);
	}
	function mapGeocoder(address){
		var geocoder = new kakao.maps.services.Geocoder();
		geocoder.addressSearch(address, function(result, status) {
			 if (status === kakao.maps.services.Status.OK) {
			
			var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
		    var marker = new kakao.maps.Marker({
		        map: map,
		        position: coords
		    });
		    markers.push(marker);
		    	infowindow = new kakao.maps.InfoWindow({
		        content: '<div style="width:150px;text-align:center;padding:6px 0;">선택지역</div>'
		    });
		    infowindow.open(map, marker);
		    map.setCenter(coords);
		} 
		});
	}
	
	$(document).ready(function() {
		  $('#courtjaebo').css('margin-top', '-2px');
		  $('#ssearchbutton').css('margin-top', '-2px');
		});
</script>
</html>
	
	