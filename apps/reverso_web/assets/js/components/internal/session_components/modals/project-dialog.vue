<template>

  <el-dialog
    :visible.sync="dialog_data.visable"
    size="tiny"
    :before-close="handleClose">
    <span slot="footer" class="dialog-footer">
    </span>
  </el-dialog>

</template>

<script>
export default {
  name: "projectDialog",

  props: [
    'dialog_data'
  ],

  data () {
    return {      

    }
  },
}
</script>

<style scoped>


</style>