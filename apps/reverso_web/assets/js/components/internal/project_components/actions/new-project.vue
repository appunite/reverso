  <template>
  <span>
    <el-button type="text" id="dialogVisable"  @click="dialogParams.visable = true">
      <img :src="dialogParams.icon">Add new project

    </el-button>
    <projectDialog
    v-bind:dialogParams="dialogParams"
    v-if="dialogParams.visable" 
    @close="dialogParams.visable = false;">        
    </projectDialog>
  </span>
</template>

<script>
import projectDialog from '../dialogs/project-dialog.vue'

export default {
  name: "newProject",

  components: {
    'projectDialog': projectDialog
  },

  data () {
    return {

      dialogParams: {
        visable: false,
        header: "new project",
        icon: "/images/ic-add.svg",
        delete_btn: false,
        url: "api/projects",
        bus_event: 'project_added',

        project: {
          project_name: "",
          basic_language: "",
          platforms: []
        }
      }

    }
  }
}
</script>