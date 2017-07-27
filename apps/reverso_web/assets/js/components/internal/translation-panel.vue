<template>  
  <div class="translation-panel">
  <translationTable v-bind:translations="translations"></translationTable>
  </div>
</template>

<script>
import translationService from '../../services/translation-service.js'
import translationTable from './translation_components/translation-table.vue'
import sidebar from './translation_components/sidebar.vue'

export default {
  name: "translationPanel",

  components: {
    'translationTable': translationTable,
    'sidebar': sidebar
  },

  data () {
    return {
      translations: []
    }
  },
  mounted() {
    let language_id = this.$route.params.language_id;
    let project_id = this.$route.params.project_id;

    translationService.fetchTranslation(project_id, language_id).then(
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

<style lang="scss">
.translation-panel {
 display: flex;
 width: 100%;
 justify-content: space-between;
}
</style>