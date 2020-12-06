<script>
import { Bar } from "vue-chartjs";
export default {
  extends: Bar,
  props: ["labels", "data", "colors", "labelName"],
  data() {
    return {
      datacollection: {
        labels: this.labels,
        datasets: [
          {
            label: this.labelName,
            backgroundColor: this.colors,
            pointBackgroundColor: "white",
            borderWidth: 1,
            pointBorderColor: "#3f51b5",
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
          display: false,
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

<style scoped>
  .bar-chart {
    width: 350px;
    height: 350px;
  }
</style>