
//검색 결과 불러오기

function geocode(jsonData) {
	let idx = 0;
	deleteMarkers();
	$.each(jsonData, function(index, vo) {
		let tmpLat;
		let tmpLng;
		$.get("https://maps.googleapis.com/maps/api/geocode/json"
				,{	key:'AIzaSyBnLgV1GDMbXjDMac8DwhbgxnY8Fpi6vl8'
					, address:vo.dong+"+"+vo.aptName+"+"+vo.jibun
				}
				, function(data, status) {
					//alert(data.results[0].geometry.location.lat);
					tmpLat = data.results[0].geometry.location.lat;
					tmpLng = data.results[0].geometry.location.lng;
					$("#lat_"+index).text(tmpLat);
					$("#lng_"+index).text(tmpLng);
					addMarker(tmpLat, tmpLng, vo.aptName);
				}
				, "json"
		);//get
	});//each
}


// 지도 API 사용 JS
var multi = {lat: 37.5665734, lng: 126.978179};
var map;
let markers = [];
function initMap() {
	map = new google.maps.Map(document.getElementById('map'), {
		center: multi, zoom: 12
	});
	var marker = new google.maps.Marker({position: multi, map: map});
}
function setMapOnAll(map) {
	for (let i = 0; i < markers.length; i++) {
		markers[i].setMap(map);
	}
}
function clearMarkers() {
	setMapOnAll(null);
}
function deleteMarkers() {
	  clearMarkers();
	  markers = [];
}
function addMarker(tmpLat, tmpLng, aptName) {
	var marker = new google.maps.Marker({
		position: new google.maps.LatLng(parseFloat(tmpLat),parseFloat(tmpLng)),
		label: aptName,
		title: aptName
	});
	marker.addListener('click', function() {
		map.setZoom(17);
		map.setCenter(marker.getPosition());
		callHouseDealInfo();
	});
	marker.setMap(map);
	markers.push(marker);
}
function callHouseDealInfo() {
	alert("아파트 거래 정보를 불러올 수 있습니다.");
}