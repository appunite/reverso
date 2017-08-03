<template>
<span @click.stop>
  <el-button type="text" id="dialogVisable" 
  class="dialog-btn-icon__last" @click="toggleVisibility">
    <icon
      v-bind:imageName="dialogParams.icon_name"
      v-bind:className='icon_class'
      color="#5F69EF">  
    </icon>
  </el-button>
  
  <projectDialog 
  v-bind:dialogParams="dialogParams"
  v-if="dialogData.visable" 
  v-on:submit="updateProject($event)"
  @close="toggleVisibility">
      
  </projectDialog>
</span>
</template>

<script>
import projectService from '../../../../services/project-service.js'
import languageService from '../../../../services/language-service.js'
import projectDialog from '../dialogs/project-dialog.vue'
import icon from '../../../../icons.vue'

export default {
  name: "editProject",

  props: [
    'project'
  ],

  components: {
    'projectDialog': projectDialog,
    'icon': icon
  },

  data () {
    return {
      icon_class: "icon-gray",

      dialogData: {
        visable: false,
        header: "project settings",
        icon_name: 'settings',
        delete_btn: true,

        project: {},

        languages: []
      }

    }
  },

  methods: {
    updateProject(project){
      let previous_platforms = 
        projectService.platformsMapToArray(this.dialogParams.project.platforms);

      project["platforms_removed"] = _.difference(previous_platforms, project.platforms);

      project["platforms_added"] = _.difference(project.platforms, previous_platforms);

      delete project.platforms;

      projectService.updateProject(project).then(
        (response) => {
          this.$bus.$emit('project_edited', response.data.data);
        },

        (error) => {
          console.log(error);
        }
      );

    },

    toggleVisibility(){
      this.dialogData.visable = !this.dialogData.visable;
    }
  },

  computed: {
    dialogParams() {
      this.dialogData["project"] = this.project;
      this.dialogData["languages"] = this.project.languages;
      return this.dialogData; 
    }
  }
}
</script>
