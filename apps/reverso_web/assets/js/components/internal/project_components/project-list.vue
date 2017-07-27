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
import projectService from '../../../services/project-service.js'
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
    addProject(project){
      this.projects.push(project);
    }
  },

  mounted(){
    projectService.fetchProjects().then(
      (response) => {
        this.projects = response.data.data;
      },

      (error) => {
        console.log(error);
      }
    );

    this.$bus.$on('project_edited', (edited_project) => {
      console.log(edited_project);
      let index = _.findIndex(this.projects, (project) => {
        return project.id == edited_project.id;
      });

      this.projects[index].project_name = edited_project.project_name;
      this.projects[index].basic_language = edited_project.basic_language;
      this.projects[index].platforms = edited_project.platforms;
      console.log(this.projects);
    });

    this.$bus.$on('project_deleted', (deleted_project) => {
      
      let index = _.findIndex(this.projects, (project) => {
        return project.id == deleted_project.id;
      });

      this.projects.splice(index, 1);
    });
  }

}
</script>