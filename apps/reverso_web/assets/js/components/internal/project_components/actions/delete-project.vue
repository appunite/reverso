<template>
  <el-button  class="delete-btn" @click="open2">Delete</el-button>  
</template>

<script>
import projectService from '../../../../services/project-service.js'
  
export default{
  name: "deleteProject",

  props: [
    'project'
  ],

  methods: {
    open2() {
      this.$confirm('This will permanently delete the file. Continue?', 'Warning', {
        confirmButtonText: 'OK',
        cancelButtonText: 'Cancel',
        type: 'warning'
      }).then(() => {
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
