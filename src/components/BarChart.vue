<script>
import { Bar } from "vue-chartjs";
export default {
  extends: Bar,
  data() {
    return {
      datacollection: {
        labels: [
          "서울",
          "경기",
          "강원",
          "인천",
          "충북",
          "충남",
          "대전",
          "광주",
          "전라",
          "경상",
          "부산",
          "울산",
          //   "September",
          //   "October",
          //   "November",
          //   "December",
        ],
        datasets: [
          {
            label: "Corona 확진자수",
            backgroundColor: "#3f51b5",
            pointBackgroundColor: "white",
            borderWidth: 1,
            pointBorderColor: "#3f51b5",
            data: [
              7625,
              6518,
              516,
              1229,
              225,
              791,
              460,
              615,
              587,
              1645,
              637,
              173,
            ],
          },
        ],
      },
      options: {
        scales: {
          yAxes: [
            {
              ticks: {
                beginAtZero: true,
              },
              gridLines: {
                display: true,
              },
            },
          ],
          xAxes: [
            {
              gridLines: {
                display: false,
              },
            },
          ],
        },
        legend: {
          display: true,
        },
        responsive: true,
        maintainAspectRatio: false,
      },
    };
  },
  mounted() {
    this.renderChart(this.datacollection, this.options);
  },
};
</script>