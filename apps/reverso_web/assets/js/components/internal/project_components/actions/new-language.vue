<template>
  <div class="add-language">
    <el-button type="text"
    class="add_sth_btn"
    id="dialogvisible"
    @click="toggleVisibility">
      <icon
      v-bind:imageName="dialogData.icon_name"
      color="#5F69EF">
      </icon>
      Add language
    </el-button>

    <languageDialog
    v-bind:dialogData="dialogParams"
    v-if="dialogData.visible"
    v-on:upload="upload($event)"
    @close="toggleVisibility">
        
    </languageDialog>
  </div>
</template>

<script>
import languageService from '../../../../services/language-service.js'
import languageDialog from '../dialogs/language-dialog.vue'
import icon from '../../../../icons.vue'
export default {
  name: "newLanguage",
  props: [
    'project'
  ],
  components: {
    'languageDialog': languageDialog,
    'icon': icon
  },
  data () {
    return {
      dialogData: {
        visible: false,
        header: "new language",
        icon_name: "add",
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
      this.dialogData.visible = !this.dialogData.visible;
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