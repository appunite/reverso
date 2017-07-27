<template>

  <el-dialog
  :visible.sync="dialogData.visable"
  size="tiny"
  :before-close="handleClose"
  :show-close="false"
  class="reverso-dialog language-dialog">

    <span slot="title" class="dialog-title">
      <img :src="dialogData.icon">
      {{ dialogData.header }}
    </span>

    <el-form ref="form"
    :model="new_language"
    label-position="top"
    enctype="multipart/form-data">

      <div class="input-wrapper">
      <label>Language</label>
        <el-select v-model="new_language.language_name"
        placeholder="Select Language">
          <el-option v-for="language in languages"
          :label="language.language_name"
          :value="language.language_name">
          </el-option>
        </el-select>
      </div>

      <div class="input-wrapper no-border">
        <label class="input-wrapper.label">Import</label>

        <input type="file" @change="filesChange($event.target.files)">
      </div>

      <el-button type="primary" class="primary-btn" @click="onUpload">Add</el-button>
      <el-button class="cancel-btn" @click="close">Cancel</el-button>  

    </el-form>

  </el-dialog>

</template>

<script>
import languageService from '../../../../services/language-service.js'
  
export default {
  name: "languageDialog",

  props: [
    'dialogData'
  ],

  data () {
    return {
      new_language: {
        language_name: ""
      },

      languages: []
    }
  },

  methods: {
    onUpload(){
      languageService.uploadLanguage(this.new_language);
    },

    filesChange(fileList) {
      let file = fileList[0];
      this.new_language['language_file'] = file;
    },

    close(){
      this.$emit("close");
    }
  },

  mounted() {
    languageService.fetchLanguages().then(
      (response) => {
        this.languages = response.data.data;
      },
      (error) => {
        console.log(error);
      });
  }
  
}
</script>


