<template>  
  <div class="project-list"> 

    <div class="top-table-panel">
      MY PROJECTS ({{ projects.length }})
      <newProject
      v-on:project_added="addProject($event)"
      ></newProject>
    </div>
    

    <el-collapse v-model="activeNames">
      <el-collapse-item v-for="(project, key) in projects" :name="key">
        <template slot="title">
          <projectListHeader v-bind:project="project"></projectListHeader>
        </template>
        <projectItem v-bind:project="project"></projectItem>
      </el-collapse-item>
    </el-collapse>
    
  </div>
</template>

<script>
import projectListHeader from './project-list-header.vue'
import projectItem from './project-item.vue'
import newProject from './actions/new-project.vue'

export default {
  name: "projectList",

  components: {
    'projectListHeader': projectListHeader,
    'projectItem': projectItem,
    'newProject': newProject
  },

  data () {
    return {
      projects: []
    }

  },

  methods: {
    fetchProjects(){

      this.$http.get("/api/projects", {}).then(
        (response) => {
          console.log(response.data.data);
          this.projects = response.data.data;
        },
        (error) => {
          console.log(error);
        }
      )
    },

    addProject(project){
      this.projects.push(project);
    }
  },

  mounted(){
    this.fetchProjects();

    this.$bus.$on('project_deleted', (deleted_project) => {
      
      let index = _.findIndex(this.projects, (project) => {
        return project.id == deleted_project.id;
      });

      this.projects.splice(index, 1);
    });
  }

}
</script>