<template>
  <div class="home">
    <div>
      <img id="home-canvas" src='img/background2.jpg' alt="">
    </div>
    <div class="wrapper">
      <div class="container-input">
        <input list="searchRank" type="text" class="search-term" v-model="temp" ref="search" @keydown.enter="getKeyword" @keydown.once="makeRain">    
          <button type="submit" class="submit-button">
            <i class="fas fa-search"></i>
          </button>
        <!-- 여기에 추천 검색어가 들어간다. -->
        <datalist id="searchRank">
          <option>검색 TOP 5</option>
          <option v-for = "item in items" :key="item.no">{{item.dong}}</option>
        </datalist>
      </div>
    </div>
    <div class="wrapper back-row-toggle" id="raindrop" v-if="frontRow.length > 0">
      <div class="rain front-row" >
        <div v-for="n in frontRow.length" :key="n" v-html="frontRow[n]">
        </div>
      </div>
      
      <div class="rain back-row" >
        <div v-for="n in backRow.length" :key="n+100" v-html="backRow[n]"></div>
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
import Axios from 'axios';

export default {
  index,
  components: {
    Header,
    Footer,
  },
  data() {
    return {
      temp: "",
      isEmpty: false,
      frontRow: new Array(),
      backRow: new Array(),
      items: [],
    };
  },
  created() {
    Axios
    .get("http://localhost:8000/happyhouse/heart/search")
    .then(({data}) => {
      this.items = data;
    })
    .catch(() =>{
      alert("에러 발생");
    })
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
    // this.$refs.search.focus();
  },
  methods: {
    getKeyword() {
      if (!this.isEmpty) {
        this.$store.dispatch("GET_KEYWORD", {
          keyword: this.temp,
          url: "/search",
        });
      }
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

<style>
#h2 {
  font-family: "Noto Sans KR", sans-serif;
  font-size: 30px;
}

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


.container-input {
  display: flex;
  flex-direction: row;
  width: 50%;
  margin: 0 auto;
}

#searchRank {
  width: 50%;
  /* background-color:white;
  border: 1px solid transparent;
  border-right: none;
  padding: 5px 5px 5px 25px;
  height: 54px;
  border-radius: 50px 0 0 50px;
  outline: none;
  font-size:1rem; */
}

.search-term {
  /* max-width: 585px; */
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
  color: coral;
}
</style>

