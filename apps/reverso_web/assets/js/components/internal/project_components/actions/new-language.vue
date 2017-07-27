<template>
  <span>
    <el-button type="text"
    class="add_sth_btn"
    id="dialogVisable"
    @click="toggleVisability">
      <img :src="dialogData.icon">Add language
    </el-button>

    <languageDialog
    v-bind:dialogData="dialogData"
    v-if="dialogData.visable"
    v-on:upload="upload($event)"
    @close="toggleVisability">
        
    </languageDialog>
  </span>
</template>

<script>
import languageService from '../../../../services/language-service.js'
import languageDialog from '../dialogs/language-dialog.vue'

export default {
  name: "newLanguage",

  props: [
    'project_id'
  ],

  components: {
    'languageDialog': languageDialog
  },

  data () {
    return {

      dialogData: {
        visable: false,
        header: "new language",
        icon: "/images/ic-add.svg"
      }
    }
  },

  methods: {
    toggleVisability(){
      this.dialogData.visable = !this.dialogData.visable;
    },

    upload(new_language){
      new_language['project_id'] = this.project_id;

      languageService.uploadLanguage(new_language).then(
      (response) => {
        //emit event
      },

      (error) => {
        console.log(error);
      });
    }
  }  
}
</script>