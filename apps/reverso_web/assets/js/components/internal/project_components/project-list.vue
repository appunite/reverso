<template>	
	<div id="project-list"> 

		<div id="add">
			MY PROJECTS ({{ projects.length }})
			<newProject></newProject>
		</div>
		

		<el-collapse v-model="activeNames" @change="handleChange">
			<el-collapse-item v-for="(project, key) in projects" :title="project.title" :name="key">
				<projectItem v-bind:project="project"></projectItem>
		  </el-collapse-item>
		</el-collapse>
		
	</div>
</template>

<script>
import projectItem from './project-item.vue'
import newProject from './new-project.vue'
import editProject from './edit-project.vue'

export default {
	name: "projectList",

	components: {
		'projectItem': projectItem,
		'newProject': newProject,
		'editProject': editProject
	},

	data () {
		return {
			activeNames: ['1'],
			projects: [],
			dummy_projects: [
				{ id: 1, name: "Super Wooper App", transls: [] },
				{ id: 2, name: "Scooby Dooby Do App", transls: [] },
				{ id: 3, name: "Pika Pika App", transls: [] }
			]

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
       		alert("Oops! Something went wrong!");
       	}
      )
		}
	},

	created(){
		this.fetchProjects();
	}

}
</script>
