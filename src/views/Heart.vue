<template>
  <div>
    <div style="width: calc(100% - 500px); margin: 0 auto">
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
        <!-- :key="i" v-for="(data, i) in datas" -->
        <!-- <v-carousel height="600px">
          <v-carousel-item
            v-for="(item, i) in items"
            :key="i"
            :src="datas[random()]"
            reverse-transition="fade-transition"
            transition="fade-transition"
          >
            <v-row class="fill-height" justify="center">
              <v-col>
                <v-list two-line>
                  <v-list-item>
                    <v-list-item-content>
                      <v-list-item-title
                        >{{ item.apt_name }} 아파트</v-list-item-title
                      >
                      <v-list-item-subtitle
                        >가격 : {{ item.price }} (만원)</v-list-item-subtitle
                      >
                      <v-list-item-subtitle
                        >평수 : {{ item.area }}</v-list-item-subtitle
                      >
                    </v-list-item-content>
                  </v-list-item>
                </v-list>
              </v-col>
            </v-row></v-carousel-item
          >
        </v-carousel> -->
        <!-- type="is-danger" -->
        <b-carousel-list :data="items" :items-to-show="4">
          <template slot="item" slot-scope="list">
            <div class="card">
              <div class="card-image">
                <figure class="image is-5by4">
                  <img :src="datas[list.no % 4]" />
                </figure>
              </div>
              <div class="card-content">
                <div class="content">
                  <h2 class="title is-6">{{ list.apt_name }}</h2>
                  <h2 class="subtitle is-7">{{ list.price }} (만원)</h2>
                  <h2 class="subtitle is-7">{{ list.area }} 평형</h2>
                  <div class="field is-grouped"></div>
                </div>
              </div>
            </div>
          </template>
        </b-carousel-list>
        <br /><br />
      </template>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import Vue from "vue";
import Buefy from "buefy";
import "buefy/dist/buefy.css";
Vue.use(Buefy);
export default {
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
      })
      .catch(() => {
        alert("에러 발생");
      });
  },
  methods: {
    random() {
      return Math.floor(Math.random() * 4);
    },
    movemember() {
      this.$router.replace("/member");
    },
  },
};
</script>
<style scoped>
</style>