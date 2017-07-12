<template>
<div>
<navPanel></navPanel>
<projectList></projectList>
</div>
</template>

<script>
import navPanel from './nav-panel'
import projectList from './project-list'

	export default {
		// name: "activeSession",
		components: {
			'navPanel': navPanel,
			'projectList': projectList
		},

		data () {
			return {
			}
		}
	}
</script>

<style>
	#add {
		margin: 30px;
		width: 100%;
		border: solid;
	}
</style>
