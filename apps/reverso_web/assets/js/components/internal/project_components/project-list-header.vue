a<template>  
  <span class="summary">
    <span class="summary-col-1">
              {{ project_name }}
            </span>

            <span class="summary-col-2">
              languages
              strings
            </span>

            <span class="summary-col-3">
              <el-progress :percentage="100" status="success" :show-text="false"></el-progress>
            </span>

            <span class="summary-col-4">
              <span class="summary-col-4__icons">
                <newContributor></newContributor>
                <exportSettings></exportSettings>
                <editProject v-bind:project="project"></editProject>
              </span>
            </span>
          </span>
</template>

<script>
import newContributor from './actions/new-contributor.vue'
import exportSettings from './export-settings.vue'
import editProject from './actions/edit-project.vue'

export default {
  name: "projectListHeader",

  props: [
    'project_name'
  ],

  components: {
    'newContributor': newContributor,
    'exportSettings': exportSettings,
    'editProject': editProject
  },

  data () {
    return {
    }

  },
}
</script>