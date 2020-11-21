<template>
    <div class="overflow-hidden">
        <v-app-bar
        :collapse="!collapseOnScroll"
        :collapse-on-scroll="collapseOnScroll"
        color="indigo darken-3"
        dark
        ></v-app-bar>
    </div>
</template>

<script>
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
      
  }
}
</script>

<style>

</style>