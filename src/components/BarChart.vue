<script>
import { Bar } from "vue-chartjs";
export default {
  extends: Bar,
  data() {
    return {
      datacollection: {
        labels: [
          "강서구",
          "서대문구",
          "마포구",
          "영등포구",
          "관악구",
          "용산구",
          "중구",
          "종로구",
          "성북구",
          "동대문구",
          "강남구",
          "서초구",
          "송파구",
        ],
        datasets: [
          {
            label: "구별 선별진료소",
            backgroundColor: ["#3f51b5","#3f51b5","#3f51b5","#3f51b5","#3f51b5","#3f51b5","#3f51b5","coral","#3f51b5","#3f51b5","#3f51b5","#3f51b5","#3f51b5"],
            pointBackgroundColor: "white",
            borderWidth: 1,
            pointBorderColor: "#3f51b5",
            data: [
              3,8,5,
              3,6,1,7,4,
              2,6,4,3,2
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