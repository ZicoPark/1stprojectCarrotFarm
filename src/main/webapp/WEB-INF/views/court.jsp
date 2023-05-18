<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>🏀 당근농장</title>
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=77b263fb5e91c183b524a3d94385df7c&libraries=services"></script>
<style>
#map {
	margin: 50px; /* 원하는 margin 값으로 설정하세요 */
	width: 500px;
	height: 500px;
}

</style>
</head>
<body>
	<input type="hidden" id="searchTest" value=""/>
	<div id="map" style="width:500px;height:500px;"></div>
	${adress}
	<table>
		<thead>
			<tr>
				<th>이름</th>			
			</tr>
		</thead>
		<tbody id="test">
		
		</tbody>
	</table>
</body>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
mapOption = {
    center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
    level: 3 // 지도의 확대 레벨
};  

//지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

//주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

//주소로 좌표를 검색합니다
geocoder.addressSearch('종로구', function(result, status) {

	var ps = new kakao.maps.services.Places();
// 정상적으로 검색이 완료됐으면 
 if (status === kakao.maps.services.Status.OK) {

    var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

    // 결과값으로 받은 위치를 마커로 표시합니다
    var marker = new kakao.maps.Marker({
        map: map,
        position: coords
    });
    console.log(coords);

    // 인포윈도우로 장소에 대한 설명을 표시합니다
    var infowindow = new kakao.maps.InfoWindow({
        content: '<div style="width:150px;text-align:center;padding:6px 0;">선호지역</div>'
    });
    infowindow.open(map, marker);

    // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
    map.setCenter(coords);
    var searchTest = $('#searchTest').val();
    if(searchTest!=""){
    	ps.keywordSearch(searchTest, placesSearchCB,{x:coords.La,y:coords.Ma,radius:20000});
    }else{
    	
   	 	ps.keywordSearch('신내공원 농구장 ', placesSearchCB,{x:coords.La,y:coords.Ma,radius:20000});    
    }
    
} 
}); 
 

// 키워드로 장소를 검색합니다
 

// 키워드 검색 완료 시 호출되는 콜백함수 입니다
function placesSearchCB (data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        var bounds = new kakao.maps.LatLngBounds();
        console.log(data);
        var content = '';
        for (var i=0; i<data.length; i++) {
            displayMarker(data[i]);    
            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
            content += '<tr>';
    		content+='<td>' + '<a href="courtDetail.do?courtName=' + data[i].place_name + '&courtLatitude=' + data[i].y + '&courtLongitude=' + data[i].x + '&courtAddress='+data[i].address_name+'">' + data[i].place_name + '</a></td>';
    		content += '</tr>';
        }
        $('#test').empty();
    	$('#test').append(content);

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
        map.setBounds(bounds);
    } 
}
var infowindow = new kakao.maps.InfoWindow({
    map: map,
    position: new kakao.maps.LatLng(33.450701, 126.570667),
    content: 'I am InfoWindow'
});
// 지도에 마커를 표시하는 함수입니다
function displayMarker(place) {
    
    // 마커를 생성하고 지도에 표시합니다
    var marker = new kakao.maps.Marker({
        map: map,
        position: new kakao.maps.LatLng(place.y, place.x) 
    });

    // 마커에 클릭이벤트를 등록합니다
    kakao.maps.event.addListener(marker, 'click', function() {
        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
        infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
       
        infowindow.open(map, marker);
    });
}
var markerPosition  = new kakao.maps.LatLng(37.58186,126.81324); 
//마커를 생성합니다
var marker = new kakao.maps.Marker({
 position: markerPosition,
 clickable: true
});

//마커가 지도 위에 표시되도록 설정합니다
marker.setMap(map);

var iwContent = '<div style="padding:5px;">Hello World!</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다

//인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({
content : iwContent,
removable : iwRemoveable
});

//마커에 클릭이벤트를 등록합니다
kakao.maps.event.addListener(marker, 'click', function() {
  // 마커 위에 인포윈도우를 표시합니다
  infowindow.open(map, marker);  
})



</script>
</html>