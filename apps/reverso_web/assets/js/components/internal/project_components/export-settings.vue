<template>
  <span @click.prevent.stop>

    <span @click="toggleVisibility">
      <slot>
        <el-button type="text" id="dialogVisable">
          <icon
          v-bind:imageName="dialogData.icon_name"
          color="#5F69EF">
          </icon>
        </el-button>
      </slot>    
    </span>

    <exportDialog
    v-bind:dialogData="dialogParams"
    v-if="dialogData.visable"
    v-on:download="download"
    @close="toggleVisibility">
        
    </exportDialog>
  </span>
</template>

<script>
import icon from '../../../icons.vue'
import projectService from '../../../services/project-service.js'
import exportDialog from './dialogs/export-dialog.vue'

export default {
  name: "exportSettings",

  components: {
    'exportDialog': exportDialog,
    'icon': icon
  },

  props: [
    'project_id',   
    'project_name',
    'language_id',
    'language_name'
  ],

  data () {
    return {
      dialogData: {
        visable: false,
        header: "export settings",
        icon_name: "export",

        fileName: ""
      }
    }
  },

  methods: {
    toggleVisibility(){
      this.dialogData.visable = !this.dialogData.visable;
    },

    download(){
      if (this.language_id) {
        projectService.exportLanguage(this.project_id, this.language_id);
      }
      else {
        projectService.exportProject(this.project_id);
      }
    }
  },

  computed: {
    dialogParams() {
      let fileName = this.project_name.replace(/[^a-z0-9]/ig, '_');
      if(this.language_name){
        fileName += `-${this.language_name}`
      }
      this.dialogData.fileName = fileName;

      return this.dialogData; 
    }
  }  
}
</script>