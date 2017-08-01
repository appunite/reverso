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
    <table v-chat-scroll="{always: false}">
      <tr v-for="term in translations"
      :key="term.id">
        <translationTerm
        v-bind:term="term"
        v-on:term_deleted="tableRemoveTerm($event)"
        v-on:row_deleted="tableRemoveRow($event)"
        ></translationTerm>     
      </tr>
  </table>
  </div>

</div>

</template>

<script>
import translationService from '../../../services/translation-service.js'
import translationTerm from './translation-term'

export default {
  name: "translationTable",

  components: {
    'translationTerm': translationTerm
  },

  data() {
    return {
      translations: [],
      hoverRow: null
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
    
    tableRemoveTerm(deleted_term){
      let index = _.findIndex(this.translations, (term) => {
        return term.id == deleted_term.id;
      });
      
      this.translations.splice(index, 1);
    },

    tableRemoveRow(deleted_term){
      let index = _.findIndex(this.translations, (term) => {
          return 
            term.basic == deleted_term.basic &&
            term.translation == deleted_term.translation &&
            term.description == deleted_term.description;
        });

      this.translations.splice(index, 1);
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