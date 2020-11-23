<template>
  <div>
    <div style="width: calc(100% - 200px); margin: 0 auto">
      <br /><br />
      <v-divider></v-divider>
      <v-card>
        <v-card-title class="justify-center">
          <h2 class="indigo--text darken-3"><strong>N o t i c e</strong></h2>
        </v-card-title>
      </v-card>
      <br />
      <div v-if="items.length" class="text-center">
        <v-simple-table>
          <template v-slot:default>
            <thead>
              <tr>
                <th style="font-size: 15px" class="text-center">Title</th>
                <th style="font-size: 15px" class="text-center">Writer</th>
                <th style="font-size: 15px" class="text-center">
                  Created date
                </th>
                <th style="font-size: 15px" class="text-center">Detail</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="item in items" :key="item.no">
                <td style="font-size: 15px">
                  <strong>{{ item.title }}</strong>
                </td>
                <td style="font-size: 15px">{{ item.member_id }}</td>
                <td style="font-size: 15px">{{ item.date }}</td>
                <td>
                  <v-icon @click="movedetail(item.no)"
                    >mdi-lightbulb-outline</v-icon
                  >
                </td>
              </tr>
            </tbody>
          </template>
        </v-simple-table>
        <br />
        <template v-if="getAccessToken">
          <v-btn
            large
            color="indigo darken-3"
            text
            class="float-right"
            style="border: 1px solid #3f51b5"
            @click="movewrite(getId)"
          >
            Write
          </v-btn>
        </template>
        <br /><br /><br />
        <v-divider></v-divider>
      </div>
      <div
        style="font-size: 20px"
        class="indigo--text darken-3 text-center"
        v-else
      >
        등록된 공지가 없습니다.
      </div>
    </div>
  </div>
</template>
<script>
import axios from "axios";
import { mapGetters } from "vuex";
export default {
  data: function () {
    return {
      items: [],
    };
  },
  created() {
    axios
      .get("http://localhost:8000/happyhouse/notice/list")
      .then(({ data }) => {
        this.items = data;
      })
      .catch(() => {
        alert("에러 발생");
      });
  },
  computed: {
    ...mapGetters(["getAccessToken", "getId"]),
  },
  methods: {
    movedetail(no) {
      this.$router.replace(`/detail?no=${no}`);
    },
    movewrite(id) {
      this.$router.replace(`/write?id=${id}`);
    },
  },
};
</script>
<style>
tr:last-child td {
  border-bottom: 1px solid rgba(0, 0, 0, 0.12);
}
</style>