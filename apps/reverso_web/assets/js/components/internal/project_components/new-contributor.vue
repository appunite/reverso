<template>
  <span @click.stop>
    <el-button type="text" id="dialogVisable"  @click="dialogData.visable = true">
      <img :src="dialogData.icon">
    </el-button>
    <contributorDialog v-bind:dialogData="dialogData" v-if="dialogData.visable" @close="dialogData.visable = false">
        
    </contributorDialog>
  </span>
</template>

<script>
import contributorDialog from '../session_components/modals/contributor-dialog.vue'

export default {
  name: "newContributor",

  components: {
    'contributorDialog': contributorDialog
  },

  data () {
    return {

      dialogData: {
        visable: false,
        header: "invite contributors",
        icon: "/images/ic-add-contributor.svg"
        
      }
    }

  }
  
}
</script>