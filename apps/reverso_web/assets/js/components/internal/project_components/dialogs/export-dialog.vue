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
 
  </el-dialog>

</template>

<script>
export default {
  name: "exportDialog",

  props: [
    'dialogData'
  ],

  data () {
    return {
    }
  },
  methods: {

    
  }
  
}
</script>

