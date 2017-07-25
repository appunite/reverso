<template>

  <el-dialog
  :visible.sync="dialogData.visable"
  size="tiny"
  :before-close="handleClose"
  :show-close="false" class="reverso-dialog language-dialog">
    <span slot="title" class="dialog-title">
      <img :src="dialogData.icon">
      {{ dialogData.header }}
    </span>

    <el-form ref="form" :model="language" label-position="top">

      <div class="input-wrapper">
      <label>Language</label>
        <el-select v-model="language" placeholder="Select Language">
          <el-option v-for="language in languages" :label="language.language_name" :value="language.language_name"></el-option>
        </el-select>
      </div>

      <div class="input-wrapper no-border">
        <label class="input-wrapper.label">Import</label>
        <el-upload
          class="upload-demo"
          ref="upload"
          action="https://jsonplaceholder.typicode.com/posts/"
          :before-upload="xdxd(file)"
          :auto-upload="false" >
          <el-button type="text" class="add_sth_btn" slot="trigger"><img src="images/ic-upload.svg">upload file</el-button> <span class="upload-tip">xliff files supported</span>
          <div class="el-upload__tip" slot="tip"></div>
        </el-upload>
      </div>

      <el-button type="primary" class="primary-btn" @click="onSubmit">Add</el-button>
      <el-button class="cancel-btn" @click="dialogData.visable = false">Cancel</el-button>  

    </el-form>

  </el-dialog>

</template>

<script>
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
    fetchLanguages(){
      this.$http.get("/api/languages", {}).then(
      (response) => {
        console.log(response.data);
        this.languages = response.data.data;
      },
      (error) => {
        console.log(error);
      })
    },

    xdxd(file){
      console.log(file);
      return false;
    },

    submitUpload() {
      //this.$refs.upload.submit();
    },
    onSubmit() {

    }
  },

  mounted() {
    this.fetchLanguages();
  }
  
}
</script>


