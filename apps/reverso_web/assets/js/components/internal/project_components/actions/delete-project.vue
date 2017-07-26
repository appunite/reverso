<template>
  <el-button  class="delete-btn" @click="deleteWarning">Delete</el-button>  
</template>

<script>
import projectService from '../../../../services/project-service.js'
  
export default{
  name: "deleteProject",

  props: [
    'project'
  ],

  methods: {
    deleteWarning() {
      this.$confirm('This will permanently delete the project. Continue?', 'Warning', {
        confirmButtonText: 'OK',
        confirmButtonClass: 'primary-btn',
        cancelButtonText: 'Cancel',
        cancelButtonClass: 'cancel-btn',
        showClose: false
      }).then(() => {
        this.deleteProject();
        this.$message({
          type: 'success',
          message: 'Delete completed'
        });
      }).catch(() => {
        this.$message({
          type: 'info',
          message: 'Delete canceled'
        });          
      });
    },

    deleteProject(){
      projectService.deleteProject(this.project).then(
        (response) => {
          this.$bus.$emit('project_deleted', this.project);
        },

        (error) =>{
          console.log(error);
        }
      )
      this.$emit('close');
    }
  }


}
</script>
