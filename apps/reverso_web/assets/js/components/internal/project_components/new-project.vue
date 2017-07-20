<template>
  <span>
    <el-button type="text" id="dialogVisable"  @click="dialogData.visable = true">
      <img :src="dialogData.icon">Add new project

    </el-button>
    <projectDialog v-bind:dialogData="dialogData" v-if="dialogData.visable" @close="dialogData.visable = false">
        
    </projectDialog>
  </span>
</template>

<script>
import projectDialog from '../session_components/modals/project-dialog.vue'

export default {
  name: "newProject",

  components: {
    'projectDialog': projectDialog
  },

  data () {
    return {

      dialogData: {
        visable: false,
        header: "new project",
        icon: "/images/ic-add.svg",
        delete_btn: false,
        url: "api/projects",

        project: {
          project_name: "",
          basic_language: "",
          platforms: []
        }
      }

    }
  }
}
</script>