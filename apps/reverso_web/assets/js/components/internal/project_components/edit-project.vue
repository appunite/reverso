<template>
<span>
    <button id="dialogVisable" @click="dialogData.visable = true">Edit project</button>
    <projectDialog v-bind:dialogData="dialogData" v-if="dialogData.visable" @close="dialogData.visable = false">
        
    </projectDialog>
</span>
</template>

<script>
import projectDialog from '../session_components/modals/project-dialog.vue'

export default {
  name: "editProject",

  components: {
    'projectDialog': projectDialog
  },

  data () {
    return {

      dialogData: {
        visable: false,
        header: "project settings",
        icon: "/images/ic-settings.svg",
        delete_btn: true,

        project: {
          title: "elo",
          ref_lang: "English",
          platforms: ["Android"]
        }
      }

    }
  }
}
</script>