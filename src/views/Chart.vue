<template>
  <div style="width: calc(100% - 500px); margin: 0 auto">
    <template>
      <br /><br />
      <v-divider></v-divider>
      <br /><br />
      <v-card>
        <v-card-title class="justify-center">
          <h2 class="indigo--text darken-3" style="font-weight: bold">
            Corona trend
          </h2>
        </v-card-title>
        <section class="container">
          <div class="columns">
            <div class="column">
              <h1 class="indigo--text darken-3">코로나 월별 확진자</h1>
              <line-chart></line-chart>
            </div>
            <br /><br />
            <div class="column">
              <h1 class="indigo--text darken-3">코로나 지역별 확진자</h1>
              <bar-chart></bar-chart>
            </div>
          </div>
        </section>
      </v-card>
    </template>
    <br /><br />
  </div>
</template>

<script>
import LineChart from "@/components/LineChart";
import BarChart from "@/components/BarChart";
export default {
  name: "VueChartJS",
  components: {
    LineChart,
    BarChart,
  },
};
</script>