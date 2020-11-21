<template>
  <div class="overflow-hidden">
    <v-app-bar
      :collapse="!collapseOnScroll"
      :collapse-on-scroll="collapseOnScroll"
      color="indigo darken-3"
      dark
    >
      <v-toolbar-title>
        <router-link style="color: white" to="/"
          ><v-icon>mdi-home-city</v-icon> Happy House</router-link
        >
      </v-toolbar-title>

      <v-spacer></v-spacer>
      <template v-if="getAccessToken">
        <v-avatar variant="primary"> </v-avatar>{{ getId }}님 환영합니다.
        <!-- <v-btn text :color="btnColor">
          <h3 style="font-family: 'Black Han Sans'">동별검색</h3>
        </v-btn> -->
        <v-btn :to="{ name: 'member' }" text :color="btnColor">
          <h3>MyPage</h3>
        </v-btn>
        <v-btn :to="{ name: 'board' }" text :color="btnColor">
          <h3>Notice</h3>
        </v-btn>
        <v-btn text :color="btnColor" @click.prevent="onClickLogout">
          <h3>Logout</h3>
        </v-btn>
      </template>
      <template v-else>
        <v-dialog v-model="l_close" persistent max-width="600px">
          <template v-slot:activator="{ on, attrs }">
            <v-btn text :color="btnColor" dark v-bind="attrs" v-on="on">
              Login
            </v-btn>
          </template>
          <v-card>
            <v-card-title>
              <span class="headline">Login</span>
            </v-card-title>
            <v-card-text>
              <v-container>
                <v-row>
                  <v-col cols="12">
                    <v-text-field
                      label="ID* 를 입력해주세요"
                      required
                      v-model="user.id"
                    ></v-text-field>
                  </v-col>
                  <v-col cols="12">
                    <v-text-field
                      label="Password* 를 입력해주세요"
                      type="password"
                      required
                      v-model="user.pw"
                    ></v-text-field>
                  </v-col>
                </v-row>
              </v-container>
            </v-card-text>
            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn color="indigo darken-3" text @click="login"> Login </v-btn>
              <v-btn color="indigo darken-3" text @click="l_close = false">
                CLOSE
              </v-btn>
            </v-card-actions>
          </v-card>
        </v-dialog>

        <v-dialog v-model="close" persistent max-width="600px">
          <template v-slot:activator="{ on, attrs }">
            <v-btn text :color="btnColor" dark v-bind="attrs" v-on="on">
              SINGUP
            </v-btn>
          </template>
          <v-card>
            <v-card-title>
              <span class="headline">SingUp</span>
            </v-card-title>
            <v-card-text>
              <v-container>
                <v-row>
                  <v-col cols="12">
                    <v-text-field
                      label="ID* 를 입력해주세요"
                      required
                      v-model="id"
                    ></v-text-field>
                  </v-col>
                  <v-col cols="12">
                    <v-text-field
                      label="Email* 을 입력해주세요"
                      required
                      v-model="email"
                    ></v-text-field>
                  </v-col>
                  <v-col cols="12">
                    <v-text-field
                      label="Password* 를 입력해주세요"
                      type="password"
                      required
                      v-model="pw"
                    ></v-text-field>
                  </v-col>
                </v-row>
              </v-container>
            </v-card-text>
            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn color="indigo darken-3" text @click="sign"> SignUp </v-btn>
              <v-btn color="indigo darken-3" text @click="close = false">
                CLOSE
              </v-btn>
            </v-card-actions>
          </v-card>
        </v-dialog>
      </template>
    </v-app-bar>
  </div>
</template>
<script>
import axios from "axios";
import { mapGetters } from "vuex";

export default {
  data: () => ({
    collapseOnScroll: true,
    btnColor: "white",
    l_close: false,
    close: false,
    id: "",
    pw: "",
    email: "",
    user: {
      id: "",
      pw: "",
    },
    message: "",
  }),
  computed: {
    nextRoute() {
      return this.$route.params.nextRoute ? this.$route.params.nextRoute : "";
    },
    ...mapGetters(["getAccessToken", "getId"]),
  },
  methods: {
    onClickLogout() {
      this.$store.dispatch("LOGOUT").then(() => {
        this.$router.replace("/").catch(() => {});
        alert("로그아웃 성공");
      });
    },
    sign() {
      if (this.id != "" && this.pw != "" && this.email != "") {
        axios
          .post("http://localhost:8000/happyhouse/member/signup", {
            id: this.id,
            pw: this.pw,
            email: this.email,
          })
          .then(({ data }) => {
            if (data == "success") {
              this.close = false;
            }
          });
      } else {
        alert("빈칸을 모두 입력해주세요.");
      }
    },
    login: function () {
      this.$store
        .dispatch("LOGIN", this.user)
        .then(() => {
          this.$router.replace(`/${this.nextRoute}`);
        })
        .catch(({ message }) => {
          this.msg = message;
        });
      this.l_close = false;
    },
  },
};
</script>

<style></style>
