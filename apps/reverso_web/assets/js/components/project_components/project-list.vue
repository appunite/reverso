<template>	
	<div id="project-list"> 

		<div id="add">
			MY PROJECTS ({{ projects.length }})
			<newProject></newProject>
		</div>
		<ul>
			<li v-for="project in projects">
				<projectItem v-bind:project="project"></projectItem>
			</li>

		</ul>

	</div>
</template>

<script>
import projectItem from './project-item.vue'
import newProject from './new-project.vue'


export default {
	name: "projectList",

	components: {
		'projectItem': projectItem,
		'newProject': newProject
	},

	data () {
		return {
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

<style>
	#project-list {
		margin: 30px;
		width: 100%;
		border: solid;
	}

</style>