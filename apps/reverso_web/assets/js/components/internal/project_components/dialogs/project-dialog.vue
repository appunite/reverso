<template>

  <el-dialog
  :visible.sync="dialogData.visable"
  size="tiny"
  :before-close="handleClose"
  :show-close="false">
    <span slot="title" class="dialog-title">
      <img :src="dialogData.icon">
      {{ dialogData.header }}
    </span>

    <el-form ref="form" :model="dialogData.project" label-position="top">
      <el-form-item label="Project Name">
        <el-input v-model="dialogData.project.project_name" placeholder="Name Your Project"></el-input>
      </el-form-item>

      <el-form-item label="Reference Language">
        <el-select v-model="dialogData.project.basic_language" placeholder="Select Language">
          <el-option label="English" value="English"></el-option>
        </el-select>
      </el-form-item>

      <el-form-item label="Select Platforms">
        <el-checkbox-group v-model="dialogData.project.platforms" fill="#ffffff">
          <el-checkbox-button v-for="platform in platforms" :label="platform.name" :name="platform.name" >
            <div @click="platform.sel = !platform.sel">
              <img :src="platform.img_sel" v-if="platform.sel">
              <img :src="platform.img_unsel" v-else>
            </div>
          </el-checkbox-button>
        </el-checkbox-group>
      </el-form-item>
      
        
        <el-button type="primary" @click="onSubmit">Save</el-button>
        <el-button @click="cleanup">Cancel</el-button>
        <el-button v-if="dialogData.delete_btn">Delete</el-button>        

    </el-form>

  </el-dialog>

</template>

<script>
import { bus } from '../../../../app';

export default {
  name: "projectDialog",

  props: [
    'dialogData'
  ],

  data () {
    return {
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
      this.$http.post(this.dialogData.url, this.dialogData.project).then(function(data){
        console.log(data);
      });
      this.cleanup();
    },

    cleanup(){
      this.dialogData.visable = false;
      this.dialogData.project = {project_name: "", basic_language: "", platforms: []};
      bus.$emit('update', []);    
    }
  }  
}

</script>

<style scoped>


</style>