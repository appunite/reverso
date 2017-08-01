<template>  
<span class="summary">
  <span class="summary-col-1">
    {{ project.project_name }}
  </span>

  <span class="summary-col-2">
    languages
    strings
  </span>

  <span class="summary-col-3">
    <el-progress
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
    }
  }
</script>