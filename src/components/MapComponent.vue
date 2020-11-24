<template>
    <div>
        <div id="seg">
            <div class="item-cell" v-for="(result, index) in results" :key="result.no">
                <div class="item-cell-img">
                    <v-icon 
                        class="item-icon white--text" 
                        @click="applyEffect($event); getResult(result);"
                    >mdi-heart</v-icon>
                    <img :src="'./img/'+index%11+'.jpg'">
                    </div>
                <div class="item-cell-desc">
                    <h4><a class="item-title" href="#">{{ result.aptName }}</a></h4>
                    <p> 
                        거래금액 : {{ parseInt(result.price) }}억 원
                        <!-- <button class="rlp">실거래가</button> -->
                        <modal-component :aptName="result.aptName"></modal-component>
                    </p>
                    <p> 면적 : <span> {{ Math.round(result.area, 0) }} 평 </span> </p>
                    <p> 최근 거래일 : <span>{{ result.date }}</span> </p>
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
                    id="searchField"
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
import index, { SET_LATLNG } from '../store';
import ModalComponent from './ModalComponent.vue'
import axios from "axios";

export default {
    index,
    components : {
        ModalComponent
    },
    data() {
        return {
            keyword: '',
            infoArr : new Array(),
        }
    },
    mounted() {
       if (window.kakao && window.kakao.maps) {
            this.callData();
        } else {
            const script = document.createElement('script');
            /* global kakao */
            script.onload = () => kakao.maps.load(this.initMap);
            script.src = 'http://dapi.kakao.com/v2/maps/sdk.js?autoload=false&appkey=123cf81f3fe1f9fbdcaf7be8ef5d58b7&libraries=services,clusterer,drawing';
            document.head.appendChild(script);
        }
        
    },
    computed : {
        results : function() {
            return this.infoArr
        },
    },
    methods : {
        getResult(item) {
            // vueX로 보내기
            // axios로 백엔드로 보내기 -- 로그인이 안 되어있으면 넘어가서는 안 된다.
            if (this.$store.state.id === "") return alert("먼저 로그인해주십시오"); // msg div에 로그인해주십시오 출력
            axios.post('http://localhost:8000/happyhouse/map/house/like', {
                    id : this.$store.state.id,
	                apt_name : item.aptName,
	                price : item.price,
	                area : item.area,
	                last_update : item.date,
                })
                .then((response) => {
                    // msg div에 추가
                    console.log(response)
                })
                .catch((e) => {
                    console.log(e);
                });
        },
        applyEffect: function(event) {
            if (this.$store.state.id == "") return;
            if (event.target.classList.contains("white--text")) {
                event.target.style.WebkitAnimation= "moveUp 0.8s 1";
                event.target.classList.replace('white--text', 'red--text');
            }
        },
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
            const sWord = this.$store.state.keyword;
            this.keyword = sWord;
            // const strArr = this.$store.state.keyword.split(' ');
            // const sKey = strArr.splice(strArr.length-1,1)[0];
            // const sWord = strArr.join(' ');
            // 백엔드로 검색어를 보내주는 부분
            axios.get('http://localhost:8000/happyhouse/map/house/info/'+sWord)
                .then((response) => {
                    // 결과 데이터를 받아옴
                    // 결과 데이터를 저장
                    this.infoArr.splice(0, this.infoArr.length);
                    for (let index = 0; index < response.data.length; index++) {
                        this.infoArr.push(response.data[index]);
                    }
                    this.renewMap(response.data);                 
                })
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

                this.$store.commit(SET_LATLNG, [lat, lng]);
                var map = this.getMap(lat, lng);
                this.drawMarker(positions, map);

                this.addDrag(map);
            })
        },
        getKeyword : function(url) {
            this.$store.dispatch("GET_KEYWORD", {keyword: this.keyword, url: url});
            this.callData();
        },
        addDrag(map) {
            // 비동기 처리로 인해서 값을 가지고 오지 못한다. => Promise 사용
            let latlng = null;
            let geocoder = new kakao.maps.services.Geocoder();
            let that = this; // 핵중요!!!!!!!
            kakao.maps.event.addListener(map, 'dragend', function() {
                latlng = map.getCenter();
                
                const addressSearch = latlng => {
                    return new Promise((resolve, reject) => {
                        geocoder.coord2RegionCode(latlng.getLng(), latlng.getLat(), function(result, status) {
                            if (status === kakao.maps.services.Status.OK) {
                                resolve(result);
                            } else {
                                reject(status);
                            }
                        });
                    })
                }
                (async () => {
                    try {
                        const result = await addressSearch(latlng);
                       for (let index = 0; index < result.length; index++) {
                            if (result[index].region_type === 'H') {
                                // 동에서 숫자 지우기
                                let si = result[index].region_1depth_name;
                                let gugun = result[index].region_2depth_name;
                                let dong = result[index].region_3depth_name;
                                let arr = dong.split("");
                                for (let j = 0; j < arr.length; j++) {
                                    if (isNaN(arr[j])) continue;
                                    arr.splice(j)
                                    dong = arr.join('')
                                }

                                let newAddress = si+" "+gugun+" "+dong;
                                that.keyword = newAddress;
                                that.getKeyword("");
                                break;
                            }
                        }  
                    } catch(e) {
                        console.log(e);
                    }
                })();

            })
            
            
        },
        drawMarker(positions, map) {
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
        opacity: 0.85;
        overflow:scroll
    }

    #seg::-webkit-scrollbar {
        width: 12px;
    }

    #seg::-webkit-scrollbar-thumb {
        background-color: #2f3542;
        border-radius: 10px;
        background-clip: padding-box;
        border: 2px solid transparent;
    }

    #seg::-webkit-scrollbar-track {
        background-color: grey;
        border-radius: 10px;
        box-shadow: inset 0px 0px 5px white;
    }

    .item-cell {
        display: flex;
        padding: 1rem;
        height: 12rem;
    }

    .item-cell-img {
        position:relative;
        width: 40%;
        height: 100%;
        margin-right: 1em;
        overflow: hidden;
    }

    .item-cell-img .item-icon {
        position: relative;
        top: 30px;
        left: 100px;
    }

    .item-cell-img img {
        width: 100%;
        height: 100%;
    }

    .item-cell-img img:hover {
        background: rgb(0,0,0,0.5);
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
        font-size: 1.3rem;
        font-weight: bolder;
        text-decoration: none;
        color: black;
        overflow-x: hidden;
    }

    .item-cell-desc p {
        margin: 0;
        font-weight: 600;
    }

    .item-cell-desc .rlp {
        margin-left: 0.3rem;
        padding: 0.1rem 0.2rem ;
        font-size: 0.5rem;
        border: 0.8px solid black;
        border-radius: 10%;
    }

    @keyframes moveUp {
        0% {transform:translateY(0);}
        50% {transform:translateY(-10px);}
        100% {transform:translateY(0);}
    }
</style>