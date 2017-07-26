<template>
<span @click.stop>
  <el-button type="text" id="dialogVisable" @click="toggleVisability">
    <img :src="dialogData.icon">
  </el-button>
  
  <projectDialog 
  v-bind:dialogParams="dialogParams"
  v-if="dialogData.visable" 
  v-on:submit="updateProject($event)"
  @close="toggleVisability">
      
  </projectDialog>
</span>
</template>

<script>
import projectService from '../../../../services/project-service.js'
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

      projectService.updateProject(project).then(
        (response) => {
          let resp_project = projectService.process(response);
          this.$bus.$emit('project_edited', resp_project);
        },

        (error) => {
          console.log(error);
        }
      );
    },

    toggleVisability(){
      this.dialogData.visable = !this.dialogData.visable;
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