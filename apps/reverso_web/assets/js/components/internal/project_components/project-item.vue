<template>  
  <div class="project-item">
  
    <div
    v-for="language in project.languages"
    :key="language.language_id"
    class="project-item__language">
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
          <div v-if="isBasicLanguage(language.language_name)">reference</div>
          <div v-else>{{ language.strings_count }}/{{reference_str_count}} strings translated</div>

          
        </span>

        <span class="summary-col-3">
          <div v-if="language.last_edit_time">
            {{ language.last_edit_time }} last edit by {{ language.last_editor_name }}
          </div>          
        </span>
    
        <span class="summary-col-4">
          <exportSettings
          v-bind:project_id="project.id"
          v-bind:project_name="project.project_name"
          v-bind:language="language">
          </exportSettings>
        </span>
      </span>
      </router-link>

    </div>
    
    <newLanguage v-bind:project_id="project.id"></newLanguage>
    
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
