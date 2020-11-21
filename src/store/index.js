import Vue from "vue";
import Vuex from "vuex";
import axios from "axios";
Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    accessToken: null,
    id: ""
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
    }
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
    }
  },
  modules: {}
});