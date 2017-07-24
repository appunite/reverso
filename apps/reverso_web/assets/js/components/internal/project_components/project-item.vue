<template>	
	<div class="project-item">
	
		<div v-for="translation in translations">
			<span class="summary">
				<span class="summary-col-1">
					{{ translation.language_name }}
				</span>

				<span class="summary-col-2">
					{{ translation.count }} strings translated
				</span>

				<span class="summary-col-3" v-if="translation.last_edit">
					{{ translation.last_edit }} last edit by {{ translation.editor }}
				</span>
		
				<span class="summary-col-4">
					<exportSettings></exportSettings>
				</span>
			</span>

		</div>
		<div class="add-language">
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
		}
	},
	
	methods: {

		fetchLanguages(project_id) {
			this.$http.get("/api/projects/" + project_id + "/languages", {}).then(
				(response) => {
					this.translations = response.body.data;
				},
				(error) => {
				}
			)
		}
	},
	
	mounted(){
		this.fetchLanguages(this.project.id);

	}
}

</script>