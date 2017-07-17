<template>
  <div id="new-user-box">

    <h3>Register</h3>

    <form>

      Email:<br>
      <input type="text" v-model="email" placeholder="Email"><br>
      
      Name:<br>
      <input type="text" v-model="name" placeholder="Name"><br>

      Password:<br>
      <input type="password" v-model="password" placeholder="Password"><br>
      
      <button v-on:click.prevent="signIn">Sign In</button>
    </form>
 </div>
</template>

<script>
export default {
	name: "NewUserBox",
	data() {
		return {
      message: "It's nice to see you again!",
      error: false,

      dummy_user: {
        email: "foo@bar.com",
        name: "asdfgh",
        password: "abcdef"
      },
      email: "",
      password: "",
      name: ""
		} 
	},

  methods: {
    signIn: function(){

    }
  }

}
</script>

<style>
/*
  #new-user-box {
    border: solid;
    margin-top: 20px;
  }
*/
</style>

