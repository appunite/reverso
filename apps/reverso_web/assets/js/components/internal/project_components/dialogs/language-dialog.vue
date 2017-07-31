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

    <el-form ref="form" :model="new_language" label-position="top">

      <div class="input-wrapper">
      <label>Language</label>
        <el-select v-model="new_language.language_name"
        placeholder="Select Language">
          <el-option
          v-for="language in languages"
          :label="language.language_name"
          :value="language.language_name">
          </el-option>
        </el-select>
      </div>

      <div class="input-wrapper no-border upload-btn-style">
        <label class="input-wrapper.label">Import</label> 
        <div class="upload-input">
          <span class="upload-input__btn">
            <img src="/images/ic-upload.svg"> upload file
          </span>        
          <input type="file" @change="filesChange($event.target.files)">
          <span class="upload-tip">{{file_name}}</span>
        </div>
      </div>

      <div class="input-wrapper no-border">
        <label>Select Platforms</label><br>
        <el-checkbox-group v-model="new_language.platforms" fill="#ffffff">
          <el-checkbox-button v-for="platform in platforms"
          :label="platform.name"
          :name="platform.name"
          class="platform-checkbox">
            <img :src="platform.img_sel" v-if="includesPlatform(platform.name)">
            <img :src="platform.img_unsel" v-else>
          </el-checkbox-button>
        </el-checkbox-group>  
      </div>

      <el-button type="primary"
      class="primary-btn" 
      :disabled="!formReady"
      @click="onUpload">Add</el-button>

      <el-button class="cancel-btn" @click="close">Cancel</el-button>  
      
    </el-form>

  </el-dialog>

</template>

<script>
import languageService from '../../../../services/language-service.js'
import formService from '../../../../services/form-service.js'

export default {
  name: "languageDialog",

  props: [
    'dialogData'
  ],

  data () {
    return {
      new_language: {
        language_name: "",
        language_file: null,
        platforms: []
      },

      platforms: [
      {
        name: "Android",
        img_sel: "/images/platforms/ic-Android-selected.svg",
        img_unsel: "/images/platforms/ic-Android-unselected.svg"
      },
      {
        name: "iOS",
        img_sel: "/images/platforms/ic-apple-selected.svg",
        img_unsel: "/images/platforms/ic-apple-unselected.svg"
      },
      {
        name: "Desktop",
        img_sel: "/images/platforms/ic-desktop-selected.svg",
        img_unsel: "/images/platforms/ic-desktop-unselected.svg"
      }
      ],

      languages: []
    }
  },

  methods: {
    onUpload(){
      this.$emit("upload", this.new_language);
      this.close();
    },

    filesChange(fileList) {
      let file = fileList[0];
      this.new_language['language_file'] = file;
    },

    includesPlatform(platform_name){
      return formService.includesPlatform(this.new_language.platforms, platform_name);
    },

    close(){
      this.$emit("close");
    }
  },

  computed: {
    formReady: function () {
      return formService.formReady([
        this.new_language.language_name,
        this.new_language.language_file,
        this.new_language.platforms]);
    },
    
    file_name(){
      if (this.new_language.language_file){
        return this.new_language.language_file.name;
      }
      
      return "xliff files supported";
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