<script>
import { Radar } from "vue-chartjs";
export default {
    extends: Radar,
    data() {
        return {
            datacollection: {
                labels: ['음식', '소매', '생활서비스','학문/교육','부동산'],
                datasets: [{
                    label: "생활편의지수",
                    backgroundColor: "rgba(200,0,0,0.2)",
                    borderColor: " #f59e92",
                    pointBackgroundColor: "rgba(179,181,198,1)",
                    pointBorderColor: "#fff",
                    pointHoverBackgroundColor: "#fff",
                    pointHoverBorderColor: "rgba(179,181,198,1)",
                    data: [620, 584, 620, 212,268]
                }]
            },
            options : {
                scale: {
                    angleLines: {
                        display: false
                    },
                    ticks: {
                        suggestedMin: 5,
                        suggestedMax: 20
                    }
                }
            }
        };
    },
    mounted() {
        console.log(this.datacollection);
        this.renderChart(this.datacollection, this.options);
    }
}
</script>

<style scoped>
    
</style>