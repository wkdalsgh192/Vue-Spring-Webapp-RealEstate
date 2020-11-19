<template>
  <div class="home">
    <br /><br /><br /><br />
    <div>
      <h2 id="h2" class="text-center">
        <span class="indigo--text darken-3">어떤 동네, 어떤 방</span>
        에서
      </h2>
      <br />
      <h2 id="h2" class="text-center">살고 싶으신가요?</h2>
      <br /><br />
      <v-divider></v-divider>
      <br /><br />
      <v-form>
        <v-container>
          <v-row>
            <v-col cols="10">
              <!-- <v-text-field outlined clearable label="Search" type="text">
              </v-text-field> -->
              <v-autocomplete
                chips
                clearable
                hide-details
                hide-selected
                item-text="name"
                item-value="symbol"
                label="검색할 내용을 입력해주세요..."
                solo
              >
                <template v-slot:no-data>
                  <v-list-item>
                    <v-list-item-title>
                      <strong>입력 예시</strong><br /><br />
                      (검색 분류) : (검색 내용) 형태로 검색해주세요.
                      <br /><br /><strong>ex)</strong><br /><br />
                      동별 : 서울특별시 강남구 청담동<br /><br />
                      아파트 : 자이아파트 <br /><br />
                    </v-list-item-title>
                  </v-list-item>
                </template>
              </v-autocomplete>
            </v-col>
            <v-col cols="2">
              <v-btn large color="indigo darken-3" dark>
                <v-icon>mdi-arrow-right-bold-circle-outline</v-icon>
              </v-btn>
            </v-col>
          </v-row>
        </v-container>
      </v-form>
    </div>
  </div>
</template>

<style scoped>
#h2 {
  font-family: "Noto Sans KR", sans-serif;
  font-size: 30px;
}
</style>

