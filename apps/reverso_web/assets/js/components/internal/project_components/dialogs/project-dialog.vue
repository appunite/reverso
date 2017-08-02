<template>

  <el-dialog
  :visible.sync="dialogParams.visable"
  :before-close="handleClose"
  :show-close="false"
  size="tiny" class="reverso-dialog">
  <div slot="title">
    <icon
      v-bind:imageName="dialogParams.icon_name"
      v-bind:className='icon_class'
      color="#969AA7">  
    </icon>
    {{ dialogParams.header }}
  </div>

  <el-form ref="form" :model="tempProject" label-position="top">

    <div class="input-wrapper">
      <label>Project Name</label>
      <input type="text"
      placeholder="Name Your Project"
      v-model="tempProject.project_name"
      maxlength="35">

    </div>
    
    <div class="input-wrapper">
      <label>Reference Language</label>
      <el-select v-model="tempProject.basic_language" placeholder="Select Language">
        <el-option v-for="language in languages"
        :label="language.language_name"
        :value="language.language_name">
        </el-option>
      </el-select>
    </div>
    
    <div class="input-wrapper no-border">
      <label>Select Platforms</label><br>
      <el-checkbox-group v-model="tempProject.platforms" fill="#ffffff">
        <el-checkbox-button v-for="platform in platforms"
        :label="platform.name"
        :name="platform.name"
        class="platform-checkbox">

          <img :src="platform.img_sel" v-if="includesPlatform(platform.name)">
          <img :src="platform.img_unsel" v-else>
        </el-checkbox-button>
      </el-checkbox-group>  
    </div>

    <div class="dialog-footer">
      <span>
        <el-button type="primary"
        class="primary-btn"
        :disabled="!formReady"
        @click="onSubmit">Save</el-button>

        <el-button class="cancel-btn" @click="close">Cancel</el-button>
      </span>

      <div>
        <deleteProject
        v-if="dialogParams.delete_btn"
        v-bind:project="tempProject"
        v-on:close="close">

        </deleteProject>         
      </div>
    </div>

  </el-form>
  </el-dialog>
</template>

<script>
  import projectService from '../../../../services/project-service.js'
  import formService from '../../../../services/form-service.js'
  import languageService from '../../../../services/language-service.js'
  import deleteProject from '../actions/delete-project'
  import icon from '../../../../icons.vue'

  export default {
    name: "projectDialog",

    props: [
    'dialogParams'
    ],

    components: {
      'deleteProject': deleteProject,
      'icon': icon
    },

    data () {
      return {
        icon_class: 'icon-gray',
        tempProject: {},
        languages: [],

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
        ]
      }

    },
    methods: {
      onSubmit(){
        this.$emit('submit', this.tempProject);
        this.close();
      },
      
      includesPlatform(platform_name){
        return formService.includesPlatform(this.tempProject.platforms, platform_name);
      },

      close(){
        this.$emit("close");
      }
    },

    computed: {
      formReady: function () {
        return formService.formReady(
          [this.tempProject.project_name,
          this.tempProject.basic_language,
          this.tempProject.platforms]);
      }
    },

    created(){
      this.tempProject = _.cloneDeep(this.dialogParams.project); 
      this.tempProject.platforms = 
        projectService.platformsMapToArray(this.tempProject.platforms);
    },

    mounted(){
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
