<template>
	<div>
		<navPanel></navPanel>
		<router-view></router-view>
	</div>
</template>

<script>
import navPanel from '../session_components/nav-panel'

export default {
	name: "sessionPanel",

	components: {
		'navPanel': navPanel			
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
