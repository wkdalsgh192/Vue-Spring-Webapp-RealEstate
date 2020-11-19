var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 6 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

var marker = new kakao.maps.Marker(), // 클릭한 위치를 표시할 마커입니다
    infowindow = new kakao.maps.InfoWindow({zindex:1}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다


//검색 결과 불러오기
function renewMap(Data) {
	let idx = 0;
	let lng, lat;
	let positions = new Array();
	$.each(Data, function(index, vo) {
		lat = vo['x'], lng = vo['y'];
		positions.push({'latlng' : new kakao.maps.LatLng(vo['x'], vo['y'])});
	});//each
	
	// 지도 이동시키기
/*	console.log("lat: "+lat+" lng : "+lng);*/
	setCenter(lat, lng);
	drawMarker(positions);
}


// 중심 좌표 변경하기
function setCenter(lat, lng) {
    // 이동할 위도 경도 위치를 생성합니다 
    var moveLatLon = new kakao.maps.LatLng(lat, lng);
    
    // 맵 다시 그리기
    setTimeout(function(){ map.relayout();}, 1000);
    // 지도 중심을 이동 시킵니다
    map.setCenter(moveLatLon);
}

// 마커 그리기

//마커 이미지의 이미지 주소입니다
var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";

// 마커 함수 선언
function drawMarker(positions) {
	for (var i = 0; i < positions.length; i ++) {
	    // 마커 이미지의 이미지 크기 입니다
	    var imageSize = new kakao.maps.Size(24, 35); 
	    
	    // 마커 이미지를 생성합니다    
	    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
	    
	    // 마커를 생성합니다
	    var marker = new kakao.maps.Marker({
	        map: map, // 마커를 표시할 지도
	        position: positions[i].latlng, // 마커를 표시할 위치
	        title : '헬로우', // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
	        image : markerImage // 마커 이미지 
	    });
	}
}