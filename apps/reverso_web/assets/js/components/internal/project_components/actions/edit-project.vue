<template>
<span @click.stop>
  <el-button type="text" id="dialogVisable" @click="dialogData.visable = true">
    <img :src="dialogData.icon">
  </el-button>
  <projectDialog 
  v-bind:dialogParams="dialogParams"
  v-if="dialogData.visable" 
  v-on:submit="updateProject($event)"
  @close="dialogData.visable = false">

      
  </projectDialog>
</span>
</template>

<script>
import projectDialog from '../dialogs/project-dialog.vue'

export default {
  name: "editProject",

  props: [
    'project'
  ],

  components: {
    'projectDialog': projectDialog
  },

  data () {
    return {

      dialogData: {
        visable: false,
        header: "project settings",
        icon: "/images/ic-settings.svg",
        delete_btn: true,
        bus_event: 'project_edited',

        project: {}
      }

    }
  },

  methods: {
    updateProject(project){
    }
  },

  computed: {
    dialogParams() {
      this.dialogData["project"] = this.project;
      return this.dialogData; 
    }
  }
}
</script>