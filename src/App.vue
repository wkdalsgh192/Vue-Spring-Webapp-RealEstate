<template>
  <!-- <div class="main-container">
    <router-view></router-view>
  </div> -->
  <v-app class="main-container">
    <v-main>
      <router-view></router-view>
    </v-main>
  </v-app>
</template>

<script>
// import Header from "./components/Header.vue";
// import Footer from "./components/Footer.vue";
export default {
  components: {
    // Header,
    // Footer,
  },
};
</script>

<style>
  .main-container {
    padding: 0;
    width: 100vw !important;
    height: 100vh;
    overflow:hidden;
  }
</style>