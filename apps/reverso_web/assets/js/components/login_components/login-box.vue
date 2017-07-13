<template>
  <div id="login-box">

    <h3>{{ message }}</h3>

    <form>

      Email:<br>
      <input type="text" v-model="email" placeholder="Email"><br>

      Password:<br>
      <input type="password" v-model="password" placeholder="Password"><br>
      
      <p v-if="wrong_pass" id="passAlert">Wrong password. <router-link to="/lost-password">Forgot password?</router-link></p>

      <button v-on:click.prevent="login">Log in</button>
      <p id="lostPassMild"><router-link to="/lost-password">Can't log in?</router-link></p>
    </form>
 </div>
</template>

<script>
export default {
	name: "LoginBox",
  
	data() {
		return {
      message: "It's nice to see you again!",
      wrong_pass: false,

      dummy_user: {
        email: "foo@bar.com",
        password: "abcdef"
      },
      email: "",
      password: ""
		} 
	},

  methods: {
    login: function(){

    }
  }

}
</script>

<style>

  #login-box {
    /*margin: 140px auto auto auto;*/
    border: solid;
    margin-top: 20px;
  }
  

  #lostPassMild {
    color: lightgray;
  }

  #passAlert {  
    color: red;
    text-align: left;
  }

</style>

