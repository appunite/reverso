<template>	
	<div id="project-item">
		<div v-for="translation in translations">
			{{ translation.lang }}
			
		</div>

	</div>


	<!-- <div id="project-item"> 
		<div class="dropdown" v-on:click="!translations_fetched ? project.transls = fetchTranslations(project.id) : null">
			<button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown">
			<span class="caret"></span>{{ project.title }}</button>
			<ul class="dropdown-menu" style="position: relative;">
				<li v-for="tran in project.transls">{{ tran.lang }}</li>
				<li><a href="#">add new language</a></li>
			</ul>
		</div>
	</div> -->
</template>

<script>
export default {
	props: [
		'project'
	],

	data () {
		return {
			translations: [],

			dummy_trans: [
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

		fetchTranslations(project_id) {
			// this.$http.get("/api/projects/" + project_id, {}).then(
   //      (response) => {
				
			// 	},
   //   		(error) => {
   //     	}
   //    )
      this.translations = this.dummy_trans; 
		}
	},
	
	created(){
		this.fetchTranslations(1);
		console.log("eeeeeeeooooooo");
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