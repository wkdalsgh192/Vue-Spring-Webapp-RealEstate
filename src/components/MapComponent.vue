<template>
    <div>
        <div class="map" id="map" style="width: 100%; height: 1000px; margin: auto;">
            <v-toolbar
            min-width="400px"
            dense
            floating
            style="z-index: 10;"
            >
                <v-text-field
                    hide-details
                    prepend-icon="mdi-magnify"
                    single-line
                ></v-text-field>

                <!-- <v-btn icon>
                    <v-icon>mdi-crosshairs-gps</v-icon>
                </v-btn>

                <v-btn icon>
                    <v-icon>mdi-dots-vertical</v-icon>
                </v-btn> -->
            </v-toolbar>
        </div>
    </div>
</template>

<script>
export default {
    // data() {
    //     // zIndex: 10;
    // },
    mounted() {
        if (window.kakao && window.kakao.maps) {
            this.initMap();
        } else {
            const script = document.createElement('script');
            /* global kakao */
            script.onload = () => kakao.maps.load(this.initMap);
            script.src = 'http://dapi.kakao.com/v2/maps/sdk.js?autoload=false&appkey=123cf81f3fe1f9fbdcaf7be8ef5d58b7&libraries=services,clusterer,drawing';
            document.head.appendChild(script);
        }
    },
    methods : {
        initMap() {
            // v3가 모두 로드된 후, 콜백함수를 실행한다.
            kakao.maps.load(() => {
                var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
                mapOption = {
                    center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
                    level: 6 // 지도의 확대 레벨
                };
                var map = new kakao.maps.Map(mapContainer, mapOption);

                var markerPosition  = new kakao.maps.LatLng(37.566826, 126.9786567); 
                var marker = new kakao.maps.Marker({
                    position: markerPosition
                });
                marker.setMap(map);
            });
            
        }

    }
}
</script>

<style>

</style>