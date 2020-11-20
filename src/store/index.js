import Vue from "vue";
import Vuex from "vuex";

Vue.use(Vuex);

export const SET_KEYWORD = 'SET_KEYWORD';

import router from '../router';
export default new Vuex.Store({
  router,
  state: {
    keyword: ''
  },
  mutations: {
    [SET_KEYWORD](state, keyword) { 
      state.keyword = keyword;
    },
  },
  actions: {
    GET_KEYWORD(context, payload) {
      context.commit(SET_KEYWORD, payload.keyword);
      // console.log(payload);
      if (payload.url === "") return;
      router.push(payload.url);
    },
  },
  modules: {}
});
