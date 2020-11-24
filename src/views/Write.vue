<template>
  <div>
    <div style="width: calc(100% - 200px); margin: 0 auto">
      <template>
        <br /><br />
        <v-divider></v-divider>
        <br /><br />
        <v-card>
          <v-card-title class="justify-center">
            <h2 class="indigo--text darken-3" style="font-weight: bold">
              Notice Create
            </h2>
          </v-card-title>
          <v-card-text>
            <v-container>
              <v-row>
                <v-col cols="2"></v-col>
                <v-col cols="8">
                  <h3>작성자</h3>
                  <v-text-field
                    disabled
                    v-model="this.$route.query.id"
                  ></v-text-field>
                </v-col>
                <v-col cols="2"> </v-col>
                <v-col cols="2"></v-col>
                <v-col cols="8">
                  <h3>글 제목</h3>
                  <v-text-field v-model="title"></v-text-field>
                </v-col>
                <v-col cols="2"> </v-col>
                <v-col cols="2"> </v-col>
                <v-col cols="8">
                  <h3>글 내용</h3>
                  <v-form>
                    <v-textarea
                      v-model="content"
                      counter
                      maxlength="100"
                      full-width
                      single-line
                    ></v-textarea>
                  </v-form>
                </v-col>
              </v-row>
            </v-container>
          </v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>

            <v-btn
              large
              color="indigo darken-3"
              text
              class="float-right"
              style="border: 1px solid #3f51b5"
              @click="write"
            >
              Write
            </v-btn>
            <v-btn
              large
              color="indigo darken-3"
              text
              class="float-right"
              style="border: 1px solid #3f51b5"
            >
              Cancel
            </v-btn>
          </v-card-actions>
        </v-card>
      </template>
    </div>
    <br /><br />
  </div>
</template>
<script>
import axios from "axios";
export default {
  data: () => ({
    member_id: "",
    title: "",
    content: "",
  }),
  methods: {
    write() {
      axios
        .post("http://localhost:8000/happyhouse/notice/create", {
          member_id: this.$route.query.id,
          title: this.title,
          content: this.content,
        })
        .then(({ data }) => {
          if (data == "success") {
            this.$router.replace("/board");
          } else {
            alert("등록 실패");
          }
        });
    },
  },
};
// this.$route.query.id
</script>
