<template>  
  <div class="project-list"> 

    <div class="top-table-panel-projects">
      <span class="top-table-panel-projects-col">
        MY PROJECTS ({{ projects.length }})
        <newProject
          v-on:project_added="addProject($event)">
        </newProject>
      </span>

      <span>
        <input class="search-input"
        placeholder="Search..."
        v-model="project_filter"
        @keyup="debouncedFetch()">
      </span>
    </div>
    

    <el-collapse v-model="activeNames">
      <el-collapse-item v-for="project in projects"
      :key="project.project_id">
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
      projects: [],
      project_filter: ""
    }
  },

  methods: {
    addProject(project){
      this.projects.push(project);
    },

    fetchProjects(){
      projectService.fetchProjects(this.project_filter).then(
        (response) => {
          this.projects = response.data.data;
        },

        (error) => {
          console.log(error);
        }
      );
    },

    debouncedFetch: _.debounce(function() {
      this.fetchProjects();
    }, 250)
  },

  mounted(){
    this.fetchProjects();

    this.$bus.$on('project_edited', (edited_project) => {
      let index = _.findIndex(this.projects, (project) => {
        return project.id == edited_project.id;
      });

      this.projects[index].project_name = edited_project.project_name;  
      this.projects[index].basic_language = edited_project.basic_language;  
      this.projects[index].platforms = edited_project.platforms;
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