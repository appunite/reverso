<template>	
	<div id="project-list"> 

		<div id="add">
			MY PROJECTS ({{ projects.length }})
			<newProject></newProject>
		</div>
		

		<el-collapse v-model="activeNames">
			<el-collapse-item v-for="(project, key) in projects" :name="key">
				<template slot="title">
					{{ project.project_name }}

					<newContributor></newContributor>
					<exportSettings></exportSettings>
					<editProject v-bind:project="project"></editProject>
				</template>
				<projectItem v-bind:project="project"></projectItem>
			</el-collapse-item>
		</el-collapse>
		
	</div>
</template>

<script>
import projectItem from './project-item.vue'
import newProject from './actions/new-project.vue'
import newContributor from './actions/new-contributor.vue'
import exportSettings from './export-settings.vue'
import editProject from './actions/edit-project.vue'

export default {
	name: "projectList",

	components: {
		'projectItem': projectItem,
		'newProject': newProject,
		'newContributor': newContributor,
		'exportSettings': exportSettings,
		'editProject': editProject
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
