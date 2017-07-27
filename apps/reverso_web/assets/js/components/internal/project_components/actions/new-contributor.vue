<template>
  <span @click.stop>
    <el-button type="text"
    id="dialogVisable"
    @click="toggleVisability">

      <img :src="dialogData.icon">
    </el-button>

    <contributorDialog
    v-bind:dialogData="dialogData"
    v-bind:projectId="projectId"
    v-if="dialogData.visable"
    @close="toggleVisability">
        
    </contributorDialog>
  </span>
</template>

<script>
import contributorDialog from '../dialogs/contributor-dialog.vue'

export default {
  name: "newContributor",

  props: [
    'projectId'
  ],

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
  },

  methods: {
    toggleVisability(){
      this.dialogData.visable = !this.dialogData.visable;
    }
    
  }
  
}
</script>