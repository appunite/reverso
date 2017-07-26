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

      project["platforms_removed"] = _.difference(this.dialogParams.project.platforms, project.platforms);

      project["platforms_added"] = _.difference(project.platforms, this.dialogParams.project.platforms);

      delete project.platforms;

      this.$http.patch(`api/projects/${project.id}`, project).then(
        (response) => {
          let resp_project = projectService.process(response);
          this.$bus.$emit(this.dialogParams.bus_event, resp_project);
        },
        (error) => {
          console.log(error);
        }
      )

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