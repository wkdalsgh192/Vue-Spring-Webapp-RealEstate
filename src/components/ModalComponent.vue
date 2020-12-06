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
            @click="checkPrice(modalTitle)"
            class="rlp"
        >
          {{ modalTitle }}
        </v-btn>
      </template>
      <v-card v-if="modalTitle === '실거래가'">
        <v-card-title class="headline">
          {{this.aptName}}
        </v-card-title>
        <v-divider></v-divider>
        <v-card-text>
            <section class="container">
                <div class="columns">
                    <div class="column">
                    <line-chart class="line-chart" v-if="chart !== null" :labels="chart.labels" :data="chart.data"></line-chart>
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
      <v-card v-else>
        <v-card-title class="headline">
          주변 정보
        </v-card-title>
        <v-divider></v-divider>
        <v-card-text>
            <section class="container">
                <div class="columns">
                    <div class="column">
                    <bar-chart class="bar-chart" id="main" v-if="chart !== null"
                      :labelName="chart.labelName" :labels="chart.labels" :data="chart.data" :colors="chart.colors"></bar-chart>
                    </div>
                    <div class="column">
                    <radar-chart class="rader-chart" width="300" height="300"></radar-chart>
                    </div>
                </div>
            </section>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn
            color="green darken-1"
            text
            @click="dialog = false; chart=null;"
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
import RadarChart from "@/components/RadarChart.vue";
  export default {
    name: "VueChartJS",
    components: {
        LineChart,
        BarChart,
        RadarChart
    },
    // 아파트 이름을 전달한다.
    props: {
      aptName : String,
      modalTitle : String,
    },
    data () {
      return {
        isChart: false,
        dialog: false,
        chart : null,
      }
    },
    methods : {
      checkPrice(elem) {
        console.log(elem)
        if (elem === '실거래가') {
          axios.get('http://localhost:8000/happyhouse/map/house/check/'+this.aptName)
            .then((response) => {
              let obj = new Object();
              let date = new Array();
              let price = new Array();
              response.data.forEach((vo) => {
                date.push(vo['deal_date']);
                price.push(parseInt(vo['deal_amount']));
              })  
              obj.labels = date;
              obj.data = price;
              this.chart = obj;
            })
        } else {
          let obj = new Object();
          obj.labelName = '구별 선별진료소';
          obj.labels = ["강서구","서대문구","마포구","영등포구","관악구","용산구","중구","종로구","성북구","동대문구","강남구","서초구","송파구"];
          obj.data = [3,8,5,3,6,1,7,4,2,6,4,3,2];
          obj.colors = ["#3f51b5","#3f51b5","#3f51b5","#3f51b5","#3f51b5","#3f51b5","#3f51b5","coral","#3f51b5","#3f51b5","#3f51b5","#3f51b5","#3f51b5"];
          this.chart = obj;
        }
        
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

 .bar-chart#main {
   height: 350px;
 }
</style>