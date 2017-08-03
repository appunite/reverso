<template>  
<span class="summary">
  <span class="summary-col-1">
    {{ project.project_name }}
  </span>

  <span class="summary-col-2">
    <span>
      <strong>{{ project.number_of_languages }}</strong> languages
    </span>
    <span v-if="project.reference_language">
      <strong>
        {{ project.reference_language.strings_count }}
      </strong> strings
    </span>
    <span v-else>
      no reference
    </span>
  </span>

  <span class="summary-col-3">
    <el-progress
    v-if="project.reference_language"
    :percentage="progress_percentage"
    status="success"
    :show-text="false">
    </el-progress>
  </span>

  <span class="summary-col-4">
    <span class="summary-col-4__contributors">
      <contributorsInitials v-bind:contributors="project.collaborators"></contributorsInitials>
    </span>
    <span class="summary-col-4__icons">
      <newContributor v-bind:projectId="project.id"></newContributor>
      <exportSettings
      v-bind:project_id="project.id"
      v-bind:project_name="project.project_name">
      </exportSettings>
      <editProject v-bind:project="project"></editProject>
    </span>
  </span>
  
</span>
</template>

<script>
  import contributorsInitials from './contributors-initials.vue'
  import newContributor from './actions/new-contributor.vue'
  import exportSettings from './export-settings.vue'
  import editProject from './actions/edit-project.vue'

  export default {
    name: "projectListHeader",

    props: [
      'project'
    ],

    components: {
      'contributorsInitials': contributorsInitials,      
      'newContributor': newContributor,
      'exportSettings': exportSettings,
      'editProject': editProject
    },

    computed: {
      progress_percentage() {
        let numerator = _.sum(_.map(this.project.languages, "strings_count"));
        let denominator =
          this.project.reference_language.strings_count *
          this.project.number_of_languages;

        return numerator/denominator * 100;
      }
    }
  }
</script>