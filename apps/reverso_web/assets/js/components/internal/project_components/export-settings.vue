<template>
  <span @click.stop>
    <el-button type="text" id="dialogVisable"  @click="dialogData.visable = true">
      <img :src="dialogData.icon">
    </el-button>
    <exportDialog v-bind:dialogData="dialogData" v-if="dialogData.visable" @close="dialogData.visable = false">
        
    </exportDialog>
  </span>
</template>

<script>
import exportDialog from './dialogs/export-dialog.vue'

export default {
  name: "exportSettings",

  components: {
    'exportDialog': exportDialog
  },

  data () {
    return {

      dialogData: {
        visable: false,
        header: "export settings",
        icon: "/images/ic-export.svg"
      }
    }

  }
  
}
</script>