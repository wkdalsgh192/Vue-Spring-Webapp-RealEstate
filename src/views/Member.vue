<template>
  <div>
    <div style="width: calc(100% - 800px); height:93vh; margin: 0 auto; margin-top:100px">
      <template v-if="user">
        <br /><br />
        <div class="text-center" style="font-size: 30px; color: #3f51b5">
          <v-icon x-large color="indigo darken-3" disabled
            >mdi-information</v-icon
          >
          &nbsp; | &nbsp;
          <v-icon x-large color="indigo darken-3" @click="moveheart()"
            >mdi-heart-box</v-icon
          >
        </div>
        <v-divider></v-divider>
        <br /><br />
        <v-card>
          <v-card-title class="justify-center">
            <h2 class="indigo--text darken-3" style="font-weight: bold">
              회원 정보 관리
            </h2>
          </v-card-title>
          <v-card-text>
            <v-container>
              <v-row>
                <v-col cols="4"></v-col>
                <v-col cols="4">
                  <h3>Current ID</h3>
                  <v-text-field disabled v-model="user.id"></v-text-field>
                </v-col>
                <v-col cols="4"> </v-col>
                <v-col cols="4"> </v-col>
                <v-col cols="4">
                  <h3>Current PW</h3>
                  <v-text-field v-model="user.pw"></v-text-field>
                </v-col>
                <v-col cols="4"> </v-col>
                <v-col cols="4"> </v-col>
                <v-col cols="4">
                  <h3>Current Email</h3>
                  <v-text-field v-model="user.email"></v-text-field>
                </v-col>
              </v-row>
            </v-container>
          </v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn
              large
              color="indigo darken-3"
              text
              class="float-right"
              style="border: 1px solid #3f51b5"
              @click="modify"
            >
              Modi
            </v-btn>
            <v-btn
              large
              color="indigo darken-3"
              text
              class="float-right"
              style="border: 1px solid #3f51b5"
              @click="del"
            >
              Del
            </v-btn>
          </v-card-actions>
        </v-card>
      </template>
    </div>
    <sub-header></sub-header>
    <br>
    <Footer></Footer>
  </div>
</template>

<script>
import axios from "axios";
import SubHeader from '@/components/SubHeader.vue';
import Footer from "@/components/Footer.vue";
export default {
  components: {
    SubHeader,
    Footer,
  },
  data: () => ({
    user: null,
    id: "",
    pw: "",
    email: "",
  }),
  created() {
    axios
      .get("http://localhost:8000/happyhouse/member/info")
      .then((response) => {
        this.user = response.data.user;
      })
      .catch(() => {
        this.$store.dispatch("LOGOUT").then(() => this.$router.replace("/"));
      });
  },
  methods: {
    moveheart() {
      this.$router.replace("/heart");
    },
    modify() {
      if (this.user.pw != "" && this.user.email != "") {
        axios
          .put("http://localhost:8000/happyhouse/member/update", {
            id: this.user.id,
            pw: this.user.pw,
            email: this.user.email,
          })
          .then(({ data }) => {
            if (data == "success") {
              alert("수정 성공");
            } else alert("수정 실패");
          });
      } else {
        alert("빈칸을 모두 입력해주세요.");
      }
    },
    del() {
      axios
        .delete(
          `http://localhost:8000/happyhouse/member/delete/${this.user.id}`
        )
        .then(({ data }) => {
          alert("삭제 및 로그아웃 성공");
          if (data == "success") {
            this.$store.dispatch("LOGOUT").then(() => {
              this.$router.replace("/").catch(() => {});
            });
          } else alert("삭제 실패");
        });
    },
  },
};
</script>
