<template>
  <div>
    <div style="width: calc(100% - 200px); margin: 0 auto">
      <template v-if="notice">
        <br /><br />
        <v-divider></v-divider>
        <br /><br />
        <v-card>
          <v-card-title class="justify-center">
            <h2 class="indigo--text darken-3">
              <strong>Notice Detail</strong>
            </h2>
          </v-card-title>
          <v-card-text>
            <v-container>
              <v-row>
                <v-col cols="3"></v-col>
                <v-col cols="6">
                  <h3>글 번호</h3>
                  <v-text-field disabled v-model="notice.no"></v-text-field>
                </v-col>
                <v-col cols="3"> </v-col>
                <v-col cols="3"> </v-col>
                <v-col cols="6">
                  <h3>글 제목</h3>
                  <v-text-field v-model="notice.title"></v-text-field>
                </v-col>
                <v-col cols="3"> </v-col>
                <v-col cols="3"> </v-col>
                <v-col cols="6">
                  <h3>글내용</h3>
                  <v-form style="height: 150px">
                    <v-textarea
                      v-model="notice.content"
                      counter
                      maxlength="50"
                      full-width
                      single-line
                    ></v-textarea>
                  </v-form>

                  <!-- <v-text-field v-model="notice.content"></v-text-field> -->
                </v-col>
                <v-col cols="3"> </v-col>
                <v-col cols="3"> </v-col>
                <v-col cols="6">
                  <h3>작성자</h3>
                  <v-text-field
                    disabled
                    v-model="notice.member_id"
                  ></v-text-field>
                </v-col>
                <v-col cols="3"> </v-col>
                <v-col cols="3"> </v-col>
                <v-col cols="6">
                  <h3>작성일</h3>
                  <v-text-field disabled v-model="notice.date"></v-text-field>
                </v-col>
              </v-row>
            </v-container>
          </v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>

            <v-btn
              v-if="this.notice.member_id == this.getId"
              large
              color="indigo darken-3"
              text
              class="float-right"
              style="border: 1px solid #3f51b5"
              @click="modify"
            >
              Modi
            </v-btn>
            <v-btn
              v-if="this.notice.member_id == this.getId"
              large
              color="indigo darken-3"
              text
              class="float-right"
              style="border: 1px solid #3f51b5"
              @click="del"
            >
              Del
            </v-btn>
          </v-card-actions>
        </v-card>
      </template>
    </div>
    <br /><br />
    <v-divider></v-divider>
  </div>
</template>

<script>
import axios from "axios";
import { mapGetters } from "vuex";
export default {
  data: () => ({
    notice: { no: "", title: "", date: "", content: "", member_id: "" },
    no: "",
    title: "",
    content: "",
    date: "",
    member_id: "",
  }),
  created() {
    axios
      .get(
        `http://localhost:8000/happyhouse/notice/detail/${this.$route.query.no}`
      )
      .then((response) => {
        console.log(response.data);
        this.notice = response.data;
      });
    // let no = this.$route.query.no;
    // console.log(no);
  },
  computed: {
    ...mapGetters(["getAccessToken", "getId"]),
  },
  methods: {
    modify() {
      if (this.notice.title != "" && this.notice.content != "") {
        axios
          .put("http://localhost:8000/happyhouse/notice/update", {
            no: this.notice.no,
            title: this.notice.title,
            content: this.notice.content,
            date: this.notice.date,
            member_id: this.notice.member_id,
          })
          .then(({ data }) => {
            if (data == "success") {
              alert("수정 성공");
            } else alert("수정 실패");
          });
      } else {
        alert("빈칸을 모두 입력해주세요.");
      }
    },
    del() {
      axios
        .delete(
          `http://localhost:8000/happyhouse/notice/delete/${this.notice.no}`
        )
        .then(({ data }) => {
          alert("삭제 성공");
          if (data == "success") {
            this.$router.replace("/board");
          } else alert("삭제 실패");
        });
    },
  },
};
</script>
