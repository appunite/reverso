<template>	
	<div id="project-item">
	
		<div v-for="translation in translations">
			{{ translation.lang }}
    	  	<img src="/images/ic-export.svg">

		</div>

	</div>
</template>

<script>
export default {
	name: "project-item",

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
	}
}

</script>