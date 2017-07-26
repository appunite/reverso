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

    <el-form ref="form" :model="language" label-position="top">

      <div class="input-wrapper">
      <label>Language</label>
        <el-select v-model="language" placeholder="Select Language">
          <el-option v-for="language in languages"
          :label="language.language_name"
          :value="language.language_name">
          </el-option>
        </el-select>
      </div>

      <div class="input-wrapper no-border">
        <label class="input-wrapper.label">Import</label>
      </div>

      <el-button type="primary" class="primary-btn" @click="onSubmit">Add</el-button>
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
      languages: []
    }
  },

  methods: {

    submitUpload() {
      //this.$refs.upload.submit();
    },
    onSubmit() {

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


