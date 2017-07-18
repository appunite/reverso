<template>
<span>
    <button id="dialogVisable" class="add_sth_btn" @click="dialog_data.visable = true">Add new project</button>
    <projectDialog v-if="dialog_data.visable" @close="dialog_data.visable = false">
        
    </projectDialog>
</span>
</template>

<script>
import projectDialog from '../session_components/modals/project-dialog.vue'

export default {
  name: "newProject",

  components: {
    'projectDialog': projectDialog
  },

  data () {
    return {

      dialog_data: {
        visable: false,
        d_header: "new project",
        delete_btn: true,

        project: {
          title: "",
          ref_lang: "",
          platforms: []
        }
      }

    }
  }
}
</script>