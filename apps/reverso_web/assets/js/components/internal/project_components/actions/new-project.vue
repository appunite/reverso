  <template>
  <span>
    <el-button type="text"
    class="add_sth_btn top-table-panel-projects__add"
    id="dialogVisable"
    @click="toggleVisibility">

      <icon
        v-bind:imageName="dialogParams.icon_name"
        v-bind:className='icon_class'
        color="#5F69EF">  
      </icon>
      Add new project

    </el-button>
    <projectDialog
    v-bind:dialogParams="dialogParams"
    v-if="dialogParams.visable" 
    v-on:submit="createProject($event)"
    @close="toggleVisibility">        
    </projectDialog>
  </span>
</template>

<script>
import projectService from '../../../../services/project-service.js'
import languageService from '../../../../services/language-service.js'
import projectDialog from '../dialogs/project-dialog.vue'
import icon from '../../../../icons.vue'

export default {
  name: "newProject",

  components: {
    'projectDialog': projectDialog,
    'icon': icon
  },

  data () {
    return {
      icon_class: "icon-gray",

      dialogParams: {
        visable: false,
        header: "new project",
        icon: "/images/ic-add.svg",
        icon_name: "add",
        delete_btn: false,
        new_lang_allowed: true,

        project: {
          project_name: "",
          basic_language: "",
          platforms: []
        },

        languages: []
      }

    }
  },

  methods: {
    createProject(project){
      projectService.createProject(project).then(
        (response) => {
          let resp_project = projectService.process(response);
          this.$emit('project_added', resp_project);
        },
        (error) => {
          console.log(error);
        }
      )
    },

    toggleVisibility(){
      this.dialogParams.visable = !this.dialogParams.visable;
    }
  },

  mounted(){
    languageService.fetchLanguages().then(
      (response) => {
        this.dialogParams.languages = response.data.data;
      },
      (error) => {
        console.log(error);
      });
  }
}
</script>