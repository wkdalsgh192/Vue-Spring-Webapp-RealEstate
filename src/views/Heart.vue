<template>
  <div>
    <div style="width: calc(100% - 700px); margin: 0 auto">
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
            <h2 class="indigo--text darken-3">
              <strong>내 찜 목록</strong>
            </h2>
          </v-card-title>
        </v-card>
        <br />
        <!-- :key="i" v-for="(data, i) in datas" -->
        <v-carousel height="600px">
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
                      <v-list-item-title>{{ item.id }}</v-list-item-title>
                      <v-list-item-subtitle>{{ item.pw }}</v-list-item-subtitle>
                    </v-list-item-content>
                  </v-list-item>
                </v-list>
              </v-col>
            </v-row></v-carousel-item
          >
        </v-carousel>
        <br /><br />
      </template>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      datas: [
        "https://www.kbmaeil.com/news/photo/201908/823304_846424_81.jpg",
        "https://img.hani.co.kr/imgdb/resize/2017/0404/00501401_20170404.JPG",
        "https://waf-e.dubudisk.com/kera.dubuplus.com/anonymous/O187hQh/DubuDisk/public/%EA%B5%AC%EC%9D%98%20%EB%A9%94%EC%9D%B8%ED%88%AC%EC%8B%9C%20%EC%A3%BC%EA%B2%BD-0722.jpg",
        "https://www.daelim.co.kr/upload/editro/editor_2015415155712.jpg",
      ],
      items: [
        {
          id: "song",
          pw: "song",
          src: "https://www.kbmaeil.com/news/photo/201908/823304_846424_81.jpg",
        },
        {
          id: "won",
          pw: "won",
          src:
            "https://img.hani.co.kr/imgdb/resize/2017/0404/00501401_20170404.JPG",
        },
        {
          id: "jun",
          pw: "jun",
          src:
            "https://waf-e.dubudisk.com/kera.dubuplus.com/anonymous/O187hQh/DubuDisk/public/%EA%B5%AC%EC%9D%98%20%EB%A9%94%EC%9D%B8%ED%88%AC%EC%8B%9C%20%EC%A3%BC%EA%B2%BD-0722.jpg",
        },
        {
          id: "jjang",
          pw: "jjang",
          src:
            "https://www.daelim.co.kr/upload/editro/editor_2015415155712.jpg",
        },
      ],
    };
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
