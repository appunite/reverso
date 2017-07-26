<template>  
  <div class="project-item">
  
    <div v-for="translation in translations" class="project-item__language">
      <span class="summary">
        <span class="summary-col-1">
          {{ translation.language_name }}
        </span>

        <span class="summary-col-2">
          <p v-if="isBasicLanguage(translation.language_name)">reference</p>
          <p v-else>{{ translation.count }}/{{reference_str_count}} strings translated</p>

          
        </span>

        <span class="summary-col-3">
          <p v-if="translation.last_edit">
            {{ translation.last_edit }} last edit by {{ translation.editor }}
          </p>          
        </span>
    
        <span class="summary-col-4">
          <exportSettings></exportSettings>
        </span>
      </span>

    </div>
    <div class="add-language">
      <newLanguage></newLanguage>

    </div>

  </div>
</template>

<script>
import newLanguage from './actions/new-language.vue'
import exportSettings from './export-settings.vue'
import projectService from '../../../services/project-service.js'

export default {
  name: "project-item",

  props: [
    'project'
  ],

  components: {
    'newLanguage': newLanguage,
    'exportSettings': exportSettings
  },

  data () {
    return {
      language_count: 0,
      reference_str_count: 0,
      progress_percentage: 0,
      
      translations: []
    }
  },
  
  methods: {

    fetchLanguages(project_id) {
      this.$http.get(`/api/projects/${project_id}/languages`, {}).then(
        (response) => {
          
          this.translations = response.body.data;

        },

        (error) => {
          console.log(error);
        }
      )
    },

    isBasicLanguage(language_name){
        if (language_name === this.project.basic_language)
          return true;

        return false;
    }
  },
  
  mounted(){
    this.fetchLanguages(this.project.id);     
  }
}

</script>