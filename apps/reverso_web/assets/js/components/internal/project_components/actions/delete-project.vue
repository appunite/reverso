<template>
  <span>
    <el-button  class="delete-btn" @click="toggleVisibility">
      <slot>
        Delete
      </slot>
    </el-button>
 
    <deleteDialog 
      v-bind:dialogData="dialogData"
      v-if="dialogData.visable" 
      v-on:confirm="deleteProject"
      @close="toggleVisibility">
        
    </deleteDialog>
  </span>
</template>

<script>
import projectService from '../../../../services/project-service.js'
import deleteDialog from '../dialogs/delete-dialog.vue'

export default{
  name: "deleteProject",

  props: [
    'project'
  ],

  components: {
    'deleteDialog': deleteDialog
  },

  data () {
    return {
      dialogData: {
        visable: false,
        deletionObject: "project"
      }
    }
  },

  methods: {
    deleteProject(){
      projectService.deleteProject(this.project).then(
        (response) => {
          this.$bus.$emit('project_deleted', this.project);

          this.$message({
            message: 'Delete completed.',
            type: 'success'
          });
        },

        (error) =>{
          console.log(error);
        }
      )
      //this.$emit('close');
    },

    toggleVisibility(){
      this.dialogData.visable = !this.dialogData.visable;
    }
  }
}
</script>
