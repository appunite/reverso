<template>	
	<div id="project-item">
	
		<div v-for="translation in translations">
			{{ translation.lang }}

			<exportSettings></exportSettings>
		</div>
		<div>
			<newLanguage></newLanguage>

		</div>

	</div>
</template>

<script>
import newLanguage from './actions/new-language.vue'
import exportSettings from './export-settings.vue'

export default {
	name: "project-item",

	props: [
		'project'
	],

	components: {
		'newLanguage': newLanguage,
		'exportSettings': exportSettings
	},

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

		fetchLanguages(project_id) {
			this.$http.get("/api/projects/" + project_id + "/languages", {}).then(
        (response) => {
					console.log(response.body.data);
				},
     		(error) => {
       	}
      )
      this.translations = this.dummy_trans; 
		}
	},
	
	created(){
		this.fetchLanguages(1);
	}
}

</script>