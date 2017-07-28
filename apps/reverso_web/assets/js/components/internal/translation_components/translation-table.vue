<template>  

  <div class="translation-table">
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

    <div class="translation-table__terms">
    <table>
      <tr v-for="translation in translations"
      :key="translation.id">
        <th>
        <el-input
        type="textarea"
        :autosize="true"
        placeholder="No Reference"
        v-model="translation.basic"
        @blur="update(translation)">
        </el-input>
        </th>

        <th>
        <el-input
        type="textarea"
        :autosize="true"
        v-model="translation.translation"
        placeholder="No Translation"
        @blur="update(translation)">
        </el-input>
        </th>

        <th>
        <el-input
        type="textarea"
        :autosize="true"
        v-model="translation.description"
        placeholder="No comments added"
        @blur="update(translation)">
        </el-input>
        </th>
      </tr>
    </table>
    </div>
  </div>

</template>

<script>
import translationService from '../../../services/translation-service.js'

export default {
  name: "translationTable",

  data() {
    return {
      translations: []
    }
  },

  computed: {
    language_id(){
      return this.$route.params.language_id;
    },

    project_id(){
      return this.$route.params.project_id;
    }
  },

  methods: {
    addTerm(){
      let newTerm = {
        basic: "",
        translation: "",
        description: ""
      }

      this.translations.push(newTerm);
    },
    
    update(translation){
    }
  },

  mounted() {
    translationService.fetchTranslation(this.project_id, this.language_id).then(
      (response) => {
        console.log(response.data.data);
        this.translations = response.data.data;
      },

      (error) => {
        console.log(error);
      }
    );
  }
}

</script>