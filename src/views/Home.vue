<template>
  <div class="home">
    <div class="wrapper back-row-toggle" id="raindrop" v-if="frontRow.length > 0">
      <div class="rain front-row" >
        <div v-for="n in frontRow.length" :key="n" v-html="frontRow[n]">
        </div>
      </div>
      
      <div class="rain back-row" >
        <div v-for="n in backRow.length" :key="n+100" v-html="backRow[n]"></div>
      </div>
    </div>
    <div>
      <img id="home-canvas" src='img/background2.jpg' alt="">
    </div>
    <div class="wrapper">
      <div class="container-input">
        <input list="searchRank" type="text" class="search-term" v-model="temp" ref="search" @click="showRank = !showRank" @keydown.enter="getKeyword" @keydown.once="makeRain">    
          <button type="submit" class="submit-button">
            <i class="fas fa-search"></i>
          </button>
      
      </div>
      <!-- 여기에 추천 검색어가 들어간다. -->
      <div v-show="showRank" class="container-rank">
        <div class="rank">
          <div class="rankList">
            <h3>
              <v-icon large style="color:red;">mdi-fire</v-icon>
              요즘 인기있는 동네예요
              <v-icon large style="color:red;">mdi-fire</v-icon>
            </h3>
            <p v-for="(item, index) in items" :key="item.no">
              <span>{{index+1}}위 </span>
              <a @click="selectRank">{{item.dong}}</a>
              <v-icon v-if="index % 3 == index" style="color:red;">mdi-arrow-up-bold</v-icon>
              <v-icon v-else style="color:blue;">mdi-arrow-down-bold</v-icon>
            </p>
          </div>
          <div class="divider"></div>
          <!-- 차트가 들어가는 곳 -->
          <div class="rankChart">
            <bar-chart class="bar-chart" id="home" v-if="chart !== null" :labelName="chart.labelName" :labels="chart.labels" :data="chart.data" :colors="chart.colors"></bar-chart>
          </div> 
        </div>
      </div>
    </div>
    
    <Header></Header>
    <Footer></Footer>
  </div>
</template>

<script>
import index from "../store";
import Header from "@/components/Header.vue";
import Footer from "@/components/Footer.vue";
import BarChart from "@/components/BarChart.vue";
import Axios from 'axios';
import pattern from 'patternomaly';

export default {
  index,
  components: {
    Header,
    Footer,
    BarChart,
  },
  data() {
    return {
      temp: "",
      showRank: false,
      frontRow: new Array(),
      backRow: new Array(),
      items: [],
      chart: null,
    };
  },
  created() {
    
  },
  computed: {
    // 빈 칸이면 false
    computeLength() {
      return this.keyword.length === 0 ? false : true;
    },
    keyword() {
      return this.$store.state.keyword;
    },
  },
  mounted() {
    Axios
    .get("http://localhost:8000/happyhouse/heart/search")
    .then((response) => {
      // console.log(data);
      this.items = response.data;

      // 차트로 변환하기
      let obj = new Object(),
          labels = new Array(),
          data = new Array();
      response.data.forEach((elem) => {
        labels.push(elem['dong']);
        data.push(elem['cnt']);
      })
      obj.labelName = '조회수';
      obj.labels = labels;
      obj.data = data;
      obj.colors = [pattern.draw('square', '#1f77b4'),pattern.draw('circle', '#ff7f0e'),pattern.draw('diamond', '#2ca02c'),pattern.draw('zigzag-horizontal', '#17becf'),pattern.draw('triangle', 'rgb(255, 99, 132, 0.4)')];
      this.chart = obj;
      console.log(obj);
    })
    .catch(() =>{
      alert("에러 발생");
    })
  },
  methods: {
    selectRank(e) {
      this.temp = e.target.innerHTML;
    },
    getKeyword() {
      this.$store.dispatch("GET_KEYWORD", {
          keyword: this.temp,
          url: "/search",
      });
    },
    makeRain() {
      let rain = document.querySelectorAll('.rain');

      rain.forEach((elem) => {
        elem.textContent = '';
      })

      let increment = 0;
      let drops = "",
          backDrops = "";

      while (increment < 150) {
        let randoHundo = (Math.floor(Math.random() * (98 - 1 + 1) + 1));
        let randoFiver = (Math.floor(Math.random() * (5 - 2 + 1) + 2));
        increment += randoFiver;

        drops = '<div class="drop" style="left: ' + increment + '%; bottom: ' + (randoFiver + randoFiver - 1 + 100) + '%; animation-delay: 0.' + randoHundo + 's; animation-duration: 0.5' + randoHundo + 's;"><div class="stem" style="animation-delay: 0.' + randoHundo + 's; animation-duration: 0.5' + randoHundo + 's;"></div><div class="splat" style="animation-delay: 0.' + randoHundo + 's; animation-duration: 0.5' + randoHundo + 's;"></div></div>';
        backDrops = '<div class="drop" style="right: ' + increment + '%; bottom: ' + (randoFiver + randoFiver - 1 + 100) + '%; animation-delay: 0.' + randoHundo + 's; animation-duration: 0.5' + randoHundo + 's;"><div class="stem" style="animation-delay: 0.' + randoHundo + 's; animation-duration: 0.5' + randoHundo + 's;"></div>';

        this.frontRow.push(drops);
        this.backRow.push(backDrops);
      }
    }
  },
  showRecommend() {

  }
};
</script>

