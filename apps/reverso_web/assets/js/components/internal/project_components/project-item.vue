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
          <div v-if="isBasicLanguage(language.language_name)">
            <strong>reference</strong>
          </div>

          <div v-else>
          <strong>
            {{ language.strings_count }}{{ reference_str_count }}
          </strong>
          strings translated</div>          
        </span>

        <span class="summary-col-3">
          <div v-if="language.last_edit_time">
            <strong> {{ convertedTime(language.last_edit_time) }}</strong>
            last edit by
            <strong>{{ language.last_editor_name }}</strong>
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
    
    <newLanguage
      v-bind:project="project"
      v-on:languageAdded="appendLanugage($event)">
    </newLanguage>
    
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
      progress_percentage: 0,
      
      translations: []
    }
  },

  methods: {
    isBasicLanguage(language_name){
        if (language_name === this.project.basic_language)
          return true;

        return false;
    },

    convertedTime(last_edit){
      return projectService.convertedTime(last_edit, "MMM D, YYYY");
    },

    appendLanugage(language){
      this.project.languages.push(language);
      this.project.number_of_languages++;
    }
  },

  computed: {
    reference_str_count(){
      if (this.project.reference_language){
        return '/' + this.project.reference_language.strings_count;
      }
      else {
        return "";
      }
    }
  }
}

</script>
