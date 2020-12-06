<template>
  <div class="footer-bar">
    {{ new Date().getFullYear() }} — Made by Song & Jang,   Illustrated by Gala Poliakova
  </div>
  <!-- <v-footer dark padless>
    <v-card class="flex" flat tile>
      <v-card-text class="py-2 white--text text-center">
        {{ new Date().getFullYear() }} — Made by Song & Jang
      </v-card-text>
    </v-card>
  </v-footer> -->
</template>

<script>
export default {
};
</script>

<style scoped>
  .footer-bar {
    position:relative;
    top: -36px;
    width: 100vw;
    height: 30px;
    background-color: #1e1e1e;
    text-align:center;
    color: white;
    /* padding: 0.5rem 0; */
  }
</style>
