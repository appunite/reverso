<template>
  <div class="add-language">
    <el-button type="text"
    class="add_sth_btn"
    id="dialogVisable"
    @click="toggleVisibility">
      <img :src="dialogData.icon">Add language
    </el-button>

    <languageDialog
    v-bind:dialogData="dialogParams"
    v-if="dialogData.visable"
    v-on:upload="upload($event)"
    @close="toggleVisibility">
        
    </languageDialog>
  </div>
</template>

<script>
import languageService from '../../../../services/language-service.js'
import languageDialog from '../dialogs/language-dialog.vue'

export default {
  name: "newLanguage",

  props: [
    'project'
  ],

  components: {
    'languageDialog': languageDialog
  },

  data () {
    return {

      dialogData: {
        visable: false,
        header: "new language",
        icon: "/images/ic-add.svg",

        project: {}
      }
    }
  },

  computed: {
    dialogParams() {
      this.dialogData["project"] = this.project;
      return this.dialogData; 
    }
  },

  methods: {
    toggleVisibility(){
      this.dialogData.visable = !this.dialogData.visable;
    },

    upload(new_language){
      new_language['project_id'] = this.project.id;

      languageService.uploadLanguageToProject(new_language).then(
      (response) => {
        this.$emit('languageAdded', response.data);
      },

      (error) => {
        console.log(error);
      });
    },
  }
}
</script>