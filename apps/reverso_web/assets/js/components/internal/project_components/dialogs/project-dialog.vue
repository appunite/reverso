<template>

  <el-dialog
  :visible.sync="dialogData.visable"
  :before-close="handleClose"
  :show-close="false"
  size="tiny" class="reverso-dialog">
  <span slot="title">
    <img :src="dialogData.icon">
    {{ dialogData.header }}
  </span>

  <el-form ref="form" :model="tempProject" label-position="top">

    <div class="input-wrapper">
      <label>Project Name</label>
      <input type="text" placeholder="Name Your Project" v-model="tempProject.project_name" maxlength="35">
    </div>
    
    <div class="input-wrapper">
      <label>Reference Language</label>
      <el-select v-model="tempProject.basic_language" placeholder="Select Language">
        <el-option label="English" value="English"></el-option>
      </el-select>
    </div>
    
    <div class="input-wrapper platform">
      <label>Select Platforms</label><br>
      <el-checkbox-group v-model="tempProject.platforms" fill="#ffffff">
        <el-checkbox-button v-for="platform in platforms" :label="platform.name" :name="platform.name" class="platform-checkbox">
          <div @click="platform.sel = !platform.sel">
            <img :src="platform.img_sel" v-if="platform.sel">
            <img :src="platform.img_unsel" v-else>
          </div>
        </el-checkbox-button>
      </el-checkbox-group>  
    </div>

    <div class="dialog-footer">
      <span>
        <el-button type="primary" class="primary-btn" :disabled="!formReady" @click="onSubmit">Save</el-button>
        <el-button class="cancel-btn" @click="close">Cancel</el-button>
      </span>
      <div>
        <el-button v-if="dialogData.delete_btn" class="delete-btn">Delete</el-button> 
      </div>
    </div>

  </el-form>
  </el-dialog>
</template>

<script>
  import projectService from '../../../../services/project-service.js'

  export default {
    name: "projectDialog",

    props: [
    'dialogData'
    ],

    data () {
      return {
        tempProject: {},

        platforms: [
        {
          name: "Android",
          img_sel: "/images/platforms/ic-Android-selected.svg",
          img_unsel: "/images/platforms/ic-Android-unselected.svg",
          sel: false
        },
        {
          name: "iOS",
          img_sel: "/images/platforms/ic-apple-selected.svg",
          img_unsel: "/images/platforms/ic-apple-unselected.svg",
          sel: false
        },
        {
          name: "Desktop",
          img_sel: "/images/platforms/ic-desktop-selected.svg",
          img_unsel: "/images/platforms/ic-desktop-unselected.svg",
          sel: false
        }
        ]
      }
    },
    methods: {
      onSubmit(){
        this.$http.post(this.dialogData.url, this.tempProject).then(
          (response) => {
            let resp_project = projectService.process(response);
            this.$bus.$emit(this.dialogData.bus_event, resp_project);
          },
          (error) => {

          }
        )

        this.close();
      },
      
      close(){
        this.dialogData.visable = false;
      }
    },

    computed: {
      formReady: function () {
        return projectService.formReady(this.tempProject);
      }
    },

    created(){
 
      this.tempProject = {
        project_name: this.dialogData.project.project_name,
        basic_language: this.dialogData.project.basic_language,
        platforms: this.dialogData.project.platforms
      };
    
    }
  }

</script>
