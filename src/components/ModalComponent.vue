<template>
  <v-row justify="center" class="modal-row">
    <v-dialog
      v-model="dialog"
      max-width="800"
    >
      <template v-slot:activator="{ on, attrs }">
        <v-btn
            elevation="2"
            x-small        
            dark
            v-bind="attrs"
            v-on="on"
            @click="checkPrice"
            class="rlp"
        >
          실거래가
        </v-btn>
      </template>
      <v-card>
        <v-card-title class="headline">
          {{this.aptName}} 실거래가 동향
        </v-card-title>
        <v-card-text>
            <section class="container">
                <div class="columns">
                    <div class="column">
                    <line-chart class="line-chart" v-if="labels !== null" :labels="labels" :data="numData" :apt="aptName"></line-chart>
                    </div>
                    <br /><br />
                    <div class="column">
                    <h1 class="indigo--text darken-3">코로나 지역별 확진자</h1>
                    <bar-chart></bar-chart>
                    </div>
                </div>
            </section>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn
            color="green darken-1"
            text
            @click="dialog = false"
          >
            닫기
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-row>
</template>

<script>

import axios from "axios";
import LineChart from "@/components/LineChart.vue";
import BarChart from "@/components/BarChart.vue";
  export default {
    name: "VueChartJS",
    components: {
        LineChart,
        BarChart,
    },
    // 아파트 이름을 전달한다.
    props: {
      aptName : String
    },
    data () {
      return {
        isChart: false,
        dialog: false,
        labels: null,
        numData: null,
      }
    },
    methods : {
      checkPrice() {
        axios.get('http://localhost:8000/happyhouse/map/house/check/'+this.aptName)
            .then((response) => {
              let date = new Array();
              let price = new Array();
              console.log(response.data);
              response.data.forEach((vo) => {
                date.push(vo['deal_date']);
                price.push(parseInt(vo['deal_amount']));
              })
              this.labels = date;
              this.numData = price;
            })
      }
    }
  }
</script>

<style>

.modal-row {
    display: inline-block;
    margin-left: 0.3rem;
}

.rlp {
    margin-left: 0.3rem;
    padding: 0.1rem 0.2rem ;
    font-size: 0.5rem;
    border: 0.8px solid black;
    border-radius: 10%;
}

.line-chart {
    height: 300px;
}
</style>