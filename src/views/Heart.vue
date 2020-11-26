<template>
  <div>
    <div style="width: calc(100% - 500px); height: 100vh; margin: 0 auto; padding-top:150px">
      <template>
        <br />
        <div class="text-center" style="font-size: 30px; color: #3f51b5">
          <v-icon x-large color="indigo darken-3" @click="movemember()"
            >mdi-information</v-icon
          >
          &nbsp; | &nbsp;
          <v-icon x-large color="indigo darken-3" disabled
            >mdi-heart-box</v-icon
          >
        </div>
        <v-divider></v-divider>

        <br />
        <v-card>
          <v-card-title class="justify-center">
            <h2 class="indigo--text darken-3" style="font-weight: bold">
              내 찜 목록
            </h2>
          </v-card-title>
        </v-card>
        <br />
        <!-- type="is-danger" -->
        <b-carousel-list :data="items" :items-to-show="4">
          <template slot="item" slot-scope="list">
            <div class="card">
              <div class="card-image">
                <figure class="image is-5by4">
                  <img :src="datas[list.no % 4]" @click="showList(list)" />
                </figure>
              </div>
              <div class="card-content">
                <div class="content">
                  <h2>{{ list.apt_name }}</h2>
                  <h4>{{ list.price }} (만원)</h4>
                  <h4>{{ list.area }} 평형</h4>
                  <h4>{{ list.last_update }} 일</h4>
                  <v-icon @click="del(list.no)">mdi-trash-can-outline</v-icon>
                  <div class="field is-grouped"></div>
                </div>
              </div>
            </div>
          </template>
        </b-carousel-list>
        <br /><br />
      </template>
    </div>
    <sub-header></sub-header>
    <Footer></Footer>
  </div>
</template>

<script>
import axios from "axios";
import Vue from "vue";
import Buefy from "buefy";
import "buefy/dist/buefy.css";
Vue.use(Buefy);
import SubHeader from '@/components/SubHeader.vue';
import Footer from "@/components/Footer.vue";
export default {
  components: {
    SubHeader,
    Footer,
  },
  data() {
    return {
      datas: [
        "https://www.kbmaeil.com/news/photo/201908/823304_846424_81.jpg",
        "https://img.hani.co.kr/imgdb/resize/2017/0404/00501401_20170404.JPG",
        "https://waf-e.dubudisk.com/kera.dubuplus.com/anonymous/O187hQh/DubuDisk/public/%EA%B5%AC%EC%9D%98%20%EB%A9%94%EC%9D%B8%ED%88%AC%EC%8B%9C%20%EC%A3%BC%EA%B2%BD-0722.jpg",
        "https://www.daelim.co.kr/upload/editro/editor_2015415155712.jpg",
      ],
      items: [],
    };
  },
  created() {
    axios
      .get(
        `http://localhost:8000/happyhouse/heart/list/${this.$store.state.id}`
      )
      .then(({ data }) => {
        this.items = data;
        console.log(data);
      })
      .catch(() => {
        alert("에러 발생");
      });
  },
  methods: {
    del(no) {
      axios
        .delete(`http://localhost:8000/happyhouse/heart/delete/${no}`)
        .then(({ data }) => {
          alert("삭제 성공");
          if (data == "success") {
            this.$router.replace("/member");
          } else alert("삭제 실패");
        });
    },

    random() {
      return Math.floor(Math.random() * 4);
    },
    movemember() {
      this.$router.replace("/member");
    },
    showList(elem) {
      console.log(elem);
    }
  },
};
</script>
<style>
</style>