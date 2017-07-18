<template>
	<div>
		<navPanel></navPanel>
		<router-view></router-view>
	</div>
</template>

<script>
import navPanel from './session_components/nav-panel'

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
