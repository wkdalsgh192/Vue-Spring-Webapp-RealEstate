<script>
import { Line } from "vue-chartjs";
export default {
  extends: Line,
  data() {
    return {
      datacollection: {
        labels: [
          "2/1",
          "3/1",
          "4/1",
          "5/1",
          "6/1",
          "7/1",
          "8/1",
          "9/1",
          "10/1",
          "11/1",
          //   "August",
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
              12,
              3736,
              9887,
              10774,
              11503,
              12850,
              14336,
              20182,
              23889,
              26635,
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