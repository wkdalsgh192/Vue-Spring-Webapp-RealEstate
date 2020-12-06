<template>
  <div id="header-bar">
    <div>
      <router-link style="color: white" to="/"
          >
          <img src="img/logo1.png" style="width:100px;">
          </router-link>
    </div>
    <div class="wrapper">
      <div class="container-input">
        <input type="text" class="search-term" v-model="keyword" @keydown.enter="getKeyword('')">    
          <button type="submit" class="submit-button">
            <i class="fas fa-search"></i>
          </button>
        <!-- 여기에 추천 검색어가 들어간다. -->
        <datalist></datalist>
      </div>
    </div>
    <div class="header-items">
      <template v-if="getAccessToken">
        <v-avatar variant="primary"> </v-avatar>{{ getId }}님 환영합니다.
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
      <template v-else-if="this.res == 1">
        <v-avatar variant="primary"> </v-avatar> Kakao Guest님 환영합니다.
        <v-btn :to="{ name: 'board' }" text :color="btnColor">
          <h3>Notice</h3>
        </v-btn>
        <v-btn text :color="btnColor" @click="zero">
          <h3>Logout</h3>
        </v-btn>
      </template>
      <template v-else>
        <v-dialog v-model="l_close" persistent max-width="600px">
          <template v-slot:activator="{ on, attrs }">
            <v-btn text :color="btnColor" dark v-bind="attrs" v-on="on">
              <h3>Login</h3>
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
              <a :href="kakaoLoginLink" alt="kakao login" @click="addCount">
                <img
                  style="width: 90%"
                  alt="kakao logo"
                  src="@/assets/kakao_login_medium_narrow.png"
                />
              </a>
              <v-spacer></v-spacer><v-spacer></v-spacer><v-spacer></v-spacer
              ><v-spacer></v-spacer> <v-spacer></v-spacer><v-spacer></v-spacer
              ><v-spacer></v-spacer><v-spacer></v-spacer>
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
              <h3>SignUp</h3>
            </v-btn>
          </template>
          <v-card>
            <v-card-title>
              <span class="headline">SignUp</span>
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
    </div>  
  </div>
</template>
<script>
import index from '../store';
import axios from "axios";
import { mapGetters } from "vuex";

export default {
  index,
  data: () => ({
    collapseOnScroll: true,
    btnColor: "white",
    l_close: false,
    close: false,
    chart: false,
    id: "",
    pw: "",
    email: "",
    user: {
      id: "",
      pw: "",
    },
    count: 0,
    res: 0,
    message: "",
    client_id: "144400cb3aff71d7d6c539363528967b",
    redirect_uri: "http://localhost:8080",
    keyword: '',
  }),
  created() {
    this.res = localStorage.getItem("count");
    this.keyword = this.$store.state.keyword;
  },
  computed: {
    nextRoute() {
      return this.$route.params.nextRoute ? this.$route.params.nextRoute : "";
    },
    ...mapGetters(["getAccessToken", "getId"]),
    kakaoLoginLink() {
      return `https://kauth.kakao.com/oauth/authorize?client_id=${this.client_id}&redirect_uri=${this.redirect_uri}&response_type=code`;
    },
  },
  methods: {
    addCount() {
      localStorage.setItem("count", 1);
    },
    zero() {
      localStorage.setItem("count", 0);
      this.res = localStorage.getItem("count");
    },
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
    getKeyword(url) {
      console.log(123);
      this.$store.dispatch("GET_KEYWORD", {
          keyword: this.keyword,
          url: url,
        });
    },
  },
};
</script>

<style scoped>
  #header-bar {
    position:absolute;
    top:0;
    left:0;
    width:100vw;
    height: 5rem;
    display:flex;
    justify-content: space-between;
    background: white;
    padding: 1rem 1rem;
    z-index:10;
    box-shadow: rgba(0, 0, 0, 0.08) 0px 1px 12px;
  }

  .header-items {
    display:flex;
    justify-content:space-between;
    align-items:center;
  }

  .wrapper {
  position:relative;
  top: 0;
  width: 50%;
  opacity:0.9;
}

.container-input {
  display: flex;
  flex-direction: row;
  width: 50%;
  margin: 0 auto;
}

.search-term {
  /* max-width: 585px; */
  width: 100%;
  background-color:white;
  border: 1px solid #e6e6e6;
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
  border: 1px solid #e6e6e6;
  cursor: pointer;
  font-size: 25px;
  border-left: none;
}

.fa-search {
  border-radius: 50px;
  padding: 0.5rem;
  color: #f59e92;
}
h3, .v-btn__content {
  color:  black;
}

</style>