<style scoped>
.bar-chart#home {
  padding-top:30px;
  width: 270px;
  height:270px
}
</style>
<style>

.home {
  overflow: hidden;
}

#home-canvas {
  width: 100vw;
  height: 100vh;
}

.wrapper {
  position:absolute;
  top: 200px;
  width: 100vw;
  opacity:0.9;
}


.container-input {
  display: flex;
  flex-direction: row;
  width: 50%;
  margin: 0 auto;
}

.search-term {
  width: 100%;
  background-color:white;
  border: 1px solid transparent;
  border-right: none;
  padding: 5px 5px 5px 25px;
  height: 54px;
  border-radius: 50px 0 0 50px;
  outline: none;
  font-size:1rem;
}

.submit-button {
  width: 70px;
  height: 54px;
  background: white;
  text-align: center;
  border-radius: 0 50px 50px 0;
  border: 2px solid transparent;
  cursor: pointer;
  font-size: 25px;
  border-left: none;
}

.fa-search {
  border-radius: 50px;
  padding: 0.5rem;
  color: #f59e92;
}

/* 추천검색어 컨테이너 */
.container-rank {
  position:relative;
  width: 50%;
  height: 320px;
  margin:5px auto;
  border: 1px solid rgb(221, 221, 221);
  border-radius: 25px;
  background: white;
  z-index: 10;
}

.rank {
  max-width: 100%;
  max-height: 100%;
  display:flex;
  justify-content: space-around;
  align-items: center;
  padding: 50px 50px;
}

.rankList, .rankChart {
  max-width: 330px;
  max-height: 330px;
}

.rankList h3 {
  font-family: "Noto Sans KR", sans-serif;
  font-size: 24px;
  margin-bottom: 10px;
}

.rankList p {
  text-align : center;
}

.rankList a {
  font-family: "Noto Sans KR", sans-serif;
  color:rgb(102, 102, 102) !important;
}

.rankList a:hover {
  color:black;
}

.divider {
  height: 250px;
  border: 0.5px solid #e6e6e6;
}

/* 비오는 효과를 주는 곳 */
#raindrop {
  top: 254px;
  height: 554px;
}

.rain {
  position: absolute;
  left: 0;
  width: 100%;
  height:100%;
  z-index: 2;
}

.rain.back-row {
  display: none;
  z-index: 1;
  bottom: 60px;
  opacity: 0.5;
}

.back-row-toggle .rain.back-row {
  display: block;
}

.drop {
  position: absolute;
  bottom: 100%;
  width: 20px;
  height: 120px;
  pointer-events:none;
  animation: drop 0.5s linear infinite;
}

@keyframes drop {
  0% {
    transform: translateY(0vh);
  }
  75% {
    transform: translateY(70vh);
  }
  100% {
    transform: translateY(70vh);
  }
}

.stem {
  width: 3px;
  height: 60%;
  margin-left: 7px;
  background: linear-gradient(to bottom, rgba(255,255,255,0), rgba(255,255,255,0.25));
  animation: stem 0.5 linear infinite;
}

@keyframes stem {
  0%, 65% {
    opacity: 1;
  }
  75%, 100% {
    opacity: 0;
  }
}

.splat {
  width: 20px;
  height: 10px;
  border-top: 3px dotted rgba(255,255,255,0.5);
  border-radius: 50%;
  opacity: 1;
  transform: scale(0);
  animation: splat 0.5s linear infinite;
}

@keyframes splat {
  0%, 80% {
    opacity: 1;
    transform: scale(0);
  }
  90% {
    opacity: 0.5;
    transform: scale(1);
  }
  100% {
    opacity: 0;
    transform: scale(1.5);
  }
}

.toggles {
  position: absolute;
  top: 0;
  left: 0;
  z-index: 3;
}

.back-row-toggle {
  top: 90px;
  line-height: 12px;
  padding-top: 14px;
}
</style>

