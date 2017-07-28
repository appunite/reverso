<template>  

  <div id="translation-table">
    <div class="top-table-panel">
      <el-button type="text" class="add_sth_btn" @click="addTerm">
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

    <table id="translation-table__terms">
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
    ],

    data() {
      return {
        sampleElement: '<button v-on="click: test()">Test</button>'
      }
    },
    methods: {
      addTerm(){
        var template = document.createElement('template');
        template.innerHTML = "<tr><th></th><th></th><th></th></tr";
        
        document.getElementById("translation-table__terms").appendChild(template);
      }
    }
  }

</script>