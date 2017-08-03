<template>
  <span @click.stop>
    <el-button type="text"
    id="dialogVisable"
    @click="toggleVisibility" class="dialog-btn-icon">

      <icon
      v-bind:imageName='dialogData.icon_name'
      color="#5F69EF">
      </icon>
    </el-button>

    <contributorDialog
    v-bind:dialogData="dialogData"
    v-bind:projectId="projectId"
    v-if="dialogData.visable"
    @close="toggleVisibility">
        
    </contributorDialog>
  </span>
</template>

<script>
import contributorDialog from '../dialogs/contributor-dialog.vue'
import icon from '../../../../icons.vue'

export default {
  name: "newContributor",

  props: [
    'projectId'
  ],

  components: {
    'contributorDialog': contributorDialog,
    'icon': icon
  },

  data () {
    return {

      dialogData: {
        visable: false,
        header: "invite contributors",
        icon_name: "contributor"
      }
    }
  },

  methods: {
    toggleVisibility(){
      this.dialogData.visable = !this.dialogData.visable;
    }
    
  }
  
}
</script>