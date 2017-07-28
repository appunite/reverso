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
        <th>
        <textarea
        v-model="translation.basic"
        placeholder="No Reference">
        </textarea>
        </th>
        <th>
        <textarea
        v-model="translation.translation"
        placeholder="No Translation">
        </textarea>
        </th>
        <th>
        <textarea
        v-model="translation.description"
        placeholder="No comments added">
        </textarea>
        </th>
      </tr>
    </table>
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
    }
  },

  mounted() {
    translationService.fetchTranslation(this.project_id, this.language_id).then(
      (response) => {
        this.translations = response.data.data;
      },

      (error) => {
        console.log(error);
      }
    );
  }
}

</script>