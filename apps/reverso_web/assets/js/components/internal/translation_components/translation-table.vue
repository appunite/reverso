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
  
    props: [
      'translations'
    ]

  }

</script>