<template>
    <div>
        <div id="seg">
            <div class="item-cell" v-for="result in results" :key="result.no">
                <div class="item-cell-img"><img src="@/assets/dogok-raemian.jpg"></div>
                <div class="item-cell-desc">
                    <h4><a class="item-title" href="#">{{ result.aptName }}</a></h4>
                    <p> 거래금액 : 60억 원</p>
                    <p> 면적 : <span> </span> </p>
                    <p> 최종 수정일 : <span>2020.11.16</span> </p>
                </div>
            </div>
        </div>
        <div class="map" id="map" style="width: 100%; height: 1000px; margin: auto;">
            <v-toolbar
            dense
            floating
            style="z-index: 10;"
            >
                <v-text-field
                    hide-details
                    prepend-icon="mdi-magnify"
                    single-line
                    v-model="keyword"
                    @keydown.enter="getKeyword('')"
                ></v-text-field>

                <v-btn icon>
                    <v-icon>mdi-crosshairs-gps</v-icon>
                </v-btn>

                <v-btn icon>
                    <v-icon>mdi-dots-vertical</v-icon>
                </v-btn>
            </v-toolbar>
            
        </div>
    </div>
</template>

<script>
import index from '../store';
import axios from "axios";
export default {
    index,
    data() {
        return {
            keyword: '',
            results : new Array(),
        }
    },
    mounted() {
       if (window.kakao && window.kakao.maps) {
            // this.initMap();
            this.callData();
        } else {
            const script = document.createElement('script');
            /* global kakao */
            script.onload = () => kakao.maps.load(this.initMap);
            script.src = 'http://dapi.kakao.com/v2/maps/sdk.js?autoload=false&appkey=123cf81f3fe1f9fbdcaf7be8ef5d58b7&libraries=services,clusterer,drawing';
            document.head.appendChild(script);
        }
        
    },
    methods : {
        getMap(lat, lng) {
            var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
                mapOption = {
                    center: new kakao.maps.LatLng(lat, lng), // 지도의 중심좌표
                    level: 5 // 지도의 확대 레벨
                };
            return new kakao.maps.Map(mapContainer, mapOption);
        },
        initMap() {
            // v3가 모두 로드된 후, 콜백함수를 실행한다.
            kakao.maps.load(() => {
                var map = this.getMap(37.566826, 126.9786567);

                var markerPosition  = new kakao.maps.LatLng(37.566826, 126.9786567); 
                var marker = new kakao.maps.Marker({
                    position: markerPosition
                });
                marker.setMap(map);
            }); 
        },
        callData() {
            // keyword를 vuex에서 가져와서 axios로 보내준다.
            const strArr = this.$store.state.keyword.split(' ');
            const sKey = strArr.splice(strArr.length-1,1)[0];
            const sWord = strArr.join(' ');
            // 백엔드로 검색어를 보내주는 부분
            if ('아파트' === sKey) {
                axios.get('http://localhost:8000/happyhouse/map/house/info/'+sWord)
                .then((response) => {
                    // 결과 데이터를 받아옴
                    console.log(response.data);
                    // 결과 데이터를 저장
                    for (let index = 0; index < response.data.length; index++) {
                        this.results.push(response.data[index]);
                    }
                    this.renewMap(response.data);                 
                })
            }
        },
        renewMap(data) {
            // kakao.maps 가 로드되기 전에 kakao.maps method가 호출되면 에러가 난다.
            kakao.maps.load(() => {
                let lat, lng;
                let positions = new Array();
                data.forEach((vo) => {
                    lat = vo['lat'], lng=vo['lng'];
                    
                    positions.push({'latlng' : new kakao.maps.LatLng(lat, lng)});
                });

                // setTimeout(function(){ map.relayout();}, 1000);
                
                    var map = this.getMap(lat, lng);
                    this.drawMarker(positions, map);
            })            
        },
        drawMarker(positions, map) {
            console.log('latlng : '+ positions[10].latlng);
            for (var i = 0; i < positions.length; i ++) {
                // 마커 이미지 url 및 이미지 크기
                var imageSize = new kakao.maps.Size(24, 35);
                var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";     
                
                // 마커 이미지를 생성합니다
                var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
                
                // 마커를 생성합니다
                new kakao.maps.Marker({
                    map: map, // 마커를 표시할 지도
                    position: positions[i].latlng, // 마커를 표시할 위치
                    title : '헬로우', // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
                    image : markerImage // 마커 이미지 
                });
	        }
        },
        getKeyword(url) {
            console.log('keyword : ', this.keyword);
            this.$store.dispatch("GET_KEYWORD", {keyword: this.keyword, url: url});
            this.callData();
        }

    }
}
</script>

<style>
    #seg {
        position: fixed;
        width: 400px;
        height: 100vh;
        z-index: 10;
        background-color:white;
        opacity: 0.7;
        overflow:scroll
    }

    .item-cell {
        display: flex;
        padding: 1rem;
        height: 12rem;
    }

    .item-cell-img {
        width: 40%;
        height: 100%;
        margin-right: 1em;
        overflow: hidden;
    }

    .item-cell-img img {
        width: 100%;
        height: 100%;
    }

    .item-cell-desc {
        top:0;
        width: 60%;
        height: 180px;
        vertical-align: top;
        display: flex;
        flex-direction:column;
        justify-content: space-between;
        padding: 1rem 0; 
    }

    .item-title {
        font-size: 1.4rem;
        font-weight: bolder;
        text-decoration: none;
        color: black;
        overflow-x: hidden;
    }

    .item-cell-desc p {
        margin: 0;
        font-weight: 600;
    }
</style>