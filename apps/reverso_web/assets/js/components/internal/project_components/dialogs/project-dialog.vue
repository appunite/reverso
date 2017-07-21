<template>

  <el-dialog
  :visible.sync="dialogData.visable"
  :before-close="handleClose"
  :show-close="false"
  size="tiny" class="project-dialog">
  <span slot="title">
    <img :src="dialogData.icon">
    {{ dialogData.header }}
  </span>

  <el-form ref="form" :model="dialogData.project" label-position="top">
    <div class="input-wrapper">
      <label>Project Name</label><br>
      <input type="text" placeholder="Name Your Project">
    </div>
    
    <div class="input-wrapper">
      <label>Reference Language</label>
      <el-select v-model="dialogData.project.basic_language" placeholder="Select Language">
        <el-option label="English" value="English"></el-option>
      </el-select>
    </div>
    
    <div class="input-wrapper platform">
      <label>Select Platforms</label><br>
      <el-checkbox-group v-model="dialogData.project.platforms" fill="#ffffff" >
        <el-checkbox-button v-for="platform in platforms" :name="platform.name" class="platform-checkbox">
          <div @click="platform.sel = !platform.sel">
            <img :src="platform.img_sel" v-if="platform.sel">
            <img :src="platform.img_unsel" v-else>
          </div>
        </el-checkbox-button>
      </el-checkbox-group>  
    </div>

    <div class="dialog-footer">
      <el-button type="primary" @click="onSubmit">Save</el-button>
      <el-button class="cancel-btn" @click="cleanup">Cancel</el-button>
      <el-button v-if="dialogData.delete_btn">Delete</el-button> 
    </div>

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

        bus.$emit(this.dialogData.bus_event, this.dialogData.project); 
        this.cleanup();
      },

      cleanup(){
        this.dialogData.visable = false;
        this.dialogData.project = {project_name: "", basic_language: "", platforms: []};
      }
    },
    created(){

    }
  }

</script>

<style lang="scss">
  .el-dialog--tiny {
    width: 470px;
  }

  .el-dialog__header {
    text-transform: uppercase;
    color: blue;
    font-size: small;
    margin: 12px 0px 10px 10px;

    img{
      margin-bottom: 3px;
    }
  }
  .el-dialog__body {
    padding: 25px 16px;
  }

  .dialog-footer {
    .el-button{
      width: 70px;
    }
  }

  .input-wrapper {
    border: 1px solid lightgray;
    margin-bottom: 16px;
    border-radius: 5px;
    padding: 10px;

    label {
      color: slategray;
    }

    .el-select {
      width: 100%;
    }

    input {
      border: none;
      width: 100%;
      background: transparent;
      font-size: large;   
      padding: 0;

      &:focus {
        outline: 0;
      }

      &::placeholder {
        color: lightgray;
      }
    }



  }

  .platform {
    border: none;

    .el-checkbox-group {
      margin-left: 58px;
    }

    span {
      border: none;
      border-left: none !important;
    }
  }
  .el-button--primary {
    background-color: green;
    border: none;
  }

  .cancel-btn {
    border: none;
    width: 100px;
    text-transform: uppercase;
    font-size: smaller;
    color: slategray;
  }


</style>