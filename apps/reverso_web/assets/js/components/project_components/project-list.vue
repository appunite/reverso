<template>	
	<div id="project-list"> 

		<div id="add">
			MY PROJECTS ({{ projects.length }}) ADD NEW PROJECT
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

export default {
	components: {
		'projectItem': projectItem
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
		fetchProjects: function (user_id) {
			return this.dummy_projects;
		}
	},

	created(){
		this.projects = this.fetchProjects(1);
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