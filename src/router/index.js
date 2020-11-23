import Vue from "vue";
import VueRouter from "vue-router";
import Home from "../views/Home.vue";
import Member from "../views/Member.vue";
import Board from "../views/Board.vue";
import Detail from "../views/Detail.vue";
import Write from "../views/Write.vue";
import SearchResult from "../views/SearchResult.vue";
import Heart from "../views/Heart.vue";
import Chart from "../views/Chart.vue";
Vue.use(VueRouter);

const routes = [
  {
    path: "/",
    name: "Home",
    component: Home,
  },
  {
    path: "/member",
    name: "member",
    component: Member,
  },
  {
    path: "/board",
    name: "board",
    component: Board,
  },
  {
    path: "/detail",
    name: "detail",
    component: Detail,
  },
  {
    path: "/write",
    name: "write",
    component: Write,
  },
  {
    path: "/search",
    name: "Search",
    component: SearchResult
  },
  {
    path: "/heart",
    name: "heart",
    component: Heart,
  },
  {
    path: "/chart",
    name: "chart",
    component: Chart,
  },
];

const router = new VueRouter({
  mode: "history",
  base: process.env.BASE_URL,
  routes
});

export default router;
