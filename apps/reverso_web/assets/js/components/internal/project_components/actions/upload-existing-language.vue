<template>
<span @click.stop>
  <span @click="toggleVisibility">
    <slot>
      <el-button class="white-btn">
        Upload file
      </el-button>
    </slot>
  </span>

  <uploadDialog
    v-bind:dialogData="dialogParams"
    v-if="dialogData.visible"
    v-on:upload="upload($event)"
    @close="toggleVisibility">
        
  </uploadDialog>
</span>
</template>

<script>
import projectService from '../../../../services/project-service.js'
import languageService from '../../../../services/language-service.js'
import uploadDialog from '../dialogs/upload-dialog.vue'

export default {
  name: "uploadExistingLanguage",

  props: [
    'platforms',
    'language_id',
    'language_name'
  ],

  components: {
    'uploadDialog': uploadDialog
  },

  data () {
    return {

      dialogData: {
        visible: false,
        header: "new upload",
        icon_name: "add",
        
        language_id: null,
        language_name: "",
        language_file: null,
        platforms: [],

        project: {}
      }
    }
  },

  computed: {
    dialogParams() {
      this.dialogData.language_name = this.language_name;
      this.dialogData.language_id = this.language_id;
      this.dialogData.platforms =
        projectService.platformsMapToArray(this.platforms);
      this.dialogData.project = this.project;
      return this.dialogData; 
    }
  },

  methods: {
    toggleVisibility(){
      this.dialogData.visible = !this.dialogData.visible;
    },

    upload(){
      languageService.uploadFileToExistingLanguage(
        this.dialogParams.language_id,
        this.dialogParams.language_file,
        this.dialogParams.platforms
      ).then(
        (response) => {
          this.$emit('languageAdded', response.data);
        },

        (error) => {
          console.log(error);
        }
      );
    },
  }
}
</script>