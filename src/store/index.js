import Vue from "vue";
import Vuex from "vuex";

Vue.use(Vuex);

export const SET_KEYWORD = 'SET_KEYWORD';

export default new Vuex.Store({
  state: {
    keyword: ''
  },
  mutations: {
    [SET_KEYWORD](state, keyword) { 
      state.keyword = keyword;
    },
  },
  actions: {},
  modules: {}
});
