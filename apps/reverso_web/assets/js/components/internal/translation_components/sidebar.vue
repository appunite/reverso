<template>	
<div v-if="isCollapse" >
	<button @click="isCollapse=!isCollapse" style="width: 50px;">t</button>
</div>
<div v-else >
	<button @click="isCollapse=!isCollapse" style="width: 200px;">t</button>
</div>

</template>

<script>

export default {
	name: "sidebar",

	data () {
		return {
      isCollapse: false
		}
	},

	computed: {
    language_id(){
      return this.$route.params.language_id;
    },

    project_id(){
      return this.$route.params.project_id;
    }
  },

	mounted (){
		//project show request
	} 
}
	
</script>
