<template>
	  <div id="account-box">

    <form>
      Name<br>
      <input type="text" v-model="name" readonly><br>

      Email Address<br>
      <input type="text" v-model="email" readonly><br>

			Password
			<input type="password" v-model="password" readonly><br>
      
      <button v-on:click.prevent="editProfile">Edit Profile</button>&nbsp;
			<button v-on:click.prevent="editPassword">Change Password</button>
      
    </form>
 </div>
</template>

<script>
export default {
	name: "seeProfile",
  
	data() {
		return {
			userId: 1,
			name: '',
			email: '',
			password: '*********'
		} 
	},

	methods: {
		editProfile(){
			this.$router.push("/edit-profile")
		},
		editPassword(){
			this.$router.push("/edit-pass")
		}
	},

  mounted() { 
		var address = "/api/accounts/" + this.userId;
		console.log(address);
      this.$http.get(address, {}).then(
        (response) => {
          this.name = response.data.data.name;
					this.email = response.data.data.email;
        },
        (error) => {
          alert("Oops! Something went wrong!");
        }
      )
  }

}
</script>

<style>
</style>