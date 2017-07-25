<template>	
	<div class="project-list"> 

		<div class="add-project">
			MY PROJECTS ({{ projects.length }})
			<newProject></newProject>
		</div>
		

		<el-collapse v-model="activeNames">
			<el-collapse-item v-for="(project, key) in projects" :name="key">
				<template slot="title">
					<projectListHeader v-bind:project_name="project.project_name"></projectListHeader>
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
			activeNames: ['1'],
			projects: []
		}

	},

	methods: {
		fetchProjects(){

			this.$http.get("/api/projects", {}).then(
				(response) => {
					this.projects = response.data.data;
				},
				(error) => {
					//alert("Oops! Something went wrong!");
				}
			)
		}
	},

	mounted(){
		this.fetchProjects();

    this.$bus.$on('project_added', (resp) => {
    	this.projects.push(resp);
    });
  }

}
</script>