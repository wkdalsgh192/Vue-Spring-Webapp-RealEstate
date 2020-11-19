<template>
  <div class="overflow-hidden">
    <v-app-bar
      :collapse="!collapseOnScroll"
      :collapse-on-scroll="collapseOnScroll"
      color="indigo darken-3"
      dark
    >
      <v-toolbar-title>
        <v-icon>mdi-home-city</v-icon>
        Happy House
      </v-toolbar-title>

      <v-spacer></v-spacer>
      <v-btn text :color="btnColor">
        <router-link to="/search"><h3 style="font-family: 'Black Han Sans'">동별검색</h3></router-link>
      </v-btn>
      <v-btn text :color="btnColor">
        <h3 style="font-family: 'Black Han Sans'">아파트</h3>
      </v-btn>
      <v-btn text :color="btnColor">
        <h3 style="font-family: 'Black Han Sans'">게시판</h3>
      </v-btn>

      <v-dialog v-model="login" persistent max-width="600px">
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
                  ></v-text-field>
                </v-col>
                <v-col cols="12">
                  <v-text-field
                    label="Password* 를 입력해주세요"
                    type="password"
                    required
                  ></v-text-field>
                </v-col>
              </v-row>
            </v-container>
          </v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="indigo darken-3" text @click="login = false">
              Login
            </v-btn>
            <v-btn color="indigo darken-3" text @click="login = false">
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
    </v-app-bar>
  </div>
</template>
<script>
import axios from "axios";
export default {
  data: () => ({
    collapseOnScroll: true,
    btnColor: "white",
    login: false,
    close: false,
    id: "",
    pw: "",
    email: "",
  }),
  methods: {
    sign() {
      axios
        .post("http://localhost:8000/happyhouse/member/signup", {
          id: this.id,
          pw: this.pw,
          email: this.email,
        })
        .then(({ data }) => {
          if (data == "success") {
            alert("등록 성공");
            this.close = false;
          } else alert("등록 실패");
        });
    },
  },
};
</script>

<style></style>
