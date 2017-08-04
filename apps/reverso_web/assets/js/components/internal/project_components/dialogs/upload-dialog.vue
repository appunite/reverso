<template>

  <el-dialog
  :visible.sync="dialogData.visible"
  size="tiny"
  :before-close="handleClose"
  :show-close="false"
  class="reverso-dialog language-dialog">

    <div slot="title" class="dialog-title">
      <icon
      v-bind:imageName="dialogData.icon_name"
      color="#EBEBF1">
      </icon>
      {{ dialogData.header }}
    </div>

    <el-form ref="form" :model="dialogData" label-position="top">

      <div class="input-wrapper">
      <label>Language</label>
        <el-input v-model="dialogData.language_name" readonly>
        </el-input>
      </div>

      <div class="input-wrapper no-border">
        <label class="input-wrapper.label">Import</label> 
        <div class="upload-input">
          <span class="upload-input__btn">
            <img src="/images/ic-upload.svg"> upload file
          </span>        
          <input type="file"
          accept=".xliff"
          @change="filesChange($event.target.files)">
          <span class="upload-tip">{{file_name}}</span>
        </div>
      </div>

      <div class="input-wrapper no-border">
        <label>Platforms</label><br>
        <div class="platforms-readonly">
          <span v-for="platform in platforms"
          v-if="includesPlatform(dialogData.platforms, platform.name)">
            <img :src="platform.img_sel">
          </span>
        </div>  
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
import icon from '../../../../icons.vue'

export default {
  name: "uploadDialog",

  props: [
    'dialogData'
  ],

  components: {
    'icon': icon
  },

  data () {
    return {
      platforms: [
      {
        name: "Android",
        img_sel: "/images/platforms/ic-Android-selected.svg"
      },
      {
        name: "iOS",
        img_sel: "/images/platforms/ic-apple-selected.svg"
      },
      {
        name: "Desktop",
        img_sel: "/images/platforms/ic-desktop-selected.svg"
      }
      ]
    }
  },

  methods: {
    onUpload(){
      this.$emit("upload");
      this.close();
    },

    includesPlatform(platformArray, platform_name){
      return formService.includesPlatform(platformArray, platform_name);
    },

    filesChange(fileList) {
      let file = fileList[0];
      this.dialogData['language_file'] = file;
    },

    close(){
      this.$emit("close");
    }
  },

  computed: {
    formReady: function () {
      return formService.formReady([this.dialogData.language_file]);
    },
    
    file_name(){
      if (this.dialogData.language_file){
        return this.dialogData.language_file.name;
      }
      
      return "xliff files supported";
    }
  }  
}
</script>