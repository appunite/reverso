<template>
  <span @click.prevent.stop>

    <span @click="toggleVisability">
      <slot>
        <el-button type="text" id="dialogVisable">
          <img :src="dialogData.icon">
        </el-button>
      </slot>    
    </span>

    <exportDialog
    v-bind:dialogData="dialogParams"
    v-if="dialogData.visable"
    v-on:download="download"
    @close="toggleVisability">
        
    </exportDialog>
  </span>
</template>

<script>
import projectService from '../../../services/project-service.js'
import exportDialog from './dialogs/export-dialog.vue'

export default {
  name: "exportSettings",

  components: {
    'exportDialog': exportDialog
  },

  props: [
    'project_id',   
    'project_name',
    'language'
  ],

  data () {
    return {
      dialogData: {
        visable: false,
        header: "export settings",
        icon: "/images/ic-export.svg",

        fileName: ""
      }
    }
  },

  methods: {
    toggleVisability(){
      this.dialogData.visable = !this.dialogData.visable;
    },

    download(){
      if (this.language) {
        projectService.exportLanguage(this.project_id, this.language.language_id);
      }
      else {
        projectService.exportProject(this.project_id);
      }
    }
  },

  computed: {
    dialogParams() {
      let fileName = this.project_name.replace(/[^a-z0-9]/ig, '_');
      if(this.language){
        fileName += `-${this.language.language_name}`
      }
      this.dialogData.fileName = fileName;

      return this.dialogData; 
    }
  }  
}
</script>