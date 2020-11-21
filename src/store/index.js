import Vue from "vue";
import Vuex from "vuex";
import axios from "axios";
export const SET_KEYWORD = 'SET_KEYWORD';
Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    accessToken: null,
    id: "",
    keyword: ''
  },
  getters: {
    getAccessToken(state) {
      return state.accessToken;
    },
    getId(state) {
      return state.id;
    },
  },
  mutations: {
    LOGIN(state, payload) {
      state.accessToken = payload["auth-token"];
      state.id = payload["id"];
    },
    LOGOUT(state) {
      state.accessToken = null;
      state.id = "";
    },
    [SET_KEYWORD](state, keyword) { 
      state.keyword = keyword;
    },
  },
  actions: {
    LOGIN(context, user) {
      return axios
        .post("http://localhost:8000/happyhouse/member/login", user)
        .then((response) => {
          context.commit("LOGIN", response.data);
          axios.defaults.headers.common[
            "auth-token"
          ] = `${response.data["auth-token"]}`;
        });
    },
    LOGOUT(context) {
      context.commit("LOGOUT");
      axios.defaults.headers.common["auth-token"] = undefined;
    },
    GET_KEYWORD(context, payload) {
      context.commit(SET_KEYWORD, payload.keyword);
      // console.log(payload);
      if (payload.url === "") return;
      router.push(payload.url);
    },
  },
  modules: {}
});