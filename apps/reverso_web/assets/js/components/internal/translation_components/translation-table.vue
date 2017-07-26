<template>  

  <div class="translation-table">
    <div class="top-table-panel">
      <el-button type="text" class="add_sth_btn">
        <img src="/images/ic-add.svg">Add new term
      </el-button>
    </div>

    <table>
      <tr class="table-header">
        <th>reference language</th>
        <th>translation</th>
        <th>description</th>
      </tr>
    </table>

    <table class="translation-table__terms">
      <tr v-for="translation in translations">
        <th >{{ translation.basic }}</th>
        <th>{{ translation.translation }}</th>
        <th>{{ translation.description }}</th>
      </tr>
    </table>
  </div>

</template>

<script>

  export default {
    name: "translationTable",
    data () {
      return {
        translations: [
        {
          basic: "elo",
          platform_key: "elo_k",
          description: "ccc",
          translation: "xdxd",
          platform_id: 1
        },
        {
          basic: "elo1",
          platform_key: "elo1_k",
          description: "xxx",
          translation: "xdxd1",
          platform_id: 1
        },
        {
          basic: "elo3",
          platform_key: "elo3_k",
          description: "ppp",
          translation: "xdxd3",
          platform_id: 2
        },
        {
          basic: "elo4",
          platform_key: "elo4_k",
          description: "",
          translation: "xdxd4",
          platform_id: 2
        }
        ]
      }
    },
    methods: {
    }
  }

</script>