  <template>
  <span>
    <el-button type="text" class="add_sth_btn" id="dialogVisable"  @click="dialogParams.visable = true">
      <img :src="dialogParams.icon">Add new project

    </el-button>
    <projectDialog
    v-bind:dialogParams="dialogParams"
    v-if="dialogParams.visable" 
    v-on:submit="createProject($event)"
    @close="dialogParams.visable = false">        
    </projectDialog>
  </span>
</template>

<script>
import projectService from '../../../../services/project-service.js'
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
  },

  methods: {
    createProject(project){
        this.$http.post(this.dialogParams.url, project).then(
          (response) => {
            let resp_project = projectService.process(response);
            this.$emit(this.dialogParams.bus_event, resp_project);
          },
          (error) => {
            console.log(error);
          }
        )
      },
  }
}
</script>