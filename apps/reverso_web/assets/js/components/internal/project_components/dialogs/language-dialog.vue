<template>

  <el-dialog
  :visible.sync="dialogData.visable"
  size="tiny"
  :before-close="handleClose"
  :show-close="false" class="dialog">
    <span slot="title" class="dialog-title">
      <img :src="dialogData.icon">
      {{ dialogData.header }}
    </span>

    <el-form ref="form" :model="language" label-position="top">

      <el-form-item label="Language">
        <el-select v-model="language" placeholder="Select Language">
          <el-option label="English" value="en"></el-option>
        </el-select>
      </el-form-item>      

      <el-upload
        class="upload-demo"
        ref="upload"
        action="https://jsonplaceholder.typicode.com/posts/"
        :auto-upload="false" >
        <el-button type="text" slot="trigger"><img src="images/ic-upload.svg">upload file</el-button>
        <div class="el-upload__tip" slot="tip">xliff files supported</div>
      </el-upload>
        
      <el-button type="primary" @click="onSubmit">Add</el-button>
      <el-button @click="dialogData.visable = false">Cancel</el-button>  

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
      language: ""
    }
  },
  methods: {
    submitUpload() {
      //this.$refs.upload.submit();
    },
    onSubmit() {

    }
  }
  
}
</script>


