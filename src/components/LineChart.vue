<script>
import { Line } from "vue-chartjs";
export default {
  extends: Line,
  props: ["labels", "data", "apt"],
  data() {
    return {
      datacollection: {
        labels: this.labels,
        datasets: [
          {
            label: "억 원",
            backgroundColor: "transparent",
            pointBackgroundColor: "white",
            borderWidth: 3,
            borderColor: "coral",
            pointBorderColor: "coral",
            data: this.data,
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
          align : 'end',
          position: 'top',
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

<style>
  #line-chart {
    height: 272px;
  }
</style>