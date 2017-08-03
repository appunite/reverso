<template>  

<div class="translation-table">

  <translationBar
  v-on:addTerm="addTerm"
  v-on:searchUsed="debouncedFetch"
  v-on:optionSelected="fetchTranslation"
  v-bind:filter="filter"
  v-bind:platforms="platforms"></translationBar>
  
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
import translationBar from './translation-bar'

export default {
  name: "translationTable",

  components: {
    'translationTerm': translationTerm,
    'translationBar': translationBar
  },

  data() {
    return {
      platforms: [],
      translations: [],

      filter: {
        platform: "Translating",
        search: "",
        show: "All",
        sort: "Alphabetically"
      }
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
    fetchTranslation(){
      translationService.fetchTranslation(
        this.project_id, this.language_id, this.filter).then(
        
        (response) => {
          this.translations = response.data.data;
        },

        (error) => {
          console.log(error);
        }
      );      
    },

    debouncedFetch: _.debounce(function() {
      this.fetchTranslation();
    }, 250),

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
    this.fetchTranslation();
    this.$bus.$on('platforms', (platforms) => {
      this.platforms = _.cloneDeep(platforms);
      this.platforms.unshift("Translating");
    });
  }
}

</script>