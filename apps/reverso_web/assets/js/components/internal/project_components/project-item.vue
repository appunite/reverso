<template>	
	<div id="project-item"> 
		<div class="dropdown" v-on:click="!translations_fetched ? project.transls = fetchTranslations(project.id) : null">
			<button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown">
			<span class="caret"></span>{{ project.title }}</button>
			<ul class="dropdown-menu" style="position: relative;">
				<li v-for="tran in project.transls">{{ tran.lang }}</li>
				<li><a href="#">add new language</a></li>
			</ul>
		</div>
	</div>
</template>

<script>
export default {
	props: [
		'project'
	],

	data () {
		return {
			translations_fetched: false,

			trans: [
				{
					lang: "portugese",
					str: "300/300",
					last_edit: "Mickey Mouse"
				},
				{
					lang: "french",
					str: "136/300",
					last_edit: "Whatever"
				},
				{
					lang: "italian",
					str: "13/300",
					last_edit: "Donkey Kong"
				}
			]

		}
	},
	methods: {
		fetchTranslations: function (project_id) {
			this.translations_fetched = true;
			return this.trans;
		}
	}
	

}
</script>
<style>
/*
#project-item {
	margin: 30px;
	width: 100%;
	border: solid;
}
*/
</style>