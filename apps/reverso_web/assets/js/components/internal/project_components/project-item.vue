<template>  
  <div class="project-item">
  

    <div v-for="language in project.languages" class="project-item__language">
      <router-link :to="{ name: 'translation',
      params:
      { project_id: project.id,
      language_id: language.language_id }
      }">
      
      <span class="summary">
        <span class="summary-col-1">
          {{ language.language_name }}
        </span>

        <span class="summary-col-2">
          <p v-if="isBasicLanguage(language.language_name)">reference</p>
          <p v-else>{{ language.count }}/{{reference_str_count}} strings translated</p>

          
        </span>

        <span class="summary-col-3">
          <p v-if="language.last_edit">
            {{ language.last_edit }} last edit by {{ language.editor }}
          </p>          
        </span>
    
        <span class="summary-col-4">
          <exportSettings></exportSettings>
        </span>
      </span>
      </router-link>

    </div>

    <div class="add-language">
      <newLanguage v-bind:project_id="project.id"></newLanguage>
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
    isBasicLanguage(language_name){
        if (language_name === this.project.basic_language)
          return true;

        return false;
    }
  }
}

</script>
