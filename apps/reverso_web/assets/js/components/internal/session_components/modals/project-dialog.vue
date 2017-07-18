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
        <el-input v-model="dialogData.project.title" placeholder="Name Your Project"></el-input>
      </el-form-item>

      <el-form-item label="Reference Language">
        <el-select v-model="dialogData.project.ref_lang" placeholder="Select Language">
          <el-option label="English" value="en"></el-option>
        </el-select>
      </el-form-item>

      <el-form-item label="Select Platforms">
        <el-checkbox-group v-model="dialogData.project.platforms">
          <el-checkbox label="Android" name="Android"></el-checkbox>
          <el-checkbox label="iOS" name="iOS"></el-checkbox>
          <el-checkbox label="Desktop" name="Desktop"></el-checkbox>
        </el-checkbox-group>
      </el-form-item>
      
        
        <el-button type="primary" @click="onSubmit">Save</el-button>
        <el-button>Cancel</el-button>
        <el-button v-if="dialogData.delete_btn">Delete</el-button>        

    </el-form>

  </el-dialog>

</template>

<script>
export default {
  name: "projectDialog",

  props: [
    'dialogData'
  ],

  data () {
    return {      

    }
  },
}
</script>

<style scoped>


</style>