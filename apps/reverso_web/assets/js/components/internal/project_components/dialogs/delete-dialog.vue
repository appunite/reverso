<template>

  <el-dialog
  :visible.sync="dialogData.visable"
  :show-close="false"
  :modal="false"
  size="tiny"
  class="reverso-dialog delete-dialog">
    <img src="/images/ic-alert-triangle.svg">
  
    <div>
      <h3>Delete Confirmation</h3>
      Are you sure you want to delete this {{dialogData.deletionObject}}? This action is irreversible and you can loose all your data.
    </div>

    <div>
      <el-button type="primary" class="danger-btn" @click="confirm">
        Delete
      </el-button>
      <el-button class="cancel-btn" @click="cancel">Cancel</el-button>
    </div>

  </el-dialog>
</template>

<script>
  
  export default {
    name: "deleteDialog",

    props: [
      'dialogData'
    ],


    methods: {
      confirm(){
        this.$emit("confirm");
        this.close();
      },

      cancel(){
        this.$message('Delete canceled.');
        this.$emit("close");
      },

      close(){
        this.$emit("close");
      }
    }
  }

</script>
